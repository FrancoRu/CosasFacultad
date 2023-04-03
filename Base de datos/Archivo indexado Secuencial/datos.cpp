#include "datos.h"

Datos::Datos(int clave, char dato){
    mClave = clave;
    mDato = dato;
    mIndex = -1;
}

Datos::Datos(){
    mClave = 0;
    mDato = '*';
    mIndex = -1;
}

int Datos::getClave()
{
    return mClave;
}

char Datos::getDato()
{
    return mDato;
}

int Datos::getIndex()
{
    return mIndex;
}

void Datos::setInfo(int clave, char dato){
    mDato = dato;
    mClave = clave;
}

void Datos::setIndex(int index)
{
    mIndex = index;
}
