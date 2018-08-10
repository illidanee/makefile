.PHONY:Default clean

BIN := mp3

SRCS := $(wildcard *.c)
OBJS := $(SRCS:.c=.o)
DEPS := $(SRCS:.c=.d)

Default:Print $(DEPS) $(BIN)
	@echo "-----------------------------------------------------------------" 
	@echo "                      Good job!  ~(@^_^@)~" 
	@echo "-----------------------------------------------------------------" 

Print:
	@echo "SRCS : $(SRCS)" 
	@echo "OBJS : $(OBJS)"
	@echo "DEPS : $(DEPS)"

ifneq ("$(wildcard $(DEPS))", "")
include $(DEPS)
endif

$(BIN):$(OBJS)
	gcc -o $@ $^

%.o:%.c
	gcc -o $@ -c $(filter %.c, $^)

%.d:%.c
	gcc -MM $^ > $@

clean:
	rm -f $(BIN) $(OBJS) $(DEPS)
