#!/bin/bash
set -e

# Configuration
pkgver="1.101.2"
_pkgname="visual-studio-code"
pkgname="visual-studio-code-bin"
install_dir="/opt/${_pkgname}"
desktop_dir="/usr/share/applications"
pixmap_dir="/usr/share/pixmaps"
mime_dir="/usr/share/mime/packages"
license_dir="/usr/share/licenses/${_pkgname}"
completion_bash="/usr/share/bash-completion/completions"
completion_zsh="/usr/share/zsh/site-functions"
arch=$(uname -m)

# Determine architecture
case "$arch" in
  x86_64)    pkgfile="code_x64_${pkgver}.tar.gz"; pkgurl="https://update.code.visualstudio.com/${pkgver}/linux-x64/stable"; ;;
  aarch64)   pkgfile="code_arm64_${pkgver}.tar.gz"; pkgurl="https://update.code.visualstudio.com/${pkgver}/linux-arm64/stable"; ;;
  armv7l)    pkgfile="code_armhf_${pkgver}.tar.gz"; pkgurl="https://update.code.visualstudio.com/${pkgver}/linux-armhf/stable"; ;;
  *)         echo "Unsupported architecture: $arch"; exit 1 ;;
esac

tmpdir=$(mktemp -d)
cd "$tmpdir"

echo "Downloading VS Code binary for ${arch}..."
curl -L -o "${pkgfile}" "${pkgurl}"

echo "Extracting..."
tar -xf "${pkgfile}"

# Extract directory name
extracted_dir=$(find . -maxdepth 1 -type d -name "VSCode-linux*" | head -n1)

echo "Installing to ${install_dir}..."
mkdir -p "${install_dir}"
cp -r "${extracted_dir}/"* "${install_dir}/"

echo "Installing desktop entry, icon, license, completions..."
install -Dm644 "${install_dir}/resources/app/LICENSE.rtf" "${license_dir}/LICENSE.rtf"
install -Dm644 "${install_dir}/resources/app/resources/linux/code.png" "${pixmap_dir}/${_pkgname}.png"
install -Dm644 "${install_dir}/resources/completions/bash/code" "${completion_bash}/code"
install -Dm644 "${install_dir}/resources/completions/zsh/_code" "${completion_zsh}/_code"

# Create .desktop file
cat > "${desktop_dir}/code.desktop" <<EOF
[Desktop Entry]
Name=Visual Studio Code
Comment=Code Editing. Redefined.
Exec=/usr/bin/code
Icon=${_pkgname}
Type=Application
StartupNotify=true
StartupWMClass=Code
Categories=Utility;TextEditor;Development;IDE;
MimeType=x-scheme-handler/vscode;
EOF

# Create MIME XML file
mkdir -p "${mime_dir}"
cat > "${mime_dir}/${pkgname}-workspace.xml" <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<mime-info xmlns="http://www.freedesktop.org/standards/shared-mime-info">
  <mime-type type="application/vnd.code.workspace">
    <comment>Visual Studio Code Workspace</comment>
    <glob pattern="*.code-workspace"/>
  </mime-type>
</mime-info>
EOF

# Create /usr/bin/code launcher
cat > "/usr/bin/code" <<'EOF'
#!/bin/bash
exec /opt/visual-studio-code/code "$@"
EOF
chmod +x /usr/bin/code

echo "Updating desktop database and MIME info..."
update-desktop-database &>/dev/null || true
update-mime-database "${mime_dir}" &>/dev/null || true

echo "Installation complete."
