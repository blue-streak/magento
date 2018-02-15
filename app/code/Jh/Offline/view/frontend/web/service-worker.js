importScripts('https://storage.googleapis.com/workbox-cdn/releases/3.0.0-beta.0/workbox-sw.js');

workbox.setConfig({
    debug: true
});
workbox.skipWaiting();
workbox.clientsClaim();

self.addEventListener('fetch', function(event) {
    event.respondWith(
        caches.match(event.request)
            .then(function(res) {
                if (res) return res;
                if (!navigator.onLine) {
                    return caches.match(new Request('/offline'))
                }
                return fetch(event.request);
            })
    )
});

workbox.routing.registerRoute(
    /\.(?:woff2)$/,
    workbox.strategies.staleWhileRevalidate({
        cacheName: 'static-fonts'
    })
);

workbox.precaching.precacheAndRoute([]);
