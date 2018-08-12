.PHONY:Default print clean

export BUILD_ROOT = $(shell pwd)
export BIN_INCS_DIR = $(BUILD_ROOT)/Incs
export BIN_LIBS_DIR = $(BUILD_ROOT)/Libs

Default:
	make -C lcd
	make -C usb
	make -C media
	make -C app
	@echo "-----------------------------------------------------------------" 
	@echo "                      Good job! ~(@^_^@)~" 
	@echo "-----------------------------------------------------------------" 

print:
	make print -C lcd
	make print -C usb
	make print -C media
	make print -C app
	@echo "-----------------------------------------------------------------" 
	@echo "                      Good job! ~(@^_^@)~" 
	@echo "-----------------------------------------------------------------" 

clean:
	make clean -C lcd
	make clean -C usb
	make clean -C media
	make clean -C app
	@echo "-----------------------------------------------------------------" 
	@echo "                      Good job! ~(@^_^@)~" 
	@echo "-----------------------------------------------------------------" 


