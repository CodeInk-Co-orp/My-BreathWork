'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"flutter.js": "f393d3c16b631f36852323de8e583132",
"main.dart.js": "22e1b87415fa37edd1aacff10cf01bb2",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/AssetManifest.bin": "0ff4a14b551af0f1ec85a735452e8002",
"assets/fonts/MaterialIcons-Regular.otf": "d793776b8dd573ef6d6aff65c4dce286",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "8d3479d53ad88c6b5ee731ee8f219c1e",
"assets/assets/ICONS.png": "4a2589fc7d2e07c33e59fcf9e8acb84a",
"assets/assets/audio_image.jpg": "0e7e4e171970d3e082ccc5c2a01c5574",
"assets/assets/mybreathwork_logo_001.pdf": "a565fe67d31116079345c9ac90eed83c",
"assets/assets/images/starbackground_video.mp4": "8a88fb091c136f4bbb9f433aeba545b0",
"assets/assets/images/GUIDE_amelia.png": "244256b3135985dc8f77ab56a3cec305",
"assets/assets/images/background_animated.gif": "a0400d7efd56fdcaef7a895e044d20f0",
"assets/assets/images/GUIDE_jenny.png": "c7ebec11f9165b6ca01fbe495ecc94c1",
"assets/assets/images/starbackground_video1.mp4": "d3e9c2506d3548491f709682a297f200",
"assets/assets/images/GUIDE_ryan.png": "612ae3ebb0e3843b93291cc4c04dc262",
"assets/assets/images/ICONS.ai": "90004c736d73163a513d8b2f2ee91a98",
"assets/assets/images/GUIDE_christopher.png": "ca73cf0f98d29b33754a8504f7848839",
"assets/assets/music/Space_%255Bmusic_background_audio_file%255D.mp3": "7074ed85389dd61fbe3c653999043244",
"assets/assets/music/sound/Hiphop.mp3": "5f2cb9c360069b1be4e65f3c0dc0e704",
"assets/assets/music/sound/Techno.mp3": "e638648d3fe3f69902f8e9b624977704",
"assets/assets/music/sound/Space.mp3": "e1e03cf21fee1bb1883a5c3ad48068ce",
"assets/assets/music/ryan_english.txt": "1e1a32b2f44e670da9a54ce274d58a36",
"assets/assets/music/purpose/Sleepbetter.mp3": "5f2cb9c360069b1be4e65f3c0dc0e704",
"assets/assets/music/purpose/Focus.mp3": "e638648d3fe3f69902f8e9b624977704",
"assets/assets/music/purpose/Be%2520Happy.mp3": "e1e03cf21fee1bb1883a5c3ad48068ce",
"assets/assets/account_icon.png": "feea8c81eb79e2c0c4f0c7a025c8bd6f",
"assets/assets/sub_messages.xlsx": "c967b5c845e45452e47965a7788fc6f6",
"assets/assets/mybreathwork_logo_001.png": "f7e015296832da6919e03b631d483493",
"assets/assets/home_icon.png": "3228cf9e4f12ca2ab9eb0e262b6f29fe",
"assets/assets/mybreathwork_colors_001.pdf": "baccdb0694aa601dc4113bfdc0baede7",
"assets/NOTICES": "7d70d82311da7e542e91ac21cd181903",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/AssetManifest.json": "0158f53ca6d93479e1049ce32a2326d6",
"assets/AssetManifest.bin.json": "fa0584ff5a004ecc69d17f4ea13ff7a1",
"index.html": "10871a4800a78c276460315911875f12",
"/": "10871a4800a78c276460315911875f12",
"manifest.json": "e022dbf8faf139e995d59b086dc9a59c",
"canvaskit/canvaskit.js": "66177750aff65a66cb07bb44b8c6422b",
"canvaskit/canvaskit.js.symbols": "48c83a2ce573d9692e8d970e288d75f7",
"canvaskit/chromium/canvaskit.js": "671c6b4f8fcc199dcc551c7bb125f239",
"canvaskit/chromium/canvaskit.js.symbols": "a012ed99ccba193cf96bb2643003f6fc",
"canvaskit/chromium/canvaskit.wasm": "b1ac05b29c127d86df4bcfbf50dd902a",
"canvaskit/skwasm.js": "694fda5704053957c2594de355805228",
"canvaskit/skwasm.js.symbols": "262f4827a1317abb59d71d6c587a93e2",
"canvaskit/canvaskit.wasm": "1f237a213d7370cf95f443d896176460",
"canvaskit/skwasm.wasm": "9f0c0c02b82a910d12ce0543ec130e60",
"canvaskit/skwasm.worker.js": "89990e8c92bcb123999aa81f7e203b1c",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"version.json": "99dc4972882f36e24fe137376751f0bf",
"flutter_bootstrap.js": "a6c681e6ae087698a07df50cf5df47d8"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
