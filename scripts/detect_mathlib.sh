echo "Looking for mathlib dependency"
if grep -q "require mathlib" lakefile.lean; then
  echo "DETECTED_MATHLIB=true" >> "$GITHUB_OUTPUT"
  echo "Mathlib dependency found. Using Mathlib cache."
else
  echo "Mathlib dependency not found. Skipping Mathlib cache."
fi