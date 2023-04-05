#ifndef REGISTERDATA_H
#define REGISTERDATA_H

class registerData
{
    friend class indexedSequentialFile;

private:
    int mClave;
    char mDato;
    int mIndex;
public:
    registerData(int clave, char dato);
    registerData();
    int getClave();
    char getDato();
    int getIndex();
    void setInfo(int clave, char dato);
    void setIndex(int index);
};

#endif // REGISTERDATA_H
