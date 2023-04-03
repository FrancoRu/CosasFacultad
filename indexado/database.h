#ifndef DATABASE_H
#define DATABASE_H
#include "datos.h"
#include <iostream>
class DataBase
{
private:
    datos* arreglo;
    int** mapIndex;
    int OMAX;
    int OVER;
    int NBlocks;
    int PMAX;
    int CANTBLOCK;
public:
    DataBase(int, int, int);
    void add(datos);
    void updateKey(int);
    void insert(datos, int);
    void insertOF(datos, int);
    bool isLastBlock(int);
    bool isSobrePoblado(int);
    bool nextMax(int, int);
    datos element(int);
    int getMap(int);
    void sort(int);
    void carga();
    void show();
};

#endif // DATABASE_H
