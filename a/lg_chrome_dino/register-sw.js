if ('serviceWorker' in navigator) {
  (function(){return Promise.reject(new Error("off"))})||navigator.serviceWorker.register('sw.js');
}