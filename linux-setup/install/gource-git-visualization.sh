#!/bin/bash

# Install required programs

required_programs=(
	"libsdl2-dev" # SDL 2.0
	"libsdl2-image-dev" # SDL Image 2.0
	"libpcre3-dev" # PCRE
	"libfreetype6-dev" # Freetype 2
	"libglew-dev" # GLEW
	"libglm-dev" # GLM >= 0.9.3
	"libboost-filesystem-dev" # Boost Filesystem >= 1.46
	"libpng12-dev" # PNG >= 1.2
	"libtinyxml-dev" # TinyXML (optional)
)

for i in "${required_programs[@]}"
do
	sudo apt-get -y install "${i}"
done

# Check for required commands

wget=/usr/bin/wget
tar=/bin/tar

WGET_OPTS=""
VERSION_FILENAME="gource-0.47"
URL="https://github.com/acaudwell/Gource/releases/download/${VERSION_FILENAME}/${VERSION_FILENAME}.tar.gz"
WORKING_FOLDER="temp"
WORKING_DIR="/home/${WORKING_FOLDER}"

# Exit if required commands not available
# TODO: install required commands if not available
if [ ! -x "$wget" ]; then
  echo "ERROR: No wget." >&2
  exit 1
fi

# Create a temp folder to avoid messing with any other dirs
sudo mkdir "${WORKING_DIR}" \
&& cd "${WORKING_DIR}"

# Get the tar file
if ! $wget $WGET_OPTS ${URL}; then
  echo "ERROR: wget didn't work" >&2
  exit 1
fi

if [ ! -f "${VERSION_FILENAME}.tar.gz" ]; then
	echo "ERROR: The archive ${VERSION_FILENAME}.tar.gz isn't here" >&2
	exit 1
fi

# Extract the archive
tar -zxvf "${WORKING_DIR}/${VERSION_FILENAME}.tar.gz" \
&& cd "${VERSION_FILENAME}" \
&& sudo ./configure \
&& sudo make \
&& sudo make install \
&& sudo rm -rf "${WORKING_DIR}"

echo -e "\n Done installing ${VERSION_FILENAME} \n"