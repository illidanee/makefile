.PHONY:print clean

#  ---------- Dirs

CUR_SUB_DIR := $(shell pwd)

BIN_INCS_DIR := $(BUILD_ROOT)/BinIncs
$(shell mkdir -p $(BIN_INCS_DIR))
BIN_LIBS_DIR := $(BUILD_ROOT)/BinLibs
$(shell mkdir -p $(BIN_LIBS_DIR))
BIN_DEPS_DIR := $(BUILD_ROOT)/BinDeps
$(shell mkdir -p $(BIN_DEPS_DIR))
BIN_OBJS_DIR := $(BUILD_ROOT)/BinObjs
$(shell mkdir -p $(BIN_OBJS_DIR))

LIB_OJBS_DIR := $(BUILD_ROOT)/LibOjbs
$(shell mkdir -p $(LIB_OJBS_DIR))

ifneq ("$(LIB)", "")
BIN_OBJS_DIR := $(LIB_OJBS_DIR)
endif
ifneq ("$(DLL)", "")
BIN_OBJS_DIR := $(LIB_OJBS_DIR)
DLL_FLAG := -fPIC
endif

EXT_INCS_DIR = $(BUILD_ROOT)/ExtIncs
$(shell mkdir -p $(EXT_INCS_DIR))
EXT_LIBS_DIR = $(BUILD_ROOT)/ExtLibs
$(shell mkdir -p $(EXT_LIBS_DIR))

#  ---------- Vars

SRCS := $(wildcard *.c)

DEPS := $(SRCS:.c=.d)
OBJS := $(SRCS:.c=.o)

DEPS := $(addprefix $(BIN_DEPS_DIR)/,$(DEPS))
OBJS := $(addprefix $(BIN_OBJS_DIR)/,$(OBJS))

LIB  := $(addprefix $(BIN_LIBS_DIR)/,$(LIB))
DLL  := $(addprefix $(BIN_LIBS_DIR)/,$(DLL))

#  ---------- Global Dirs And Vars

ALL_OBJS := $(wildcard $(BIN_OBJS_DIR)/*.o)
ALL_OBJS += $(OBJS)
ALL_LIBS := $(wildcard $(BIN_LIBS_DIR)/*.a) $(wildcard $(EXT_LIBS_DIR)/*.a)
ALL_LIBS += $(LIB)
ALL_DLLS := $(wildcard $(BIN_LIBS_DIR)/*.so) $(wildcard $(EXT_LIBS_DIR)/*.so)
ALL_DLLS += $(DLL)

ALL_LIBS_NAME := $(patsubst lib%,-l%,$(basename $(notdir $(ALL_LIBS))))
ALL_DLLS_NAME := $(patsubst lib%,-l%,$(basename $(notdir $(ALL_DLLS)))) 
ALL_NAME      := $(ALL_LIBS_NAME) $(ALL_DLLS_NAME)

#  ---------- Rulers

Default:$(DEPS) $(OBJS) $(LIB) $(DLL) $(BIN)
	@echo "--Good Sub Job!"

ifneq ("$(wildcard $(DEPS))", "")
include $(DEPS)
endif

$(BIN_DEPS_DIR)/%.d:%.c
	$(GCC) $(GCC_FLAG) -I$(BIN_INCS_DIR) -I$(EXT_INCS_DIR) -MM $(filter %.c, $^) | sed 's,\(.*\)\.o[ :]*,$(BIN_OBJS_DIR)/\1\.o $@:,g'> $@

$(BIN_OBJS_DIR)/%.o:%.c
	$(GCC) $(GCC_FLAG) -I$(BIN_INCS_DIR) -I$(EXT_INCS_DIR) $(DLL_FLAG) -o $@ -c $(filter %.c, $^)

$(LIB):$(OBJS)
	$(AR) $(AR_FLAG) -o $@ $^

$(DLL):$(OBJS)
	$(GCC) $(GCC_FLAG) -shared -o $@ $^

$(BIN):$(ALL_OBJS) $(ALL_LIBS) $(ALL_DLLS)
	$(GCC) $(GCC_FLAG) -L$(BIN_LIBS_DIR) -L$(EXT_LIBS_DIR) $(ALL_NAME) -o $@ $^

#  ---------- PHONYS

print:
	@echo "CUR_SUB_DIR:$(CUR_SUB_DIR)"
	@echo "BIN_INCS_DIR:$(BIN_INCS_DIR)"
	@echo "BIN_LIBS_DIR:$(BIN_LIBS_DIR)"
	@echo "BIN_DEPS_DIR:$(BIN_DEPS_DIR)"
	@echo "BIN_OBJS_DIR:$(BIN_OBJS_DIR)"
	@echo "LIB_OJBS_DIR:$(LIB_OJBS_DIR)"
	@echo "EXT_INCS_DIR:$(EXT_INCS_DIR)"
	@echo "EXT_LIBS_DIR:$(EXT_LIBS_DIR)"
	@echo "ALL_OBJS:$(ALL_OBJS)"
	@echo "ALL_LIBS:$(ALL_LIBS)"
	@echo "ALL_DLLS:$(ALL_DLLS)"
	@echo "ALL_LIBS_NAME:$(ALL_LIBS_NAME)"
	@echo "ALL_DLLS_NAME:$(ALL_DLLS_NAME)"
	@echo "ALL_NAME:$(ALL_NAME)"
	@echo "SRCS : $(SRCS)" 
	@echo "DEPS : $(DEPS)"
	@echo "OBJS : $(OBJS)"
	@echo "LIB  : $(LIB)"
	@echo "DLL  : $(DLL)"
	@echo "BIN  : $(BIN)"

clean:
	rm -f $(DEPS) $(OBJS) $(LIB) $(DLL) $(BIN)





