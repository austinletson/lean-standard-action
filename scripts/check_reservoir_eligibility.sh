#!/bin/bash
private=$1
number_of_stars=$2
license_id=$3

# Initialize exit code
exit_code=0


# Function to check if the license_id is a valid SPDX license
function check_license() {
  local id=$1
  SPDX_DATA_URL="https://raw.githubusercontent.com/spdx/license-list-data/main/json/licenses.json"
  # Fetch the SPDX license list and read it into a variable
  spdx_licenses=$(curl -s $SPDX_DATA_URL | jq -r '.licenses[].licenseId')

  # Loop through the licenses and check if the license_id is a valid SPDX license
  for license in $spdx_licenses; do
    if [ "$license" == "$id" ]; then
      return 0
    fi
  done
  return 1
}

# Check if the license_id is a valid SPDX license and assign exit code
if ! check_license $license_id; then
  echo "Package is ineligible for Reservoir because the license is not a valid SPDX license."
  exit_code=1
fi

# Check for lake-manifest.json file
if [ ! -f "lake-manifest.json" ]; then
  echo "Package is ineligible for Reservoir because there is no lake-manifest.json file."
  exit_code=1
fi

# Check if the repository is private
if [ $private == "true" ]; then
  echo "Package is ineligible for Reservoir because the repository is private."
  exit_code=1
fi

# Check if the repository has less than 2 stars
if [ $number_of_stars -lt 2 ]; then
  echo "Package is ineligible for Reservoir because the repository has less than 2 stars."
  exit_code=1
fi

if [ $exit_code -eq 0 ]; then
  echo "Package is eligible for Reservoir."
fi
exit $exit_code