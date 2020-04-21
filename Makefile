CONFIG ?= Release
BUILD_DIR = build

PATH := /home/tobante/bin/gcc-arm-none-eabi-9-2019-q4-major/bin:$(PATH)
TOOLCHAIN ?= toolchain/gcc.cmake

ifdef CLANG
	TOOLCHAIN = toolchain/clang.cmake
endif 


.PHONY: all
all: config build

.PHONY: config
config: 
	cmake -S. -B$(BUILD_DIR) -GNinja -DCMAKE_TOOLCHAIN_FILE=$(TOOLCHAIN) -DCMAKE_BUILD_TYPE:STRING=$(CONFIG)

.PHONY: build
build: 
	cmake --build $(BUILD_DIR) --config $(CONFIG)

.PHONY: clean
clean:
	rm -rf $(BUILD_DIR)

.PHONY: format
format:
	find examples -iname '*.h' -o -iname '*.c'  -o -iname '*.hpp'  -o -iname '*.cpp' | xargs clang-format -i