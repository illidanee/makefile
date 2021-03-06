.PHONY:print clean

#  ---------- Dirs

CUR_SUB_DIR := $(shell pwd)

BIN_DEPS_DIR := $(BUILD_ROOT)/Deps
$(shell mkdir -p $(BIN_DEPS_DIR))
BIN_OBJS_DIR := $(BUILD_ROOT)/Objs
$(shell mkdir -p $(BIN_OBJS_DIR))

LIB_OJBS_DIR := $(BUILD_ROOT)/LibOjbs
$(shell mkdir -p $(LIB_OJBS_DIR))

ifneq ("$(LIB)", "")
BIN_OBJS_DIR := $(LIB_OJBS_DIR)
endif

#  ---------- Vars

SRCS := $(wildcard *.c)

DEPS := $(SRCS:.c=.d)
OBJS := $(SRCS:.c=.o)

DEPS := $(addprefix $(BIN_DEPS_DIR)/,$(DEPS))
OBJS := $(addprefix $(BIN_OBJS_DIR)/,$(OBJS))

LIB  := $(addprefix $(BIN_LIBS_DIR)/,$(LIB))

#  ---------- Global Dirs And Vars

ALL_OBJS := $(wildcard $(BIN_OBJS_DIR)/*.o)
ALL_OBJS += $(OBJS)
ALL_LIBS := $(wildcard $(BIN_LIBS_DIR)/*.a)
ALL_LIBS += $(LIB)

ALL_LIBS_NAME := $(patsubst lib%,-l%,$(basename $(notdir $(ALL_LIBS))))

#  ---------- Rulers

Default:$(DEPS) $(OBJS) $(LIB) $(BIN)
	@echo "--Good Sub Job!"

ifneq ("$(wildcard $(DEPS))", "")
include $(DEPS)
endif

$(BIN_DEPS_DIR)/%.d:%.c
	gcc -I$(BIN_INCS_DIR) -MM $(filter %.c, $^) | sed 's,\(.*\)\.o[ :]*,$(BIN_OBJS_DIR)/\1\.o $@:,g'> $@

$(BIN_OBJS_DIR)/%.o:%.c
	gcc -I$(BIN_INCS_DIR) -o $@ -c $(filter %.c, $^)

$(LIB):$(OBJS)
	ar rcs -o $@ $^

$(BIN):$(ALL_OBJS) $(ALL_LIBS)
	gcc -o $@ $^ -L$(BIN_LIBS_DIR) $(ALL_LIBS_NAME) 

#  ---------- PHONYS

print:
	@echo "CUR_SUB_DIR:$(CUR_SUB_DIR)"
	@echo "BIN_DEPS_DIR:$(BIN_DEPS_DIR)"
	@echo "BIN_OBJS_DIR:$(BIN_OBJS_DIR)"
	@echo "LIB_OJBS_DIR:$(LIB_OJBS_DIR)"
	@echo "SRCS : $(SRCS)" 
	@echo "DEPS : $(DEPS)"
	@echo "OBJS : $(OBJS)"
	@echo "LIB  : $(LIB)"
	@echo "BIN  : $(BIN)"

clean:
	rm -f $(DEPS) $(OBJS) $(LIB) $(BIN)





