#ifndef DATOS_H
#define DATOS_H

class Datos
{
    friend class Database;

private:
    int mClave;
    char mDato;
    int mIndex;
public:
    Datos(int clave, char dato);
    Datos();
    int getClave();
    char getDato();
    int getIndex();
    void setInfo(int clave, char dato);
    void setIndex(int index);
};

#endif // DATOS_H
