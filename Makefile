ARCHS = arm64
TARGET = iphone:clang:latest:latest

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = ModCF
ModCF_FILES = Tweak.x
ModCF_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk
name: BuildDylib
on: [push]
jobs:
  build:
    runs-on: macos-latest
    steps:
      - uses: actions/checkout@v3
      - name: Setup Theos
        run: bash -c "$(curl -fsSL https://raw.githubusercontent.com/theos/theos/master/bin/install-theos)"
      - name: Build Tweak
        run: |
          export THEOS=~/theos
          make package FINALPACKAGE=1
      - name: Upload Artifact
        uses: actions/upload-artifact@v3
        with:
          name: MeuHackPronto
          path: .theos/obj/debug/*.dylib
