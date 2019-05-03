#!/usr/bin/env bash
#
# This build script is licensed under CC0 1.0 Universal:
# https://creativecommons.org/publicdomain/zero/1.0/

# This script is always sourced before any other script

# The directory where build artifacts are stored
export ARTIFACTS_DIR
ARTIFACTS_DIR="$CI_PROJECT_DIR/artifacts"

# The directory the Godot Git repository will be cloned into
export GODOT_DIR
GODOT_DIR="$CI_PROJECT_DIR/godot"

# Disable WINE debugging for better performance and more concise output
export WINEDEBUG="-all"

# Ensure there is an artifacts directory on every job
mkdir -p "$ARTIFACTS_DIR/"

# Writes a JSON manifest containing build information such as the commit hash
# the file was built from.
# FIXME: This function should be called in a Git repository for the
# commit hash retrieval to work.
make_manifest() {
  cat > "$1.manifest.json" << EOF
{
  "commit": "$(git rev-parse HEAD)",
  "sha256": "$(sha256sum "$1" | cut -d ' ' -f 1)"
}
EOF
}
