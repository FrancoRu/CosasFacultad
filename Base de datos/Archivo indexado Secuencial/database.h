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
    void updateKey(int);
    void insert(datos, int);
    void insertOF(datos, int);
    bool isLastBlock(int);
    bool isSobrePoblado(int, datos);
    int block(int);
    bool nextMax(int, int);
    datos element(int);
    int getMap(int);
    void sort(int);
    void carga();
public:
    DataBase(int, int, int);
    void add(datos);
    datos find(int);
    void show();
};

#endif // DATABASE_H
