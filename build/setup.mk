# append for toolchain setup.mk to turn on this obfuscator
# it should be included as `-include $(OBFUSCATOR_PATH)/setup.mk`

NDK_TOOLCHAIN_VERSION := obfuscator

TARGET_CC := $(OBFUSCATOR_PATH)/bin/clang$(HOST_EXEEXT)
TARGET_CXX := $(OBFUSCATOR_PATH)/bin/clang++$(HOST_EXEEXT)

TARGET_CFLAGS += \
    -gcc-toolchain $(call host-path,$(TOOLCHAIN_ROOT)) \

TARGET_LDFLAGS += \
    -gcc-toolchain $(call host-path,$(TOOLCHAIN_ROOT)) \
    -Wl,-no-gc-sections \

GLOBAL_CFLAGS = \
    -target $(LLVM_TRIPLE)$(TARGET_PLATFORM_LEVEL) \
    -fdata-sections \
    -ffunction-sections \
    -fstack-protector-strong \
    -funwind-tables \
    -no-canonical-prefixes \
    --sysroot $(call host-path,$(NDK_UNIFIED_SYSROOT_PATH)) \
    -g \
    -Wno-invalid-command-line-argument \
    -Wno-unused-command-line-argument \
    $(SYSROOT_ARCH_INC_ARG) \

GLOBAL_LDFLAGS += \
    --sysroot $(call host-path,$(NDK_UNIFIED_SYSROOT_PATH)) \
    -L$(call host-path,$(NDK_UNIFIED_SYSROOT_PATH))/usr/lib/${TOOLCHAIN_NAME}/${TARGET_PLATFORM_LEVEL} \
    -L$(call host-path,$(NDK_UNIFIED_SYSROOT_PATH))/usr/lib/${TOOLCHAIN_NAME} \
    --sysroot ${NDK_ROOT}/platforms/android-${TARGET_PLATFORM_LEVEL}/arch-${TARGET_ARCH} \
    $(SYSROOT_ARCH_INC_ARG) \
