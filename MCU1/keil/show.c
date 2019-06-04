# include <reg51.h>
# define uchar unsigned char
# define uint  unsigned int
	
uchar code table[] = {0xc0, 0xf9, 0xa4, 0xb0, 0x99, 0x92, 0x82, 0xf8, 0x80, 0x90};
uchar m = 0;

void delay(uchar ms)
{
	uchar i , j;
	for (; ms > 0; ms--)
		for (i = 142; i > 0; i--)
			for (j = 2; j > 0; j--);
}


void INT_0() interrupt 0
{
	EX0 = 0;
	delay(20);
	EX0 = 1;
	if (m == 9) m = 0;
	else m++;
	P1 = table[m];
}

void INT_1() interrupt 2
{
	EX1 = 0;
	delay(20);
	EX1 = 1;
	if (m == 0) m = 9;
	else m--;
	P1 = table[m];
}


void main()
{
	P1 = 0x00;
	EA = 1;
	EX0 = 1;
	IT0 = 1;
	EX1 = 1;
	IT1 = 1;
	
	while (1){}
}