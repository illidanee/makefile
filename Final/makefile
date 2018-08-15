.PHONY:Default print clean

export BUILD_ROOT = $(shell pwd)

export GCC := g++
export GCC_FLAG := -g -O0 -std=c++11
export AR := ar
export AR_FLAG := rcs

BUILD_DIR := $(BUILD_ROOT)/lcd \
	     $(BUILD_ROOT)/usb \
	     $(BUILD_ROOT)/media \
	     $(BUILD_ROOT)/app

Default:
	@for dir in $(BUILD_DIR); \
	do \
		make -C $$dir; \
	done
	@echo "-----------------------------------------------------------------" 
	@echo "                      Good job! ~(@^_^@)~" 
	@echo "-----------------------------------------------------------------" 

print:
	@for dir in $(BUILD_DIR); \
	do \
		make print -C $$dir; \
	done
	@echo "-----------------------------------------------------------------" 
	@echo "                      Good job! ~(@^_^@)~" 
	@echo "-----------------------------------------------------------------" 

clean:
	@for dir in $(BUILD_DIR); \
	do \
		make clean -C $$dir; \
	done
	@echo "-----------------------------------------------------------------" 
	@echo "                      Good job! ~(@^_^@)~" 
	@echo "-----------------------------------------------------------------" 


