// base
const htmlClass = document.documentElement.classList;

// dark theme
const themeColorTag = document.querySelector('meta[name="theme-color"]');
const applyDark = (isDark) => {
  if (isDark) {
    htmlClass.add("dark");
    themeColorTag?.setAttribute("content", themeColorTag.dataset.dark);
    document.body?.dispatchEvent(new CustomEvent("set-theme", { detail: "dark" }));
  } else {
    htmlClass.remove("dark");
    themeColorTag?.setAttribute("content", themeColorTag.dataset.light);
    document.body?.dispatchEvent(new CustomEvent("set-theme", { detail: "light" }));
  }
};

function loaded() {
  // mobile menu
  const btnMenu = document.querySelector(".btn-menu");
  btnMenu?.addEventListener("click", () => {
    htmlClass.toggle("open");
  });

  // manual switch
  const btnDark = document.querySelector(".btn-dark");
  btnDark?.addEventListener("click", () => {
    const isDark = !htmlClass.contains("dark");
    applyDark(isDark);
    localStorage.setItem("dark", isDark ? "dark" : "light");
  });

  htmlClass.remove("not-ready");
}

// init
const darkScheme = window.matchMedia("(prefers-color-scheme: dark)");
const darkVal = localStorage.getItem("dark");
if (darkVal) {
  applyDark(darkVal === "dark");
} else if (htmlClass.contains("dark")) {
  applyDark(true);
} else {
  applyDark(darkScheme.matches);
}

// listen system
darkScheme.addEventListener("change", (event) => {
  applyDark(event.matches);
});

if (document.readyState === "loading") {
  window.addEventListener("DOMContentLoaded", loaded);
} else {
  loaded();
}
