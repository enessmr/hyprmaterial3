#!/bin/bash

set -e

pkgname="youtube-music"
pkgver="3.10.0"
debfile="${pkgname}_${pkgver}_amd64.deb"
deb_url="https://github.com/th-ch/youtube-music/releases/download/v$pkgver/$debfile"
license_url="https://github.com/th-ch/youtube-music/raw/v$pkgver/license"
wrapper_url="https://aur.archlinux.org/cgit/aur.git/plain/youtube-music.sh?h=youtube-music-bin"

install_dir="/opt/$pkgname"
bin_path="/usr/bin/$pkgname"
desktop_path="/usr/share/applications/${pkgname}.desktop"
license_path="/usr/share/licenses/$pkgname/license"

echo "==> Downloading .deb package..."
wget -O "$debfile" "$deb_url"

echo "==> Downloading license..."
wget -O "license" "$license_url"

echo "==> Downloading launcher script..."
wget -O "${pkgname}.sh" "$wrapper_url"
chmod +x "${pkgname}.sh"

echo "==> Extracting .deb..."
mkdir -p temp_extract
dpkg-deb -x "$debfile" temp_extract

echo "==> Installing application to $install_dir..."
sudo mkdir -p "$install_dir"
sudo cp -r temp_extract/* "$install_dir"

echo "==> Installing launcher script to $bin_path..."
sudo install -Dm755 "${pkgname}.sh" "$bin_path"

echo "==> Fixing desktop file..."
if [[ -f "$install_dir/usr/share/applications/${pkgname}.desktop" ]]; then
    sudo desktop-file-edit --set-key=Exec --set-value="${pkgname} %U" \
        "$install_dir/usr/share/applications/${pkgname}.desktop"
    sudo cp "$install_dir/usr/share/applications/${pkgname}.desktop" "$desktop_path"
fi

echo "==> Installing license..."
sudo mkdir -p "$(dirname "$license_path")"
sudo cp license "$license_path"

echo "==> Cleaning up..."
rm -rf temp_extract "$debfile" license "${pkgname}.sh"

echo "==> Done! You can now run '$pkgname'"
