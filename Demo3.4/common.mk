.PHONY:print clean

#  ---------- Dirs

CUR_SUB_DIR := $(shell pwd)

OBJS_DIR := /home/illidan/MKDemo/Demo3.4/Objs
$(shell mkdir -p $(OBJS_DIR))

#  ---------- Vars

SRCS := $(wildcard *.c)
OBJS := $(SRCS:.c=.o)
DEPS := $(SRCS:.c=.d)

OBJS := $(addprefix $(OBJS_DIR)/,$(OBJS))

ALL_OBJS := $(wildcard $(OBJS_DIR)/*.o)
ALL_OBJS += $(OBJS)

#  ---------- Rulers

Default:$(DEPS) $(ALL_OBJS) $(BIN)
	@echo "--Good Sub Job!"

ifneq ("$(wildcard $(DEPS))", "")
include $(DEPS)
endif

$(BIN):$(ALL_OBJS)
	gcc -o $@ $^ 

$(OBJS_DIR)/%.o:%.c
	gcc -o $@ -c $(filter %.c, $^)

%.d:%.c
	gcc -MM $^ | sed 's,\(.*\).o[ :]*,$(OBJS_DIR)/\1\.o:,g'> $@

#  ---------- PHONYS

print:
	@echo "CUR_SUB_DIR:$(CUR_SUB_DIR)"
	@echo "SRCS : $(SRCS)" 
	@echo "OBJS : $(OBJS)"
	@echo "DEPS : $(DEPS)"

clean:
	rm -f $(BIN) $(OBJS) $(DEPS)
