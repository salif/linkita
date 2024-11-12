"use strict";
(function () {
  const htmlClass = document.documentElement.classList;
  const themeColorTag = document.head.querySelector('meta[name="theme-color"]');

  function applyDarkMode(isDark, doDispatchEvent) {
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

  function initDarkMode() {
    const darkScheme = window.matchMedia("(prefers-color-scheme: dark)");
    const darkVal = localStorage.getItem("dark");
    if (darkVal) {
      applyDarkMode(darkVal === "dark", false);
    } else if (htmlClass.contains("dark")) {
      applyDarkMode(true, false);
    } else {
      applyDarkMode(darkScheme.matches, false);
    }

    darkScheme.addEventListener("change", (event) => {
      applyDarkMode(event.matches, true);
    });

    htmlClass.remove("not-ready");
  }

  function toggleDarkMode() {
    const isDark = !htmlClass.contains("dark");
    applyDarkMode(isDark, true);
    localStorage.setItem("dark", isDark ? "dark" : "light");
  }

  function initTranslationsButton(btn) {
    let userLanguages = [];
    if (navigator.languages) {
      userLanguages = navigator.languages;
    } else if (navigator.language) {
      userLanguages = [navigator.language];
    } else if (navigator.userLanguage) {
      userLanguages = [navigator.userLanguage];
    }
    const pageLanguage = document.documentElement.getAttribute("lang");
    for (let i = 0; i < userLanguages.length; i++) {
      const userLanguage = userLanguages[i];
      if (userLanguage === pageLanguage) continue;
      const pageTranslations = document.head.querySelector(
        "link[rel='alternate'][hreflang^='" + userLanguage.split("-")[0] + "']");
      if (pageTranslations) {
        btn.classList.remove("hidden");
        btn.addEventListener("click", () => {
          window.location.href = pageTranslations.getAttribute("href");
        });
        break;
      }
    }
  }

  function toggleHeaderMenu() {
    htmlClass.toggle("open");
  }

  function initKatex() {
    window.renderMathInElement(document.body, {
      // customised options
      // • auto-render specific keys, e.g.:
      delimiters: [
        { left: "$$", right: "$$", display: true },
        { left: "$", right: "$", display: false },
      ],
      // • rendering keys, e.g.:
      throwOnError: false,
    })
  }

  function main() {
    initDarkMode();

    window.linkita = {
      applyDarkMode: applyDarkMode,
      toggleDarkMode: toggleDarkMode,
      initTranslationsButton: initTranslationsButton,
      toggleHeaderMenu: toggleHeaderMenu,
      initKatex: initKatex,
    };
  }

  main();
})();
