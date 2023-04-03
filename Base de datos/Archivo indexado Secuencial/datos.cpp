#include "datos.h"

datos::datos(int clave, char dato){
    this->clave = clave;
    this->dato = dato;
    this->index = -1;
}

datos::datos(){
    this->index = -1;
    this->clave = 0;
    this->dato = '*';
}

int datos::getClave()
{
    return this->clave;
}

char datos::getDato()
{
    return this->dato;
}

int datos::getIndex()
{
    return this->index;
}

void datos::setInfo(int clave, char dato){
    this->dato = dato;
    this->clave = clave;
}

void datos::setIndex(int index)
{
    this->index = index;
}
