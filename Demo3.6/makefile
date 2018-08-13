.PHONY:Default clean

export BUILD_ROOT = $(shell pwd)
export INCS_DIR = $(BUILD_ROOT)/Incs

Default:
	make -C lcd
	make -C usb
	make -C media
	make -C app
	@echo "-----------------------------------------------------------------" 
	@echo "                      Good job! ~(@^_^@)~" 
	@echo "-----------------------------------------------------------------" 

clean:
	make clean -C lcd
	make clean -C usb
	make clean -C media
	make clean -C app

