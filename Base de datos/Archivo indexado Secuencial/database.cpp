#include "Database.h"
#include <cstddef>
#include <iostream>
#include <iomanip>
#include <algorithm>
#include <cmath>

Database::Database(int OVER, int OMAX, int N){
    mOVER = OVER;
    mOMAX = OMAX;
    mRegisterPerBlock = N;
    mPMAX = mOVER - 1;
    mNumberOfBlocks = mPMAX / N;
    initializeAreas();
}

void Database::initializeAreas(){
    mDataArea = new Datos[mOMAX];
    mIndexArea = new int*[mNumberOfBlocks];

    for(int i = 0; i < mNumberOfBlocks; i++){
        mIndexArea[i] = new int[2]{0, i * mRegisterPerBlock};
    }
}

void Database::addRegister(const Datos& reg) {
    if (reg.mClave <= 0) {
        std::cout << "Cannot add register with invalid key\n";
        return;
    }
    for (int block = 0; block < mNumberOfBlocks; block++) {
        if (isLastBlock(block)) {
            if (isOverPopulated(getStartingIndex(block), reg)) {
                if (block == mNumberOfBlocks - 1) {
                    insertInBlock(reg, getStartingIndex(block));
                    updateMinimumKey(block);
                    std::cout << "Register added successfully to block " << block << "\n";
                    break;
                }
            } else {
                insertInBlock(reg, getStartingIndex(block));
                updateMinimumKey(block);
                std::cout << "Register added successfully to block " << block << "\n";
                break;
            }
        } else {
            if (isNextValueGreaterThanRegister(block + 1, reg.mClave)) {
                insertInBlock(reg, getStartingIndex(block));
                updateMinimumKey(block);
                std::cout << "Register added successfully to block " << block << "\n";
                break;
            }
        }
    }
}

void Database::updateMinimumKey(int index){
    mIndexArea[index][0] = mDataArea[getStartingIndex(index)].mClave;
}

void Database::insertInBlock(const Datos& reg, int blockIndex) {
    for (int i = blockIndex; i < blockIndex + mRegisterPerBlock; i++) {
        if (mDataArea[i].mClave == 0) {
            mDataArea[i] = reg;
            sortAscending(blockIndex);
            return;
        }
        if (mDataArea[i].mClave == reg.mClave) {
            std::cout << "Can't add a register with the same key\n";
            return;
        }
    }

    insertInOverflow(reg, blockIndex + mRegisterPerBlock);
}

void Database::insertInOverflow(const Datos& reg, int index) {
    if (mOMAX == mOVER) {
        std::cout << "Cannot add more registers, there is no more space available. GET MORE RAM!\n";
        return;
    }

    mDataArea[mOVER - 1] = reg;

    if (mDataArea[index - 1].mIndex == -1) {
        mDataArea[index - 1].setIndex(mOVER - 1);
    }

    mOVER++;

    sortAscending(index - mRegisterPerBlock);
}

bool Database::isLastBlock(int index) {
    if (index < mNumberOfBlocks - 1) {
        return mIndexArea[index + 1][0] == 0;
    }

    return true;
}

bool Database::isOverPopulated(int index, const Datos& reg) {
    int cont = std::count_if(&mDataArea[index], &mDataArea[index + mRegisterPerBlock],
            [](const Datos& data) { return data.mClave != 0; });

    int min = mDataArea[index].mClave;
    int max = mDataArea[index + cont - 1].mClave;

    if (reg.mClave > min && reg.mClave < max) {
        return false;
    }

    return cont >= ceil(mRegisterPerBlock / 2);
}

Datos Database::findRegister(int keyToFind) {
    int indexOfBlock = getBlock(keyToFind);
    Datos temp;

    if (indexOfBlock == -1) {
        return temp;
    }

    auto begin = mDataArea + indexOfBlock;
    auto end = mDataArea + indexOfBlock + mRegisterPerBlock;

    auto it = std::find_if(begin, end, [keyToFind](const Datos& data) {
        return data.mClave == keyToFind;
    });

    if (it != end) {
        return *it;
    }

    for (int i = mDataArea[indexOfBlock + mRegisterPerBlock - 1].mIndex; i < mOMAX; i++) {
        if (mDataArea[i].mClave == keyToFind) {
            return mDataArea[i];
        }
    }

    return temp;
}

int Database::getBlock(int keyToFind) {
    int bloque = -1;
    for (int i = 0; i < mNumberOfBlocks; i++) {
        if (i == mNumberOfBlocks - 1 && keyToFind >= mIndexArea[i][0]) {
            bloque = mIndexArea[i][1];
        } else if (keyToFind >= mIndexArea[i][0] && keyToFind <= mIndexArea[i + 1][0]) {
            bloque = mIndexArea[i][1];
        }
    }
    return bloque;
}

bool Database::isNextValueGreaterThanRegister(int index, int value){
    return mIndexArea[index][0] > value;
}

Datos Database::getElementAt(int index){
    return mDataArea[index];
}

int Database::getStartingIndex(int index){
    return mIndexArea[index][1];
}

void Database::sortAscending(int index) {
    bool sorted = false;
    while (!sorted) {
        sorted = true;
        for (int i = index; i < (index + mRegisterPerBlock - 1); i++) {
            if (mDataArea[i].mClave != 0 && mDataArea[i+1].mClave  != 0 &&
                    mDataArea[i].mClave > mDataArea[i + 1].mClave) {
                std::swap(mDataArea[i], mDataArea[i + 1]);
                sorted = false;
            }
        }
    }
}


void Database::showAreas() {
    std::cout << "-----------------------------------------" << std::endl;
    std::cout << "|      Area de indices                  |" << std::endl;
    std::cout << "|   Clave Minima ---- Direccion         |" << std::endl;
    std::cout << "-----------------------------------------" << std::endl;

    for (int i = 0; i < mNumberOfBlocks; i++) {
        std::cout << "| " << std::setw(14) << std::left << mIndexArea[i][0] << " | " << std::setw(20) << std::left << mIndexArea[i][1] << " |" << std::endl;
    }
    std::cout << "-----------------------------------------" << std::endl;

    std::cout << std::endl;
    std::cout << "-----------------------------------------" << std::endl;
    std::cout << "|     Area primaria de Datos            |" << std::endl;
    std::cout << "-----------------------------------------" << std::endl;
    std::cout << "|   Clave  |     Valor      | Direccion |" << std::endl;
    std::cout << "-----------------------------------------" << std::endl;

    for (int i = 0; i < mPMAX; i++) {
        if (i % mRegisterPerBlock == 0){
            std::cout << "-----------------------------------------" << std::endl;
        }
        std::cout << "| " << std::setw(8) << std::left << mDataArea[i].mClave << " | " << std::setw(14) << std::left << mDataArea[i].mDato << " | " << std::setw(10) << std::left << mDataArea[i].mIndex << "|" << std::endl;
    }
    std::cout << "-----------------------------------------" << std::endl;

    std::cout << std::endl;
    std::cout << "-----------------------------------------" << std::endl;
    std::cout << "|           Overflow                    |" << std::endl;
    std::cout << "-----------------------------------------" << std::endl;
    std::cout << "|   Clave  |     Valor      |           |" << std::endl;
    std::cout << "-----------------------------------------" << std::endl;

    for (int i = mPMAX; i < mOMAX; i++) {
        std::cout << "| " << std::setw(8) << std::left << mDataArea[i].mClave << " | " << std::setw(14) << std::left << mDataArea[i].mDato << " |           |" << std::endl;
    }
    std::cout << "-----------------------------------------" << std::endl;
}


