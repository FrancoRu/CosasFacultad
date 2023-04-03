#ifndef Database_H
#define Database_H
#include "Datos.h"
#include <iostream>

class Database
{
private:
    Datos* mDataArea;
    int** mIndexArea;
    int mOMAX;
    int mOVER;
    int mPMAX;
    int mRegisterPerBlock;
    int mNumberOfBlocks;
    void updateMinimumKey(int);
    void insertInBlock(const Datos&, int);
    void insertInOverflow(const Datos& , int);
    bool isOverPopulated(int, const Datos&);
    bool isLastBlock(int);
    bool isNextValueGreaterThanRegister(int, int);
    int getBlock(int);
    Datos getElementAt(int);
    int getStartingIndex(int);
    void sortAscending(int);
    void initializeAreas();

public:
    Database(int, int, int);
    void addRegister(const Datos&);
    Datos findRegister(int);
    void showAreas();
};

#endif // Database_H
