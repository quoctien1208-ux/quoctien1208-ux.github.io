// Service worker: cho phép mở ứng dụng khi không có mạng.
// Trang chính lấy bản mới từ mạng trước (để luôn cập nhật), mất mạng thì dùng bản đã lưu.
const CACHE = "ntc-v2";
const CORE = ["./", "./index.html", "./manifest.webmanifest", "./icon-192.png", "./icon-512.png", "./icon-maskable-512.png", "./apple-touch-icon.png"];

self.addEventListener("install", e => {
  e.waitUntil(caches.open(CACHE).then(c => c.addAll(CORE)).then(() => self.skipWaiting()));
});
self.addEventListener("activate", e => {
  e.waitUntil(caches.keys().then(keys => Promise.all(keys.filter(k => k !== CACHE).map(k => caches.delete(k)))).then(() => self.clients.claim()));
});
self.addEventListener("fetch", e => {
  const req = e.request;
  if (req.method !== "GET") return;
  const url = new URL(req.url);
  // Font Google: dùng bản đã lưu, cập nhật ngầm
  if (url.hostname === "fonts.googleapis.com" || url.hostname === "fonts.gstatic.com") {
    e.respondWith(caches.open(CACHE).then(async c => {
      const hit = await c.match(req);
      const net = fetch(req).then(r => { c.put(req, r.clone()); return r; }).catch(() => hit);
      return hit || net;
    }));
    return;
  }
  if (url.origin !== location.origin) return;
  // File của ứng dụng: lấy từ mạng trước, mất mạng thì dùng bản đã lưu
  // cache: "no-cache" = luôn hỏi máy chủ xem có bản mới không (không dùng bản trình duyệt giữ tạm)
  e.respondWith(fetch(req, { cache: "no-cache" }).then(r => {
    if (r.ok) { const copy = r.clone(); caches.open(CACHE).then(c => c.put(req, copy)); }
    return r;
  }).catch(() => caches.match(req).then(hit => hit || caches.match("./index.html"))));
});
