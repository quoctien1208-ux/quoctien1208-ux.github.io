# Đưa Native Talk Coach lên điện thoại

Có 3 bước. Bước 1 bắt buộc. Sau đó chọn **Bước 2** (cài từ Chrome, dễ nhất) **hoặc Bước 3** (tạo file APK để cài nội bộ).

Không bước nào dùng đến Claude và không bước nào tốn phí.

---

## Bước 1: Đưa lên GitHub Pages (khoảng 10 phút)

### 1.1. Tạo tài khoản
Vào https://github.com và bấm **Sign up** để đăng ký miễn phí. Ghi nhớ **tên đăng nhập (username)**, ví dụ `tienhoc`.

### 1.2. Tạo kho chứa (repository)
1. Đăng nhập, bấm dấu **+** ở góc trên bên phải, chọn **New repository**.
2. **Repository name**: gõ chính xác `<username>.github.io`, ví dụ `tienhoc.github.io`.
   > Đặt đúng tên này thì địa chỉ ứng dụng sẽ ngắn gọn (`https://tienhoc.github.io/`). Bước 3 (APK) cũng cần đúng tên này.
3. Chọn **Public**. GitHub Pages miễn phí chỉ dành cho kho công khai.
4. Bấm **Create repository**.

### 1.3. Tải các file lên
1. Trong kho vừa tạo, bấm **uploading an existing file**.
2. Kéo thả **các file sau** từ thư mục `D:\Code\NativeTalkCoach`:
   - `index.html`
   - `manifest.webmanifest`
   - `sw.js`
   - `icon-192.png`, `icon-512.png`, `icon-maskable-512.png`, `apple-touch-icon.png`
   - `.nojekyll` (file rỗng, có dấu chấm ở đầu tên; nếu Windows ẩn file này thì bật **View > Show > Hidden items**)
   - `HUONG-DAN.md` (không bắt buộc)

   Không cần tải `start.bat` và `serve.ps1`, vì đây là file chỉ dùng trên máy tính.
3. Bấm **Commit changes**.

### 1.4. Bật GitHub Pages
1. Trong kho, vào **Settings > Pages**.
2. Ở **Source** chọn **Deploy from a branch**, **Branch** chọn `main` và `/ (root)`, rồi bấm **Save**.
3. Đợi 1–2 phút và tải lại trang. Dòng **"Your site is live at https://tienhoc.github.io/"** sẽ hiện ra.

Mở địa chỉ đó trên máy tính hoặc điện thoại là học được ngay, và micro hoạt động.

### Cập nhật sau này
Khi có `index.html` mới, vào kho trên GitHub, bấm **Add file > Upload files**, kéo file mới vào và bấm **Commit**. Điện thoại tự nhận bản mới ở lần mở sau (có thể phải mở 2 lần). APK ở Bước 3 **không cần tạo lại**.

---

## Bước 2: Cài lên điện thoại từ Chrome (cách dễ nhất)

**Android:**
1. Mở Chrome và vào `https://<username>.github.io/`.
2. Bấm menu **⋮**, chọn **Cài đặt ứng dụng** (hoặc **Thêm vào màn hình chính > Cài đặt**).
3. Biểu tượng **"Hi!"** xuất hiện trên màn hình. Ứng dụng mở toàn màn hình như một app thật.
4. Lần đầu bấm **Nói**, chọn **Cho phép** micro.

**iPhone:** mở bằng **Safari**, bấm nút **Chia sẻ**, chọn **Thêm vào MH chính**. Trên iPhone, phần micro có thể không hoạt động. Các phần khác chạy bình thường.

---

## Bước 3 (tùy chọn): Tạo file APK để cài nội bộ

APK này thực chất mở trang của bạn bằng Chrome bên trong, nên micro và mọi chức năng đều chạy. Điện thoại cần có Chrome.

### 3.1. Tạo APK bằng PWABuilder
1. Trên máy tính, vào https://www.pwabuilder.com.
2. Dán địa chỉ `https://<username>.github.io/` và bấm **Start**.
3. Bấm **Package for stores**, chọn **Android**, rồi **Generate Package**.
4. Trong phần tùy chọn:
   - **Package ID**: ví dụ `io.github.tienhoc.nativetalk` (chỉ dùng chữ thường, số và dấu chấm).
   - **App name**: `Native Talk Coach`.
   - **Signing key**: để mặc định **Create new**.
5. Bấm **Download**. Bạn sẽ nhận một file `.zip`.

### 3.2. Cất giữ file khóa
Giải nén file zip. Bên trong có:
- `*.apk`: **file để cài lên điện thoại**.
- `*.aab`: chỉ dùng khi đưa lên Google Play, có thể bỏ qua.
- `signing.keystore` và `signing-key-info.txt`: **cất kỹ hai file này**. Mất chúng thì không tạo được bản APK cập nhật có thể cài đè lên bản cũ.
- `assetlinks.json`: dùng ở bước 3.3.

### 3.3. Bỏ thanh địa chỉ trong app (nên làm)
Nếu bỏ qua bước này, app vẫn chạy nhưng có một thanh địa chỉ nhỏ ở trên cùng.
1. Vào kho GitHub, bấm **Add file > Create new file**.
2. Ô tên file gõ: `.well-known/assetlinks.json`
3. Mở file `assetlinks.json` trong zip bằng Notepad, chép toàn bộ nội dung và dán vào.
4. Bấm **Commit changes**. Đợi 1–2 phút, rồi kiểm tra địa chỉ `https://<username>.github.io/.well-known/assetlinks.json` có hiện nội dung đó.

### 3.4. Cài APK lên điện thoại Android
1. Gửi file `.apk` sang điện thoại (qua cáp USB, Zalo, Google Drive…).
2. Mở file trên điện thoại. Nếu được hỏi, bật **Cho phép cài đặt từ nguồn này**.
3. Nếu **Play Protect** cảnh báo "ứng dụng không rõ nguồn gốc", chọn **Chi tiết khác > Vẫn cài đặt**. Cảnh báo này là bình thường với APK tự tạo.
4. Mở app **Native Talk Coach**, bấm **Nói** và **Cho phép** micro.

Muốn cài cho đồng nghiệp: gửi họ cùng file `.apk` đó.

---

## Lưu ý
- **Tiến độ lưu riêng trên từng thiết bị**, không đồng bộ giữa máy tính và điện thoại. Bản cài từ Chrome và bản APK trên cùng một điện thoại cũng có thể lưu riêng.
- **Micro cần Internet.** Các phần khác vẫn mở được khi mất mạng, sau khi đã mở app ít nhất một lần lúc có mạng.
- Trang trên GitHub Pages **công khai** với ai có địa chỉ. Nội dung chỉ là bài học, không chứa dữ liệu cá nhân.
