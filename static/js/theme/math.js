zolaTheme.katex = {

  init: function () {
    document.addEventListener("DOMContentLoaded", this.act)
  },

  act: function () {
    window.renderMathInElement(document.body, {
      delimiters: [
        { left: "$$", right: "$$", display: true },
        { left: "$", right: "$", display: false },
      ],
      throwOnError: false,
    })
  },

}
