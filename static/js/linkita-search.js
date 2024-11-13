"use strict";
(function () {
  let elasticlunrFileName;
  let searchIndexFileName;
  let mySearchIndex;

  function toggleSearch() {
    const searchWrapperEl = document.getElementById("linkita-search-wrapper");
    const searchResultsEl = document.getElementById("linkita-search-results");
    if (null == searchWrapperEl || null == searchResultsEl) {
      console.error("searchWrapper is null");
      return;
    } else {
      searchWrapperEl.classList.remove("hidden");
    }

    const q = prompt("Enter your search term");
    if (null == q) {
      searchWrapperEl.classList.add("hidden");
      return;
    }

    if (typeof (mySearchIndex) === "undefined") {
      searchResultsEl.innerHTML = "<li>Search: Please wait...</li>";
      if (typeof (searchIndex) === "undefined") {
        fetchScript(searchIndexFileName, () => {
          if (typeof (elasticlunr) === "undefined") {
            fetchScript(elasticlunrFileName, () => {
              mySearchIndex = elasticlunr.Index.load(window.searchIndex);
              doSearch(q, searchResultsEl);
            }, (err) => {
              showError(searchResultsEl, "<li>Search file not found: <code>" + elasticlunrFileName + "</code></li>");
            });
          } else {
            mySearchIndex = elasticlunr.Index.load(window.searchIndex);
            doSearch(q, searchResultsEl);
          }
        }, (err) => {
          showError(searchResultsEl, "<li>Search file not found: <code>" + searchIndexFileName + "</code></li>");
        });
      }
    } else {
      doSearch(q, searchResultsEl);
    }
  }

  function doSearch(q, searchResultsEl) {
    const searchResults = mySearchIndex.search(q);
    const searchResultsCount = searchResults.length;
    if (searchResultsCount > 0) {
      const searchResultsRows = ["<li><strong>" + searchResultsCount + "</strong> search " +
        (searchResultsCount === 1 ? "result" : "results") + " for <code>" + mySafe(q) + "</code>:</li>"];
      for (let i = 0; i < searchResultsCount; i++) {
        const searchResult = searchResults[i];
        searchResultsRows.push("<li><a href=\"" + mySafe(searchResult.ref) + "\">" +
          mySafe(searchResult.doc.title) + "</a></li>");
      }
      searchResultsEl.innerHTML = searchResultsRows.join("");
      searchResultsEl.scrollIntoViewIfNeeded();
    } else {
      showError(searchResultsEl, "<li>No search results for <code>" + mySafe(q) + "</code>.</li>");
    }
  }

  function showError(searchResultsEl, err) {
    searchResultsEl.innerHTML = err;
    searchResultsEl.scrollIntoViewIfNeeded();
  }

  function mySafe(code) {
    return code.replace(/&/g, "&amp;").replace(/</g, "&lt;").
      replace(/>/g, "&gt;").replace(/"/g, "&quot;").replace(/'/g, "&#039;");
  }

  function fetchScript(fileName, onL, onE) {
    const scriptEl = document.createElement("script");
    scriptEl.onload = onL;
    scriptEl.onerror = onE;
    scriptEl.src = fileName;
    document.head.appendChild(scriptEl);
    return scriptEl;
  }

  function initSearchButton(filenames) {
    elasticlunrFileName = filenames[0];
    searchIndexFileName = filenames[1];
  }

  if (null == window.linkita) window.linkita = {};
  window.linkita.toggleSearch = toggleSearch;
  window.linkita.initSearchButton = initSearchButton;
})();
