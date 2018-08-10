.PHONY:print clean

CUR_SUB_DIR := $(shell pwd)

SRCS := $(wildcard *.c)
OBJS := $(SRCS:.c=.o)
DEPS := $(SRCS:.c=.d)

Default:$(DEPS) $(OBJS) $(BIN)
	@echo "--Good Sub Job!"

ifneq ("$(wildcard $(DEPS))", "")
include $(DEPS)
endif

$(BIN):$(OBJS)
	gcc -o $@ $^ ../lcd/lcd.o ../usb/usb.o ../media/media.o

%.o:%.c
	gcc -o $@ -c $(filter %.c, $^)

%.d:%.c
	gcc -MM $^ > $@

print:
	@echo "CUR_SUB_DIR:$(CUR_SUB_DIR)"
	@echo "SRCS : $(SRCS)" 
	@echo "OBJS : $(OBJS)"
	@echo "DEPS : $(DEPS)"

clean:
	rm -f $(BIN) $(OBJS) $(DEPS)
