Obfuscator
===========

* Clone

      git clone https://github.com/alexcohn/obfuscator -b llvm-9.0.1 -depth 1

* Build see https://github.com/obfuscator-llvm/obfuscator/wiki/Installation

      mkdir obfuscator/build
      cd obfuscator/build
      cmake .. && make

* Setup the Android toolchain (verified for `v21.4.7075529`):

      echo >> arm-linux-androideabi-clang/setup.mk '-include $(OBFUSCATOR_PATH)/setup.mk'
      echo >> aarch64-linux-android-clang/setup.mk '-include $(OBFUSCATOR_PATH)/setup.mk'

* use for **ndk-build**:

      ndk-build … OBFUSCATOR_PATH=obfuscator
