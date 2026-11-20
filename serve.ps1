# Chạy Native Talk Coach tại http://localhost:8765 để trình duyệt cho phép dùng micro.
# Đóng cửa sổ này (hoặc Ctrl+C) để tắt.
$port = 8765
$root = Split-Path -Parent $MyInvocation.MyCommand.Path
$listener = [System.Net.HttpListener]::new()
$listener.Prefixes.Add("http://localhost:$port/")
try { $listener.Start() } catch {
  Write-Host "Không mở được cổng $port. Có thể app đang chạy rồi - mở http://localhost:$port trong trình duyệt." -ForegroundColor Yellow
  Start-Process "http://localhost:$port/"
  Read-Host "Nhấn Enter để đóng"
  exit
}
Write-Host "Native Talk Coach đang chạy tại http://localhost:$port" -ForegroundColor Green
Write-Host "Giữ cửa sổ này mở trong lúc học. Đóng cửa sổ để tắt."
Start-Process "http://localhost:$port/"
$types = @{ '.html'='text/html; charset=utf-8'; '.js'='text/javascript; charset=utf-8'; '.css'='text/css; charset=utf-8'; '.png'='image/png'; '.svg'='image/svg+xml'; '.ico'='image/x-icon'; '.webmanifest'='application/manifest+json'; '.json'='application/json'; '.md'='text/plain; charset=utf-8' }
while ($listener.IsListening) {
  $ctx = $listener.GetContext()
  $path = [Uri]::UnescapeDataString($ctx.Request.Url.AbsolutePath.TrimStart('/'))
  if ([string]::IsNullOrEmpty($path)) { $path = 'index.html' }
  $file = [IO.Path]::GetFullPath((Join-Path $root $path))
  $res = $ctx.Response
  if ($file.StartsWith($root) -and (Test-Path $file -PathType Leaf)) {
    $bytes = [IO.File]::ReadAllBytes($file)
    $ext = [IO.Path]::GetExtension($file).ToLower()
    $res.ContentType = if ($types.ContainsKey($ext)) { $types[$ext] } else { 'application/octet-stream' }
    $res.OutputStream.Write($bytes, 0, $bytes.Length)
  } else { $res.StatusCode = 404 }
  $res.Close()
}
