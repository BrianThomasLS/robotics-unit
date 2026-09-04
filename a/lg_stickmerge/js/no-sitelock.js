(function () {
  var blockedHosts = {
    "unblockedgames911.gitsites.io": true,
    "ubg235.pages.dev": true,
    "ubg235.com": true,
    "www.ubg235.com": true
  };

  var originalOpen = window.open;
  window.open = function (url) {
    try {
      if (typeof url === "string") {
        var host = new URL(url, window.location.href).hostname;
        if (blockedHosts[host]) {
          return null;
        }
      }
    } catch (error) {
      // Ignore URL parsing errors and fall through to the original API.
    }

    if (typeof originalOpen === "function") {
      return originalOpen.apply(window, arguments);
    }

    return null;
  };

  var mainGameValue;
  Object.defineProperty(window, "MainGame", {
    configurable: true,
    get: function () {
      return mainGameValue;
    },
    set: function (value) {
      if (value && typeof value === "object") {
        value.api_check = function () {};
      }
      mainGameValue = value;
    }
  });
})();
