const CACHE_NAME = 'geid-monitor-v2';
const urlsToCache = [
    '/',
    '/dashboard',
    '/css/styles.css',
    '/css/dashboard-modern.css',
    '/js/app.js',
    '/manifest.json'
];

// Installation
self.addEventListener('install', event => {
    event.waitUntil(
        caches.open(CACHE_NAME)
            .then(cache => {
                console.log('Cache ouvert');
                return cache.addAll(urlsToCache);
            })
            .then(() => self.skipWaiting())
    );
});

// Activation
self.addEventListener('activate', event => {
    event.waitUntil(
        caches.keys().then(cacheNames => {
            return Promise.all(
                cacheNames.map(cacheName => {
                    if (cacheName !== CACHE_NAME) {
                        console.log('Suppression ancien cache:', cacheName);
                        return caches.delete(cacheName);
                    }
                })
            );
        })
    );
    return self.clients.claim();
});

// Fetch
self.addEventListener('fetch', event => {
    // Ignorer les requêtes POST et les requêtes vers l'API
    if (event.request.method === 'POST' || event.request.url.includes('/api/')) {
        return fetch(event.request);
    }

    event.respondWith(
        caches.match(event.request)
            .then(response => {
                if (response) {
                    return response;
                }

                return fetch(event.request).then(response => {
                    // Ne pas mettre en cache si ce n'est pas une réponse valide
                    if (!response || response.status !== 200 || response.type !== 'basic') {
                        return response;
                    }

                    // Mettre en cache la réponse clonée
                    const responseToCache = response.clone();
                    caches.open(CACHE_NAME)
                        .then(cache => {
                            cache.put(event.request, responseToCache);
                        });

                    return response;
                });
            })
    );
});

// Background sync pour les alertes
self.addEventListener('sync', event => {
    if (event.tag === 'sync-alerts') {
        event.waitUntil(syncAlerts());
    }
});

async function syncAlerts() {
    try {
        const response = await fetch('/api/alerts/critical');
        const data = await response.json();

        // Envoyer une notification si des alertes
        if (data && data.alerts && data.alerts.length > 0) {
            self.registration.showNotification('🚨 Alertes GEID', {
                body: `${data.alerts.length} alerte(s) critique(s)`,
                icon: '/images/logo.png',
                badge: '/images/badge.png',
                tag: 'alerts',
                renotify: true,
                actions: [
                    { action: 'view', title: 'Voir' },
                    { action: 'ignore', title: 'Ignorer' }
                ]
            });
        }
    } catch (error) {
        console.error('Erreur sync alerts:', error);
    }
}