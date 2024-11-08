var linkitaSearch = function () {
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

  const searchIndexFileName = window.location.host === "127.0.0.1:1111" ?
    "/js/demo.search_index.en.js" : "/search_index." +
    document.documentElement.getAttribute("lang").split("-")[0].split("_")[0] + ".js";
  const elasticlunrFileName = window.location.host === "127.0.0.1:1111" ?
    "/js/demo.elasticlunr.min.js" : "/elasticlunr.min.js";

  if (typeof (mySearchIndex) === "undefined") {
    searchResultsEl.innerHTML = "<li>Search: Please wait...</li>";
    if (typeof (searchIndex) === "undefined") {
      fetchScript(searchIndexFileName, () => {
        if (typeof (elasticlunr) === "undefined") {
          fetchScript(elasticlunrFileName, () => {
            window.mySearchIndex = elasticlunr.Index.load(searchIndex);
            doSearch(q, searchResultsEl);
          }, (err) => {
            showError(searchResultsEl, "<li>Search: <code>" + elasticlunrFileName + "</code> not found!</li>");
          });
        } else {
          window.mySearchIndex = elasticlunr.Index.load(searchIndex);
          doSearch(q, searchResultsEl);
        }
      }, (err) => {
        showError(searchResultsEl, "<li>Search: <code>" + searchIndexFileName + "</code> not found!</li>");
      });
    }
  } else {
    doSearch(q, searchResultsEl);
  }
}

function doSearch(q, searchResultsEl) {
  const searchResults = mySearchIndex.search(q);
  if (searchResults.length > 0) {
    const searchResultsRows = ["<li>Search results:</li>"];
    for (let i = 0; i < searchResults.length; i++) {
      const searchResult = searchResults[i];
      searchResultsRows.push("<li><a href=\"" + mySafe(searchResult.ref) + "\">" + mySafe(searchResult.doc.title) + "</a></li>");
    }
    searchResultsEl.innerHTML = searchResultsRows.join("");
    searchResultsEl.scrollIntoViewIfNeeded();
  } else {
    showError(searchResultsEl, "<li>Search: No results for <code>" + mySafe(q) + "</code></li>");
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
  console.debug("Fetch ", fileName);
  const scriptEl = document.createElement("script");
  scriptEl.onload = onL;
  scriptEl.onerror = onE;
  scriptEl.src = fileName;
  document.head.appendChild(scriptEl);
  return scriptEl;
}
