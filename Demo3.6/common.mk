.PHONY:print clean

#  ---------- Dirs

CUR_SUB_DIR := $(shell pwd)

OBJS_DIR := /home/illidan/makefile/Demo3.6/Objs
$(shell mkdir -p $(OBJS_DIR))
DEPS_DIR := /home/illidan/makefile/Demo3.6/Deps
$(shell mkdir -p $(DEPS_DIR))

#  ---------- Vars

SRCS := $(wildcard *.c)
OBJS := $(SRCS:.c=.o)
DEPS := $(SRCS:.c=.d)

OBJS := $(addprefix $(OBJS_DIR)/,$(OBJS))
DEPS := $(addprefix $(DEPS_DIR)/,$(DEPS))

ALL_OBJS := $(wildcard $(OBJS_DIR)/*.o)
ALL_OBJS += $(OBJS)

#  ---------- Rulers

Default:$(DEPS) $(OBJS) $(BIN)
	@echo "--Good Sub Job!"

ifneq ("$(wildcard $(DEPS))", "")
include $(DEPS)
endif

$(DEPS_DIR)/%.d:%.c
	echo "INCS_DIR = $(INCS_DIR)"
	gcc -I$(INCS_DIR) -MM $(filter %.c, $^) | sed 's,\(.*\)\.o[ :]*,$(OBJS_DIR)/\1\.o $@:,g'> $@

$(OBJS_DIR)/%.o:%.c
	gcc -I$(INCS_DIR) -o $@ -c $(filter %.c, $^)

$(BIN):$(ALL_OBJS)
	gcc -o $@ $^ 

#  ---------- PHONYS

print:
	@echo "CUR_SUB_DIR:$(CUR_SUB_DIR)"
	@echo "SRCS : $(SRCS)" 
	@echo "OBJS : $(OBJS)"
	@echo "DEPS : $(DEPS)"

clean:
	rm -f $(BIN) $(OBJS) $(DEPS)
