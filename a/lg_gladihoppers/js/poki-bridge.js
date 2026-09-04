// Bridge between the compiled game and the local SDK stub.
//
// Upstream this lived inside Poki's own loader (poki-unity.js), which we don't
// ship because it pulls in ad containers, branded chrome and a remote image
// host. The build calls these three globals directly, so they have to exist:
//
//   window.initPokiBridge(name)  - hands us the Unity object that ad callbacks
//                                  must be delivered back to
//   window.commercialBreak()     - interstitial; must report back when finished
//   window.rewardedBreak()       - "watch an ad for a reward"; must report back
//                                  with a value, or the reward never lands
//
// With no ads to play we resolve immediately, which keeps the game moving.
(function () {
  'use strict';

  window.pokiAdBlock = false;
  window.pokiReady = false;

  // Upstream calls .toString() on whatever rewardedBreak resolves with, and the
  // shipped stub resolves undefined -> TypeError, reward silently lost.
  // true == "the player watched it", so the reward is granted offline.
  PokiSDK.commercialBreak = function () { return Promise.resolve(); };
  PokiSDK.rewardedBreak = function () { return Promise.resolve(true); };

  function send(name, method, param) {
    var tries = 0;
    (function attempt() {
      var game = window.unityGame;
      if (game && typeof game.SendMessage === 'function') {
        try {
          if (param === undefined) game.SendMessage(name, method);
          else game.SendMessage(name, method, param);
        } catch (e) {
          console.warn('[bridge] SendMessage failed:', method, e);
        }
        return;
      }
      if (++tries > 100) {           // ~10s, then give up rather than spin forever
        console.warn('[bridge] unityGame never appeared; dropped:', method);
        return;
      }
      setTimeout(attempt, 100);
    })();
  }

  // Safe defaults in case the game asks for a break before the bridge is wired.
  window.commercialBreak = function () {};
  window.rewardedBreak = function () {};

  window.initPokiBridge = function (name) {
    window.pokiBridge = name;

    window.commercialBreak = function () {
      PokiSDK.commercialBreak().then(function () {
        send(name, 'commercialBreakCompleted');
      });
    };

    window.rewardedBreak = function () {
      PokiSDK.rewardedBreak().then(function (result) {
        send(name, 'rewardedBreakCompleted', (result === undefined ? true : result).toString());
      });
    };

    // Deferred on purpose: the game calls initPokiBridge from inside its own
    // frame, and answering synchronously re-enters the Unity player loop.
    setTimeout(function () {
      window.pokiReady = true;
      send(name, 'ready');
    }, 0);
  };
})();
