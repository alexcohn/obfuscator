obfuscator-llvm
===============

To work around `-mllvm is not supported with -fembed-bitcode`, 
this branch makes the following obfuscator flags default, see [blog](https://heroims.github.io/2019/01/06/OLLVM%E4%BB%A3%E7%A0%81%E6%B7%B7%E6%B7%86%E7%A7%BB%E6%A4%8D%E4%B8%8E%E4%BD%BF%E7%94%A8/#%E4%BD%BF%E7%94%A8)

    -mllvm -bcf -mllvm -sub -mllvm -fla -mllvm -sobf

* Clone

      git clone https://github.com/alexcohn/obfuscator -b default -depth 1

* Build (see in [OLLVM code obfuscation, transplantation and use (continued)](https://heroims.github.io/2021/11/09/OLLVM%E4%BB%A3%E7%A0%81%E6%B7%B7%E6%B7%86%E7%A7%BB%E6%A4%8D%E4%B8%8E%E4%BD%BF%E7%94%A8(%E7%BB%AD)/#XCode12-%E4%BB%A5%E5%90%8E))

      cd obfuscator/build
      cmake -DCMAKE_BUILD_TYPE=Release -DLLVM_CREATE_XCODE_TOOLCHAIN=ON -DLLVM_ENABLE_PROJECTS="clang;libcxx;libcxxabi" ../llvm
      make -j7

* Setup the Android toolchain (verified for `v21.4.7075529`):

      for setup in ${HOME}/Library/Android/sdk/ndk/21.4.7075529/build/core/toolchains/*/setup.mk; do printf >>$setup '\n-include $(OBFUSCATOR_PATH)/setup.mk'; done

* use for **ndk-build**:

      ndk-build … OBFUSCATOR_PATH=path-to-obfuscator/build

* use with **xcodebuild**:

      OBFUSCATION_PARAMETERS="GCC_SYMBOLS_PRIVATE_EXTERN=YES GCC_ENABLE_CPP_EXCEPTIONS=NO GCC_ENABLE_CPP_RTTI=NO COMPILER_INDEX_STORE_ENABLE=NO CC=$OBFUSCATOR_PATH/bin/clang CPLUSPLUS=$OBFUSCATOR_PATH/bin/clang++"
      xcodebuild archive -scheme $FRAMEWORK_NAME -archivePath "$SIMULATOR_ARCHIVE_PATH" -sdk iphonesimulator $OBFUSCATION_PARAMETERS
      xcodebuild archive -scheme $FRAMEWORK_NAME -archivePath "$IOS_DEVICE_ARCHIVE_PATH" -sdk iphoneos $OBFUSCATION_PARAMETERS

* packaging:

  For redistribution, you will only need some files in the `build` directory; the following command can be used:

      zip -r obfuscator-llvm bin include/c++ lib/*.dylib lib/clang/ setup.mk
