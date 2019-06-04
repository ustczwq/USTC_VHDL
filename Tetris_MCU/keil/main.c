#include <reg51.h>
#include <stdlib.h>

#define uchar unsigned char
#define uint unsigned int

#define MOVE 2
#define FIX 1
#define OUT 0

#define ON 0
#define OFF 1

sbit U = P0 ^ 0;
sbit L = P0 ^ 1;
sbit R = P0 ^ 2;
sbit D = P0 ^ 3;

uchar grid[16];
uchar key = 0;
uchar row = 0;
uchar alive = 1;
uchar index = 0;
uchar random = 0;
uchar ctrlCounter = 0;
uchar fallCounter = 0;
uchar dx = 0, dy = 0;

uchar code shape[28][4][2] = {
    {{0, 0}, {0, 1}, {1, 0}, {1, 1}}, // 7 basic shapes
    {{0, 0}, {1, 0}, {2, 0}, {3, 0}},
    {{0, 0}, {0, 1}, {1, 1}, {2, 1}},
    {{1, 0}, {0, 1}, {1, 1}, {2, 1}},
    {{2, 0}, {0, 1}, {1, 1}, {2, 1}},
    {{0, 0}, {1, 0}, {1, 1}, {2, 1}},
    {{1, 0}, {2, 0}, {0, 1}, {1, 1}},

    {{0, 0}, {0, 1}, {1, 0}, {1, 1}}, // rotate 90  deg
    {{0, 0}, {0, 1}, {0, 2}, {0, 3}},
    {{1, 0}, {0, 0}, {0, 1}, {0, 2}},
    {{1, 1}, {0, 0}, {0, 1}, {0, 2}},
    {{1, 2}, {0, 0}, {0, 1}, {0, 2}},
    {{0, 1}, {0, 2}, {1, 0}, {1, 1}},
    {{0, 0}, {0, 1}, {1, 1}, {1, 2}},

    {{0, 0}, {0, 1}, {1, 0}, {1, 1}}, // rotate 180 deg
    {{0, 0}, {1, 0}, {2, 0}, {3, 0}},
    {{0, 0}, {1, 0}, {2, 0}, {2, 1}},
    {{0, 0}, {1, 0}, {2, 0}, {1, 1}},
    {{0, 0}, {1, 0}, {2, 0}, {0, 1}},
    {{0, 0}, {1, 0}, {1, 1}, {2, 1}},
    {{1, 0}, {2, 0}, {0, 1}, {1, 1}},

    {{0, 0}, {0, 1}, {1, 0}, {1, 1}}, // rotate 270 deg
    {{0, 0}, {0, 1}, {0, 2}, {0, 3}},
    {{0, 2}, {1, 0}, {1, 1}, {1, 2}},
    {{0, 1}, {1, 0}, {1, 1}, {1, 2}},
    {{0, 0}, {1, 0}, {1, 1}, {1, 2}},
    {{0, 1}, {0, 2}, {1, 0}, {1, 1}},
    {{0, 0}, {0, 1}, {1, 1}, {1, 2}},
};

void timeInit(void);
void control();
void keyDetect(void);
void tetrisInit(void);
void clearGrid(void);
uchar showRow(uchar r);
void display(void);
uchar isOn(uchar x, uchar y);
uchar getStatus(uchar _index, uchar _dx, uchar _dy);
uchar getRotate(void);
void delay(uint m);
void fakeRandom(void);
void fixTerm(uchar _dx, uchar _dy);
void removeFull(void);

void main()
{
    timeInit();
    tetrisInit();
    while (1)
    {
        display();
        fakeRandom();
        delay(200);
    }
}

void delay(uint m)
{
    while (m--)
        ;
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

void timeIRQ(void) interrupt 1 using 0
{
    removeFull();
    
    if (ctrlCounter == 2)
    {
        ctrlCounter = 0;
        if (alive == 1)
            control();
    }
    else
        ctrlCounter++;
}

void control()
{
    uchar _dx = dx;
    uchar _dy = dy;
    uchar status = MOVE;

    keyDetect();

    switch (key)
    {
    case 'U':
        index = getRotate();
        break;
    case 'D':
        _dy++;
        break;
    case 'L':
        _dx--;
        break;
    case 'R':
        _dx++;
        break;
    default:
        break;
    }

    if (fallCounter == 1)
    {
        fallCounter = 0;
        _dy++;
    }
    else
        fallCounter++;

    status = getStatus(index, _dx, _dy);
    switch (status)
    {
    case MOVE:
        dx = _dx;
        dy = _dy;
        break;
    case FIX:
        fixTerm(_dx, _dy);
        index = random;
        dx = 0;
        dy = 0;
        break;
    case OUT:
        break;
    default:
        break;
    }
}

void keyDetect(void)
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
        key = 0;
}

void tetrisInit(void)
{
    alive = 1;
    index = 0;
    dx = 0;
    dy = 0;
    clearGrid();
}

void clearGrid(void)
{
    uchar i = 0;
    for (i = 0; i < 16; i++)
        grid[i] = 0xff;
}

uchar showRow(uchar num)
{
    uchar i = 0, x = 0, y = 0, p = 0;

    if (num < 0 || num > 15)
        return 0;
    else
    {
        p = grid[num];
        if (num < 8)
        {
            P3 = 0x01 << num;
            P2 = 0x00;
        }
        else
        {
            P2 = 0x01 << (num - 8);
            P3 = 0x00;
        }
        for (i = 0; i < 4; i++)
        {
            x = shape[index][i][0] + dx;
            y = shape[index][i][1] + dy;
            if (y == num)
                p &= ~(0x80 >> x);
        }
        P1 = p;
        return 1;
    }
}

void display(void)
{
    showRow(row);

    if (row == 15)
        row = 0;
    else
        row++;
}

uchar isOn(uchar x, uchar y)
{
    if (x < 0 || x > 7 || y < 0 || y > 15)
        return 0;
    else
    {
        uchar r = 0x80 >> x;
        r &= grid[y];
        if (r)
            return 0;
        else
            return 1;
    }
}

uchar getStatus(uchar _index, uchar _dx, uchar _dy)
{
    uchar i = 0, _x = 0, _y = 0;
    uchar status = MOVE;

    for (i = 0; i < 4; i++)
    {
        _x = shape[_index][i][0] + _dx;
        _y = shape[_index][i][1] + _dy + 1;
        if (_x < 0 || _x > 7 || _y < 0 || _y > 16)
        {
            status = OUT;
            break;
        }
        else if (_y == 16 || isOn(_x, _y))
        {
            status = FIX;
            break;
        }
    }
    return status;
}

uchar getRotate(void)
{
    uchar _index = (index + 7) % 28;

    if (MOVE == getStatus(_index, dx, dy))
        return _index;
    else
        return index;
}

void fakeRandom(void)
{
    uint num = rand();
    num *= (ctrlCounter + 1);
    num += random;
    num += index;
    num += key;
    random = num % 28;
}

void fixTerm(uchar _dx, uchar _dy)
{
    uchar i = 0, x = 0, y = 0, p = 0;
    for (i = 0; i < 4; i++)
    {
        x = shape[index][i][0] + _dx;
        y = shape[index][i][1] + _dy;
        grid[y] &= ~(0x80 >> x);
    }
}

void removeFull(void)
{
    uchar i = 15, j = 15;

    for (i = 15; i > 0; i--)  
        if (grid[i] != 0x00)
        {
            if (j != i)
                grid[j] = grid[i];
            j--;
        }

    for (j; j > 0; j--)
        grid[j] = 0xff;
}