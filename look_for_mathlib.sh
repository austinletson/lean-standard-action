#!/bin/bash

if grep -q "require mathlib" lakefile.lean; then
  echo "EXISTS=true" >> "$GITHUB_OUTPUT"
f