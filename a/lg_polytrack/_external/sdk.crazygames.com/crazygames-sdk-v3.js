// CrazyGames SDK stub for offline play
(function() {
    var noop = function() {};
    var resolved = function() { return Promise.resolve(); };
    var resolveNull = function() { return Promise.resolve(null); };
    var rejected = function() { return Promise.reject('offline'); };
    
    var sdk = {
        init: function(opts) { 
            console.log('[SDK Stub] init bypassed for offline play');
            return Promise.resolve(sdk);
        },
        game: { sdkGameLoadingStart: noop, sdkGameLoadingStop: noop, gameplayStart: noop, gameplayStop: noop, happytime: noop, loadingStart: noop, loadingStop: noop },
        ad: { requestAd: function(type, cb) { cb = cb || {}; setTimeout(function() { (cb.adFinished || cb.adError || noop)(); }, 50); }, hasAdblock: false },
        user: { isUserAccountAvailable: false, showAuthPrompt: rejected, showAccountLinkPrompt: rejected, getUser: resolveNull, getToken: resolveNull, getXsollaUserToken: resolveNull, addScoreChangeListener: noop, addAuthListener: noop },
        data: { save: resolved, load: resolveNull, getItem: resolveNull, setItem: resolved, removeItem: resolved, clear: resolved },
        banner: { requestBanner: noop },
        environment: 'disabled',
        isInitialized: true,
    };
    
    window.CrazyGames = window.CrazyGames || {};
    window.CrazyGames.SDK = sdk;
    window.CrazyGames.CrazySDK = sdk;
    window.Crazygames = window.CrazyGames;
    
    // V3 SDK uses CrazyGames.SDK.init() which returns a promise resolving to the sdk
    var origInit = sdk.init;
    window.CrazyGames.SDK.init = function(opts) {
        window.CrazyGames.SDK.isInitialized = true;
        return Promise.resolve(window.CrazyGames.SDK);
    };
})();
