const htmlClass = document.documentElement.classList;
const themeColorTag = document.head.querySelector('meta[name="theme-color"]');

function applyDark(isDark, doDispatchEvent) {
  if (isDark) {
    htmlClass.add("dark");
    themeColorTag?.setAttribute("content", themeColorTag.dataset.dark);
  } else {
    htmlClass.remove("dark");
    themeColorTag?.setAttribute("content", themeColorTag.dataset.light);
  }
  if (doDispatchEvent) {
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
  htmlClass.remove("not-ready");

  const btnSearch = document.querySelector(".btn-search");
  btnSearch?.addEventListener("click", () => {
    if (typeof (linkitaSearch) === "undefined") {
      console.error("window.linkitaSearch is undefined");
    } else {
      window.linkitaSearch();
    }
  });

  let userLanguages = [];
  if (navigator.languages) {
    userLanguages = navigator.languages;
  } else if (navigator.language) {
    userLanguages = [navigator.language];
  } else if (navigator.userLanguage) {
    userLanguages = [navigator.userLanguage];
  }
  const pageLanguage = document.documentElement.getAttribute("lang");
  const btnTranslations = document.querySelector(".btn-translations");
  if (btnTranslations) {
    for (let i = 0; i < userLanguages.length; i++) {
      const userLanguage = userLanguages[i];
      if (userLanguage === pageLanguage) continue;
      const pageTranslations = document.head.querySelector(
        "link[rel='alternate'][hreflang^='" + userLanguage.split("-")[0] + "']");
      if (pageTranslations) {
        btnTranslations.classList.remove("hidden");
        btnTranslations.addEventListener("click", () => {
          window.location.href = pageTranslations.getAttribute("href");
        });
        break;
      }
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
