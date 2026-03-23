#!/bin/bash
#
# OVIWrite Install Script
# Installs OVIWrite to ~/.local/oviwrite and creates a launcher at ~/.local/bin/ovi
#

set -e

INSTALL_DIR="$HOME/.local/oviwrite"
BIN_DIR="$HOME/.local/bin"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

echo "Installing OVIWrite..."

# Create directory structure
mkdir -p "$INSTALL_DIR/nvim"
mkdir -p "$INSTALL_DIR/share"
mkdir -p "$INSTALL_DIR/state"
mkdir -p "$INSTALL_DIR/cache"
mkdir -p "$BIN_DIR"

# Copy config files
echo "Copying config files to $INSTALL_DIR/nvim..."
cp "$SCRIPT_DIR/init.lua" "$INSTALL_DIR/nvim/"
cp -r "$SCRIPT_DIR/lua" "$INSTALL_DIR/nvim/"
cp -r "$SCRIPT_DIR/spell" "$INSTALL_DIR/nvim/"

# Create launcher script
echo "Creating launcher at $BIN_DIR/ovi..."
cat > "$BIN_DIR/ovi" << 'EOF'
#!/bin/bash
#
# OVIWrite launcher
# Runs Neovim with isolated OVIWrite configuration
#

OVIWRITE_HOME="$HOME/.local/oviwrite"

export XDG_CONFIG_HOME="$OVIWRITE_HOME"
export XDG_DATA_HOME="$OVIWRITE_HOME/share"
export XDG_STATE_HOME="$OVIWRITE_HOME/state"
export XDG_CACHE_HOME="$OVIWRITE_HOME/cache"

exec nvim "$@"
EOF

chmod +x "$BIN_DIR/ovi"

echo ""
echo "Installation complete!"
echo ""
echo "Make sure $BIN_DIR is in your PATH, then run 'ovi' to start OVIWrite."
echo ""
echo "To add it to your PATH, add this to your ~/.bashrc or ~/.zshrc:"
echo "  export PATH=\"\$HOME/.local/bin:\$PATH\""
