#!/bin/bash

# Set the TensorFlow version and download URLs
TF_VERSION=2.5
URL="https://github.com/am15h/tflite_flutter_plugin/releases/download"
TAG="tf_${TF_VERSION}"

# Set directory paths for Android
ANDROID_DIR="android/app/src/main/jniLibs/"
ANDROID_LIB="libtensorflowlite_c.so"

# Set library names based on architecture
ARM_DELEGATE="libtensorflowlite_c_arm_delegate.so"
ARM_64_DELEGATE="libtensorflowlite_c_arm64_delegate.so"
ARM="libtensorflowlite_c_arm.so"
ARM_64="libtensorflowlite_c_arm64.so"
X86="libtensorflowlite_c_x86_delegate.so"
X86_64="libtensorflowlite_c_x86_64_delegate.so"

# Define a function to download and move files
download_and_move() {
    curl -L -o $1 "${URL}/${TAG}/$1"
    mkdir -p "${ANDROID_DIR}$2"
    mv -f $1 "${ANDROID_DIR}$2/${ANDROID_LIB}"
}

# Check the first argument for the download mode
if [ "$1" == "-d" ]; then
    download_and_move $ARM_DELEGATE "armeabi-v7a"
    download_and_move $ARM_64_DELEGATE "arm64-v8a"
else
    download_and_move $ARM "armeabi-v7a"
    download_and_move $ARM_64 "arm64-v8a"
fi
download_and_move $X86 "x86"
download_and_move $X86_64 "x86_64"
