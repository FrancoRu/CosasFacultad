#ifndef indexedSequentialFile_H
#define indexedSequentialFile_H
#include "registerData.h"
#include <iostream>

class indexedSequentialFile
{
private:
    registerData* mDataArea;
    int** mIndexArea;
    int mOMAX;
    int mOVER;
    int mPMAX;
    int mRegisterPerBlock;
    int mNumberOfBlocks;
    void updateMinimumKey(int);
    void insertInBlock(const registerData&, int);
    void insertInOverflow(const registerData& , int);
    bool isOverPopulated(int, const registerData&);
    bool isLastBlock(int);
    bool isNextValueGreaterThanRegister(int, int);
    int getBlock(int);
    registerData getElementAt(int);
    int getStartingIndex(int);
    void sortAscending(int);
    void sortAscendingIndex();
    void initializeAreas();
    bool isBetween(const registerData&, int);

public:
    indexedSequentialFile(int, int, int);
    void addRegister(const registerData&);
    registerData findRegister(int);
    void showAreas();
};

#endif // indexedSequentialFile_H
