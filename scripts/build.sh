#!/bin/bash

source ~/.venv/bin/activate

# Function to build flowy
build_flowy() {
  echo "Building flowy..."
  cd flowy
  CI=1 buildozer android debug
  cd -

  cp flowy/bin/openpilot-0.1-arm64-v8a-debug.aar android/libs
}

# Function to build with scons
build_scons() {
  echo "Building with scons..."
  ## libusb
  ~/.buildozer/android/platform/android-ndk-r28c/ndk-build -C third_party/libusb/android/jni USE_PC_NAME=1
  ## libjson11
  ~/.buildozer/android/platform/android-ndk-r28c/toolchains/llvm/prebuilt/linux-x86_64/bin/aarch64-linux-android30-clang++ -shared third_party/json11/json11.cpp -fPIC -O3 -o third_party/json11/libjson11.so
  ## liblmdb
  cd third_party/lmdb
  make
  cd -

  # Build openpilot
  scons .

  # Move libs
  cp third_party/libusb/android/libs/arm64-v8a/libusb-1.0.so android/libs/arm64-v8a
  cp third_party/lmdb/liblmdb.so android/libs/arm64-v8a
  cp third_party/json11/libjson11.so android/libs/arm64-v8a
  cp wrappers/libpandaflash.so android/libs/arm64-v8a
  cp wrappers/libthneedrunner.so android/libs/arm64-v8a
  cp cereal/libmessaging.so android/libs/arm64-v8a
  cp selfdrive/modeld/libmodelparser.so android/libs/arm64-v8a
  cp selfdrive/boardd/libpandad.so android/libs/arm64-v8a
}

# Function to build the app
build_app() {
  echo "Building the app..."
  ANDROID_HOME="$HOME/.buildozer/android/platform/android-sdk" ./gradlew assembleRelease
}

# Function to build everything
build_full() {
  echo "Building everything..."

  build_scons
  build_flowy
  build_app
}

run() {
  "$@"
}

# The first build will be slow as we're building a Python environment
if [ ! -d "flowy/.buildozer" ]; then
  build_flowy
fi

build_target="$1"
shift

# Check if an argument is provided
if [ -z "$build_target" ]; then
  echo "Usage: $0 {full|scons|flowy|app}"
  exit 1
fi

# Call the appropriate function based on the argument
case "$build_target" in
  full)
    build_full
    ;;
  scons)
    build_scons
    ;;
  flowy)
    build_flowy
    ;;
  app)
    build_app
    ;;
  run)
    run "$@"
    ;;
  *)
    echo "Invalid argument: $1"
    echo "Usage: $0 {full|scons|flowy|app}"
    exit 1
    ;;
esac

echo "Build complete!"