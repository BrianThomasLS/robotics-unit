document.xURL= "https://poki.com/";

if (typeof consoleLog== 'undefined') {
  consoleLog= console.log;
}

var originalEval= eval;
eval= function() {  
  // consoleLog("--fx--eval--", arguments[0]);  
  // debugger;  
  arguments[0]= arguments[0].replace("aHR0cHM6Ly9wb2tpLmNvbS9zaXRlbG9jaw==", "I3ViZzIzNQ==");
  arguments[0]= arguments[0].replace("'location'", "'xlocation'");
  arguments[0]= arguments[0].replace("] = _0x3296f7;", "]==_0x3296f7;");
  arguments[0]= arguments[0].replace("] = window[_0xcdc9(", "]==window[_0xcdc9(");
  
  
  return originalEval.apply(this, arguments);
}

navigator.sendBeacon= function() {
  consoleLog("--fx--navigator.sendBeacon--", arguments);
}

WebSocket= function() {
  
}

xlocation= new Proxy(location, {
  get: function(target, property, receiver) {
    consoleLog("--fx--xlocation--get--property--", property);
    let targetObj = target[property];
    if (typeof targetObj == "function") {
      return (...args) => target[property].apply(target, args);
    } else {
      if (property== "host" || property=="hostname") {
        return "localhost";
      }
      if (property== "href") {
        return "https://localhost/";
      }
      if (property== "origin") {
        return "https://localhost/";
      }
      return targetObj;
    }
  },
  set: function(target, property, receiver) {
    consoleLog("--fx--xlocation--set--property--", property, receiver);
    return true;
  }
});

xwindow = new Proxy(window, {
  get: function(target, property, receiver) {
    // consoleLog("--fx--xWindow--property--", property, receiver);    
    if (typeof target[property] == "function") {
      return (...args) => target[property].apply(target,args);
    } else {
      if (property== "location") {
        return target["xlocation"];        
      }
      // consoleLog("--fx--xwindow--targetObj--", targetObj);
      return target[property];
    }
  }
});
// consoleLog(xwindow.location.href);
// consoleLog("window.xlocation.href", window.xlocation.href);

PokiSDK= function() {
  // ***** UTILS *****
  function loadJS(FILE_URL, callback) {
    let scriptEle = document.createElement("script");
  
    scriptEle.setAttribute("src", FILE_URL);
    scriptEle.setAttribute("type", "text/javascript");
    scriptEle.setAttribute("async", true);
  
    document.body.appendChild(scriptEle);
    
    // Success
    scriptEle.addEventListener("load", () => {
      consoleLog("--fx--PokiSDK--loadJS Done--");
      callback(true);
    });
    
     // Error
    scriptEle.addEventListener("error", () => {
      consoleLog("--fx--PokiSDK--loadJS Error--");
      callback(false);
    });
  }

  this.getURLParam= function(name) {
    return "";
  }
  
  // ***** INIT *****
  this.init= function() {
    return new Promise((resolve, reject)=> {
      resolve("InitDone");
    });
  }
  
  this.setDebug= function(debug) {
    consoleLog("--fx--PokiSDK--setDebug--", debug);
  }

  this.setDebugTouchOverlayController= function (debug) {
    consoleLog("--fx--PokiSDK--setDebugTouchOverlayController--", debug);
  }
  
  this.isAdBlocked= function() {
    consoleLog("--fx--PokiSDK--isAdBlocked--");    
    return false;
  }

  this.happyTime= function(scale) {
    consoleLog("--fx--PokiSDK--happyTime--", scale);    
  }

  // ***** LOADING *****  
  this.gameLoadingStart= function(){
    consoleLog("--fx--PokiSDK--gameLoadingStart--");
  }
  
  this.gameLoadingProgress= function(progress){
    consoleLog("--fx--PokiSDK--gameLoadingProgress--", progress);
  }
  
  this.gameLoadingFinished= function(){
    consoleLog("--fx--PokiSDK--gameLoadingFinished--");
  }

  // ***** GAME CONTROL *****
  this.gameplayStart= function(){
    consoleLog("--fx--PokiSDK--gameplayStart--");
  }

  this.gameplayStop= function() {
    consoleLog("--fx--PokiSDK--gameplayStop--");
  }

  // ***** ADS CONTROL *****
  this.commercialBreak= function(){
    consoleLog("--fx--PokiSDK--commercialBreak--");
    return new Promise((resolve, reject)=> {
      console.log("External UGBW commercial ad removed");
      resolve();
    });
  }

  this.rewardedBreak= function() {
   consoleLog("--fx--PokiSDK--rewardedBreak--");
    return new Promise((resolve, reject)=> {
      console.log("External UGBW rewarded ad removed");
      resolve();
    });
  }

  this.displayAd= function() {
    consoleLog("--fx--PokiSDK--displayAd--", arguments);
  }

  this.destroyAd= function() {
    consoleLog("--fx--PokiSDK--destroyAd--", arguments);
  }
}

PokiSDK.prototype.initWithVideoHB= function() {
  consoleLog("--fx--PokiSDK--initWithVideoHB--");
  return new Promise((resolve, reject)=> {
    resolve("")
  });
}

PokiSDK.prototype.customEvent= function() {
  consoleLog("--fx--PokiSDK--customEvent--");
}

PokiSDK= new PokiSDK();

// --- local offline shims -------------------------------------------------
// The compiled Unity framework calls these unguarded (PokiSDK.foo()), and the
// upstream stub never defined them. Undefined = TypeError mid-gameplay.
PokiSDK.gameInteractive = function() {
  consoleLog("--fx--PokiSDK--gameInteractive--");
};

PokiSDK.roundStart = function(identifier) {
  consoleLog("--fx--PokiSDK--roundStart--", identifier);
};

PokiSDK.roundEnd = function(identifier) {
  consoleLog("--fx--PokiSDK--roundEnd--", identifier);
};

PokiSDK.setPlayerAge = function(age) {
  consoleLog("--fx--PokiSDK--setPlayerAge--", age);
};

PokiSDK.togglePlayerAdvertisingConsent = function() {
  consoleLog("--fx--PokiSDK--togglePlayerAdvertisingConsent--", arguments);
};

// Anything else the build reaches for resolves to a harmless no-op instead of
// throwing, so a stray SDK call can never take the game down.
PokiSDK = new Proxy(PokiSDK, {
  get: function(target, property) {
    if (property in target) return target[property];
    if (typeof property === "string" && property !== "then") {
      consoleLog("--fx--PokiSDK--missing--", property);
      return function() {};
    }
    return target[property];
  }
});
