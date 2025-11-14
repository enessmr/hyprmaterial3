#!/bin/bash

# 💚 ✨ HyprYoshi3 ✨ 🦕

# force unbuffered output + capture everything
stdbuf -o0 -e0 ollama run "$@" 2>&1