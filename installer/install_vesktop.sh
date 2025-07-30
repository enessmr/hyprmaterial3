#!/usr/bin/env bash
set -euo pipefail

pkgname=vesktop-bin
_pkgname=Vesktop
_appname=vencord-desktop
pkgver=1.5.8
_electronversion=37

srcdir="$(pwd)"
pkgdir="${srcdir}/pkg"
_icon_sizes=(16x16 32x32 48x48 64x64 128x128 256x256 512x512 1024x1024)

# URLs
rpm_x86_64="https://github.com/Vencord/Vesktop/releases/download/v${pkgver}/vesktop-${pkgver}.x86_64.rpm"
rpm_aarch64="https://github.com/Vencord/Vesktop/releases/download/v${pkgver}/vesktop-${pkgver}.aarch64.rpm"
launcher_url="https://aur.archlinux.org/cgit/aur.git/plain/vesktop.sh?h=vesktop-bin"

# Filenames
rpm_x86_64_file="vesktop-${pkgver}.x86_64.rpm"
rpm_aarch64_file="vesktop-${pkgver}.aarch64.rpm"
launcher_script="vesktop.sh"

download() {
  local url=$1
  local file=$2
  if [[ -f "$file" ]]; then
    echo "$file exists, skipping download."
  else
    echo "Downloading $file ..."
    curl -L -o "$file" "$url"
  fi
}

echo "== Downloading files =="
download "$rpm_x86_64" "$rpm_x86_64_file"
download "$launcher_url" "$launcher_script"
# Uncomment below line to download ARM RPM
# download "$rpm_aarch64" "$rpm_aarch64_file"

echo "== Preparing package directory =="
mkdir -p "$pkgdir/usr/bin"
mkdir -p "$pkgdir/usr/lib/${pkgname%-bin}"
mkdir -p "$pkgdir/usr/share/applications"
for size in "${_icon_sizes[@]}"; do
  mkdir -p "$pkgdir/usr/share/icons/hicolor/$size/apps"
done

echo "== Patching launcher script =="
sed -i -e "
  s/@electronversion@/${_electronversion}/g
  s/@appname@/${pkgname%-bin}/g
  s/@runname@/app.asar/g
  s/@cfgdirname@/${pkgname%-bin}/g
  s/@options@/env ELECTRON_OZONE_PLATFORM_HINT=auto/g
" "$launcher_script"

echo "== Extracting RPM $rpm_x86_64_file =="
rm -rf extracted
mkdir extracted
bsdtar -xf "$rpm_x86_64_file" -C extracted

binary_path="extracted/opt/${_pkgname}/${pkgname%-bin}"
if [[ -f "$binary_path" ]]; then
  _electronversion_detected="$(strings "$binary_path" | grep '^Chrome/[0-9.]* Electron/[0-9]' | cut -d'/' -f3 | cut -d'.' -f1 || true)"
  echo -e "Detected Electron version: \033[1;31m${_electronversion_detected:-unknown}\033[0m"
else
  echo "Warning: Binary not found to detect electron version"
fi

desktop_file="extracted/usr/share/applications/${pkgname%-bin}.desktop"
if [[ -f "$desktop_file" ]]; then
  sed -i "s|/opt/${_pkgname}/||g" "$desktop_file"
else
  echo "Error: Desktop file not found."
  exit 1
fi

echo "== Installing files to $pkgdir =="
install -Dm755 "$launcher_script" "$pkgdir/usr/bin/${pkgname%-bin}"
install -Dm644 "extracted/opt/${_pkgname}/resources/app.asar" "$pkgdir/usr/lib/${pkgname%-bin}/app.asar"
install -Dm644 "$desktop_file" "$pkgdir/usr/share/applications/${pkgname%-bin}.desktop"

for size in "${_icon_sizes[@]}"; do
  icon_src="extracted/usr/share/icons/hicolor/$size/apps/${pkgname%-bin}.png"
  icon_dst="$pkgdir/usr/share/icons/hicolor/$size/apps/${pkgname%-bin}.png"
  if [[ -f "$icon_src" ]]; then
    install -Dm644 "$icon_src" "$icon_dst"
  fi
done

sudo cp -r "$pkgdir/*" /

echo "== Done! Package ready in $pkgdir"

