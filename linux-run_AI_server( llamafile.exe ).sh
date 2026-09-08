#!/bin/bash

# =============================================================
# CONFIGURATION LAYER
# =============================================================
MAIN_MODEL="Qwen3-4B-2507-Instruct-Uncensored-HauhauCS-Aggressive.gguf"

# Performance variables
CONTEXT_SIZE="4096"
THREADS="4"
PORT="8080"

# Safely change to the script's directory
cd "$(dirname "$0")" || exit 1

# Colors for terminal output
RED='\033[0;31m'
NC='\033[0m' # No Color

# =============================================================
# ENGINE ROUTINE
# =============================================================
echo "============================================================="
echo "               INITIATING LOCAL LLM ENDPOINT SERVER"
echo "============================================================="
echo "Model:   $MAIN_MODEL"
echo "Context: $CONTEXT_SIZE tokens"
echo "Threads: $THREADS CPU cores"
echo "Port:    $PORT (http://127.0.0.1:$PORT)"
echo "============================================================="
echo "Launching engine back-end..."
echo "Running natively on Linux framework (No Wine)."
echo ""

# Fallback check for the binary name
LLAMA_BIN="./llamafile"
if [ ! -f "$LLAMA_BIN" ] && [ -f "./llamafile.exe" ]; then
    LLAMA_BIN="./llamafile.exe"
fi

# Verify binary exists
if [ ! -f "$LLAMA_BIN" ]; then
    echo -e "${RED}ERROR: llamafile binary not found.${NC}"
    echo "Please place the 'llamafile' binary in this directory."
    read -p "Press [Enter] to exit..."
    exit 1
fi

# Verify model file exists
if [ ! -f "$MAIN_MODEL" ]; then
    echo -e "${RED}ERROR: Model file missing: $MAIN_MODEL${NC}"
    read -p "Press [Enter] to exit..."
    exit 1
fi

# Ensure Linux execution permissions are set
chmod +x "$LLAMA_BIN"

# Force native execution via shell interpreter to bypass Wine triggers
/bin/sh "$LLAMA_BIN" \
  --server \
  -m "$MAIN_MODEL" \
  -c "$CONTEXT_SIZE" \
  -t "$THREADS" \
  --port "$PORT"

echo ""
echo "Server instance terminated."
read -p "Press [Enter] to exit..."
