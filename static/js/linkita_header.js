// base
const htmlClass = document.documentElement.classList;

// dark theme
const themeColorTag = document.head.querySelector('meta[name="theme-color"]');

function applyDark(isDark, dEvent) {
  if (isDark) {
    htmlClass.add("dark");
    themeColorTag?.setAttribute("content", themeColorTag.dataset.dark);
  } else {
    htmlClass.remove("dark");
    themeColorTag?.setAttribute("content", themeColorTag.dataset.light);
  }
  if (dEvent) {
    document.body?.dispatchEvent(new CustomEvent("set-theme",
      { detail: isDark ? "dark" : "light" }));
  }
}

function onDCLoad() {
  // mobile menu
  const btnMenu = document.querySelector(".btn-menu");
  btnMenu?.addEventListener("click", () => {
    htmlClass.toggle("open");
  });

  const btnDark = document.querySelector(".btn-dark");
  btnDark?.addEventListener("click", () => {
    const isDark = !htmlClass.contains("dark");
    applyDark(isDark, true);
    localStorage.setItem("dark", isDark ? "dark" : "light");
  });

  const btnSearch = document.querySelector(".btn-search");
  btnSearch?.addEventListener("click", () => {
    if (typeof (linkitaSearch) === "undefined") {
      console.error("window.linkitaSearch is undefined");
    } else {
      window.linkitaSearch();
    }
  });

  htmlClass.remove("not-ready");

  const btnTranslations = document.querySelector(".btn-translations");
  const userLanguage = navigator.language || navigator.userLanguage;
  if (userLanguage && btnTranslations) {
    const userLanguageCode = userLanguage.split("-")[0];
    const pageTranslations = document.head.querySelector(
      "link[rel='alternate'][hreflang^='" + userLanguageCode + "']");
    if (pageTranslations && userLanguageCode !== document.documentElement.getAttribute("lang")) {
      btnTranslations.classList.remove("hidden");
      btnTranslations.addEventListener("click", () => {
        window.location.href = pageTranslations.getAttribute("href");
      })
    }
  }
}

// init
const darkScheme = window.matchMedia("(prefers-color-scheme: dark)");
const darkVal = localStorage.getItem("dark");
if (darkVal) {
  applyDark(darkVal === "dark", false);
} else if (htmlClass.contains("dark")) {
  applyDark(true, false);
} else {
  applyDark(darkScheme.matches, false);
}

// listen system
darkScheme.addEventListener("change", (event) => {
  applyDark(event.matches, true);
});

if (document.readyState === "loading") {
  window.addEventListener("DOMContentLoaded", onDCLoad);
} else {
  onDCLoad();
}
