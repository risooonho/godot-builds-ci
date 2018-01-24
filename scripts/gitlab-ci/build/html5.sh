#!/bin/bash
#
# This build script is licensed under CC0 1.0 Universal:
# https://creativecommons.org/publicdomain/zero/1.0/

set -euo pipefail

export DIR
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$DIR/../_common.sh"

# Install the Emscripten SDK
wget -q "https://s3.amazonaws.com/mozilla-games/emscripten/releases/emsdk-portable.tar.gz"
tar xf "emsdk-portable.tar.gz"
cd "$GODOT_DIR/emsdk-portable/"
./emsdk update
./emsdk install latest
./emsdk activate latest
source ./emsdk_env.sh
export EMSCRIPTEN_ROOT
EMSCRIPTEN_ROOT="$(em-config EMSCRIPTEN_ROOT)"
cd "$GODOT_DIR/"

# Build HTML5 export templates
scons platform=javascript tools=no target=release_debug $SCONS_FLAGS
scons platform=javascript tools=no target=release $SCONS_FLAGS

# Create HTML5 export templates ZIP archive
cd "$GODOT_DIR/bin/"
zip -r9 "$ARTIFACTS_DIR/templates/html5.zip" \
    "godot.javascript.opt.debug.zip" \
    "godot.javascript.opt.zip"