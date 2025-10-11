zolaTheme.color = {
  Key: "theme-color-scheme",
  DarkPrefName: "dark",
  LightPrefName: "light",
  DarkClass: "dark",
  EventName: "set-theme",

  init: function () {
    this.HtmlClass = document.documentElement.classList
    this.ThemeColorTag = document.head.querySelector('meta[name="theme-color"]')
    this.BrowserDarkPref = window.matchMedia("(prefers-color-scheme: dark)")

    // DarkPrefName or LightPrefName
    const savedPref = localStorage.getItem(this.Key)

    if (savedPref) {
      this.applyMode({ applyDark: savedPref === this.DarkPrefName, doEvent: false })
    } else {
      this.applyMode({ applyDark: this.BrowserDarkPref.matches, doEvent: false })
    }

    this.BrowserDarkPref.addEventListener("change", function (event) {
      zolaTheme.color.applyMode({ applyDark: event.matches, doEvent: true })
    })

    this.HtmlClass.remove("not-ready")
  },

  applyMode: function ({ applyDark, doEvent }) {
    if (applyDark) {
      this.HtmlClass.add(this.DarkClass)
    } else {
      this.HtmlClass.remove(this.DarkClass)
    }
    if (undefined != this.ThemeColorTag) {
      this.ThemeColorTag.setAttribute("content", applyDark ?
        this.ThemeColorTag.dataset.dark : this.ThemeColorTag.dataset.light)
    }
    if (doEvent && undefined != document.body) {
      document.body.dispatchEvent(
        new CustomEvent(this.EventName, {
          detail: applyDark ? this.DarkPrefName : this.LightPrefName
        })
      )
    }
  },

  toggle: function () {
    const newMode = !this.HtmlClass.contains(this.DarkClass)
    this.applyMode({ applyDark: newMode, doEvent: true })
    localStorage.setItem(this.Key, newMode ? this.DarkPrefName : this.LightPrefName)
  },

  reset: function () {
    localStorage.removeItem(this.Key)
    this.applyMode({ applyDark: this.BrowserDarkPref.matches, doEvent: true })
  },

}

zolaTheme.color.init()
