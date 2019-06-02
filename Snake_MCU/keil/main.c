#include <reg51.h>
#include <stdlib.h>

#define uchar unsigned char
#define uint unsigned int

#define EAT 2
#define MOVE 1
#define CRASH 0

#define ON 0
#define OFF 1

#define LEN 80

uchar snake[LEN];
uchar grid[16];
uchar key = 0;
uchar alive = 1;
uchar head = 1;
uchar tail = 0;
uchar food = 0x44;
uchar column = 0;
uchar random = 0;
uchar counter = 0;

sbit U = P0 ^ 0;
sbit L = P0 ^ 1;
sbit R = P0 ^ 2;
sbit D = P0 ^ 3;

void timeInit(void);
void snakeInit(void);
void display(void);
uchar control(void);
uchar keyDetect(void);
uchar randomNum(void);
uchar randomFood(void);
uchar showColumn(uchar col);
uchar isOn(uchar x, uchar y);
uchar isFood(uchar x, uchar y);
uchar getStatus(uchar x, uchar y);
uchar setPoint(uchar pos, uchar off);
uchar setPos(uchar x, uchar y, uchar index);
uchar getPos(uchar *x, uchar *y, uchar index);


void main()
{
	timeInit();
	snakeInit();
	while (1)
	{
		display();
		keyDetect();
		randomNum();
	}
}

void timeIRQ(void) interrupt 1 using 0
{
	counter++;

	if (counter == 5)
	{
		counter = 0;
		if (alive == 1)
			control();
	}
}

uchar control(void)
{
	uchar x, y, status;
	getPos(&x, &y, head);
	switch (key)
	{
	case 'U':
		y--;
		break;
	case 'D':
		y++;
		break;
	case 'L':
		x--;
		break;
	case 'R':
		x++;
		break;
	default:
		break;
	}

	status = getStatus(x, y);
	switch (status)
	{
	case EAT:
		head = (head + 1) % LEN;
		setPos(x, y, head);
		food = randomFood();
		setPoint(food, ON);
		break;
	case MOVE:
		head = (head + 1) % LEN;
		setPos(x, y, head);
		setPoint(snake[head], ON);
		setPoint(snake[tail], OFF);
		tail = (tail + 1) % LEN;
		break;
	case CRASH:
		alive = 0;
		break;
	default:
		break;
	}

	return 0;
}

uchar keyDetect(void)
{
	if (U == 0)
		key = 'U';
	else if (D == 0)
		key = 'D';
	else if (L == 0)
		key = 'L';
	else if (R == 0)
		key = 'R';
	else
		return 0;

	return key;
}

void timeInit(void)
{
	TMOD = 0x01;
	TH0 = (65536 - 50000) / 256; //50 ms
	TL0 = (65536 - 50000) % 256;
	ET0 = 1;
	TR0 = 1;
	EA = 1;
}

void snakeInit(void)
{
	int i = 0;
	for (i = 0; i < 16; i++)
		grid[i] = 0xff;

	head = 1;
	snake[1] = 0x13;
	setPoint(snake[1], ON);

	tail = 0;
	snake[0] = 0x03;
	setPoint(snake[0], ON);

	food = 0x83;
	setPoint(food, ON);

	key = 'R';
	alive = 1;
}

uchar setPoint(uchar pos, uchar off)
{
	uchar x = pos >> 4;
	uchar y = pos & 0x0f;

	if (x < 0 || x > 15 || y < 0 || y > 7)
		return 0;
	else
	{
		uchar col = 0x80 >> y;
		if (off)
			grid[x] |= col;
		else
			grid[x] &= (0xff - col);
		return 1;
	}
}

void display(void)
{
	if (column == 15)
		column = 0;
	else
		column++;
	
	showColumn(column);
}

uchar showColumn(uchar col)
{
	if (col >= 0 && col <= 7)
	{
		P2 = 0x80 >> col;
		P3 = 0x00;
		P1 = grid[col];
		return 1;
	}
	else if (col >= 8 && col <= 15)
	{
		P3 = 0x80 >> (col - 8);
		P2 = 0x00;
		P1 = grid[col];
		return 1;
	}
	else
		return 0;
}

uchar getPos(uchar *x, uchar *y, uchar index)
{
	if (index < 0 || index > 128)
		return 0;
	else
	{
		uchar pos = snake[index];
		*x = pos >> 4;
		*y = pos & 0x0f;
		return 1;
	}
}

uchar setPos(uchar x, uchar y, uchar index)
{
	if (index < 0 || index > 128)
		return 0;
	else
	{
		snake[index] = x << 4;
		snake[index] += y;
		return 1;
	}
}

uchar getStatus(uchar x, uchar y)
{
	if (x < 0 || x > 15 || y < 0 || y > 7)
		return CRASH;
	else if (isOn(x, y))
	{
		if (isFood(x, y))
			return EAT;
		else
			return CRASH;
	}
	else
		return MOVE;
}

uchar isOn(uchar x, uchar y)
{
	if (x < 0 || x > 15 || y < 0 || y > 7)
		return 0;
	else
	{
		uchar col = 0x80 >> y;
		col &= grid[x];
		if (col)
			return 0;
		else
			return 1;
	}
}

uchar isFood(uchar x, uchar y)
{
	if (x < 0 || x > 15 || y < 0 || y > 7)
		return 0;
	else if (y == (food & 0x0f) && x == (food >> 4))
		return 1;
	else
		return 0;
}

uchar randomNum(void)
{
	uint num = rand();
	num *= head;
	num += key;
	random =  num % 0xff;
	return random;
}

uchar randomFood(void)
{
	uchar pos = random & 0xf7;
	while (isOn(pos >> 4, pos & 0x0f))
	{
		pos = (pos + random) % 0xff;
		pos &= 0xf7;
	}
	
	return pos;
}