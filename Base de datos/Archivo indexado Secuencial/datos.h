#ifndef DATOS_H
#define DATOS_H


class datos
{
private:
    int clave;
    char dato;
    int index;
public:
    datos(int, char);
    datos();
    int getClave();
    char getDato();
    int getIndex();
    void setInfo(int, char);
    void setIndex(int);
};

#endif // DATOS_H
