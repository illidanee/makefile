#include<stdio.h>
#include "lcd.h"
#include "usb.h"
#include "media.h"
#include "base.h"
#include "math.h"
int main()
{
	printf("MP3 player init...\n");
	lcd_init();
	usb_init();
	media_init();
	base_init();
	math_init();
	return 0;
}
