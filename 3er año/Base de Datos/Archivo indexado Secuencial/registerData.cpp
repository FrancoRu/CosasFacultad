#include "registerData.h"

registerData::registerData(int clave, char dato){
    mClave = clave;
    mDato = dato;
    mIndex = -1;
}

registerData::registerData(){
    mClave = 0;
    mDato = '*';
    mIndex = -1;
}

int registerData::getClave()
{
    return mClave;
}

char registerData::getDato()
{
    return mDato;
}

int registerData::getIndex()
{
    return mIndex;
}

void registerData::setInfo(int clave, char dato){
    mDato = dato;
    mClave = clave;
}

void registerData::setIndex(int index)
{
    mIndex = index;
}
