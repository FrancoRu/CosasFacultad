#ifndef BASEDATOS_H
#define BASEDATOS_H
#include "datos.h"
#include <iostream>
class Base{
private:
    datos* arreglo;
    int OMAX;
    int OVER;
    int NBlocks;
    int PMAX;
    int CANTBLOCK;
public:
    Base(int, int, int);


}
#endif // BASEDATOS_H
/*

int OVER = 13;
const int  OMAX = 20;
const int n = 4;
int PMAX = OVER -1;
int CANTBLOCK = PMAX/n;
*/
