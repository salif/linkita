"use strict";
(function () {
  const htmlClass = document.documentElement.classList;
  const themeColorTag = document.head.querySelector('meta[name="theme-color"]');
  const darkScheme = window.matchMedia("(prefers-color-scheme: dark)");

  function applyDarkMode(isDark, doDispatchEvent) {
    if (isDark) {
      htmlClass.add("dark");
    } else {
      htmlClass.remove("dark");
    }
    if (undefined != themeColorTag) {
      themeColorTag.setAttribute("content", isDark ?
        themeColorTag.dataset.dark : themeColorTag.dataset.light);
    }
    if (doDispatchEvent && undefined != document.body) {
      document.body.dispatchEvent(new CustomEvent("set-theme",
        { detail: isDark ? "dark" : "light" }));
    }
  }

  function initDarkMode() {
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

  function resetDarkMode() {
    localStorage.removeItem("dark");
    applyDarkMode(darkScheme.matches, true);
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
    const pageTranslations = new Map();
    document.head.querySelectorAll("link[rel='alternate'][hreflang]").forEach(el => {
      const hreflang = el.getAttribute("hreflang");
      const href = el.getAttribute("href");
      if (hreflang !== pageLanguage) {
        pageTranslations.set(hreflang, href);
        const hreflangcode = hreflang.split("-")[0];
        if (!pageTranslations.has(hreflangcode)) {
          pageTranslations.set(hreflangcode, href);
        }
      }
    });
    for (let i = 0; i < userLanguages.length; i++) {
      const userLanguage = userLanguages[i];
      const pageTranslation = pageTranslations.get(userLanguage) ||
        pageTranslations.get(userLanguage.split("-")[0]);
      if (undefined != pageTranslation) {
        btn.classList.remove("hidden");
        btn.addEventListener("click", () => {
          window.location.href = pageTranslation;
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

  function enableAnalytics(key) {
    return localStorage.removeItem(key)
  }

  function disableAnalytics(key) {
    return localStorage.setItem(key, "t")
  }

  function isAnalyticsEnabled(key, init) {
    if (init) {
      if (window.location.hash === "#enable-analytics") {
        if (localStorage.getItem(key) === 't') {
          enableAnalytics(key);
          alert("Analytics is now ENABLED in this browser. To disable analytics, load #disable-analytics.");
        }
      } else if (window.location.hash === "#disable-analytics") {
        if (localStorage.getItem(key) !== 't') {
          disableAnalytics(key);
          alert("Analytics is now DISABLED in this browser. To enable analytics, load #enable-analytics.");
        }
      }
    }
    return localStorage.getItem(key) !== 't'
  }

  function initGoatCounterAnalytics(src, endpoint) {
    if (isAnalyticsEnabled("skipgc", true)) {
      const newScript = document.createElement("script");
      newScript.async = true;
      newScript.src = src;
      newScript.dataset.goatcounter = endpoint;
      if (undefined != document.body) {
        document.body.appendChild(newScript);
      } else if (undefined != document.head) {
        document.head.appendChild(newScript);
      }
    }
  }

  function initVercelAnalytics(src) {
    if (isAnalyticsEnabled("va-disable", true)) {
      if (undefined == window.va) {
        window.va = function () {
          (window.vaq = window.vaq || []).push(arguments);
        };
      }
      const newScript = document.createElement("script");
      newScript.async = true;
      newScript.src = src;
      if (undefined != document.body) {
        document.body.appendChild(newScript);
      } else if (undefined != document.head) {
        document.head.appendChild(newScript);
      }
    }
  }

  function main() {
    initDarkMode();

    window.linkita = {
      applyDarkMode: applyDarkMode,
      toggleDarkMode: toggleDarkMode,
      resetDarkMode: resetDarkMode,
      initTranslationsButton: initTranslationsButton,
      toggleHeaderMenu: toggleHeaderMenu,
      initKatex: initKatex,
      isAnalyticsEnabled: isAnalyticsEnabled,
      enableAnalytics: enableAnalytics,
      disableAnalytics: disableAnalytics,
      initGoatCounterAnalytics: initGoatCounterAnalytics,
      initVercelAnalytics: initVercelAnalytics,
    };
  }

  main();
})();
