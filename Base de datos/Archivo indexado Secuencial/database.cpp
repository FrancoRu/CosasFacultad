#include "database.h"
#include <cstddef>

DataBase::DataBase(int _OVER, int _OMAX, int N){
    this->OVER = _OVER;
    this->OMAX = _OMAX;
    this->NBlocks = N;
    this->PMAX = this->OVER-1;
    this->CANTBLOCK = this->PMAX/N;
    this->arreglo = new datos[OMAX];
    this->mapIndex = new int*[this->CANTBLOCK];
    for(int i=0; i<this->CANTBLOCK; i++){
        this->mapIndex[i] = new int[2];
    }
    for(int i = 0; i<this->CANTBLOCK; i++){
        this->mapIndex[i][0] = 0;
        this->mapIndex[i][1] = i*this->NBlocks;
    }
}


void DataBase::add(datos reg){
    if(reg.getClave()<=0) return;
    for(int i=0; i<this->CANTBLOCK; i++){
        if(isLastBlock(i)){
            if(isSobrePoblado(getMap(i), reg)){
                if(i == this->CANTBLOCK-1){
                    insert(reg, getMap(i));
                    updateKey(i);
                    break;
                }
            }else{
                insert(reg, getMap(i));
                updateKey(i);
                break;
            }
        }else{
            if(nextMax(i+1, reg.getClave())){
                insert(reg, getMap(i));
                updateKey(i);
                break;
            }
        }
    }
}

void DataBase::updateKey(int index){
    this->mapIndex[index][0] = this->arreglo[getMap(index)].getClave();
}

void DataBase::insert(datos reg, int index){
    bool band = true;
    for(int i=index; i<index+this->NBlocks; i++){
        if(this->arreglo[i].getClave()==0){
            this->arreglo[i] = reg;
            sort(index);
            band = false;
            break;
        }
        if(this->arreglo[i].getClave()==reg.getClave()) break;
    }
    if(this->arreglo[index+this->NBlocks-1].getClave()!=0&& band) insertOF(reg, index+this->NBlocks);
}

void DataBase::insertOF(datos reg, int index){
    if(this->OMAX == this->OVER) return;
    this->arreglo[OVER-1] = reg;
    if(this->arreglo[index-1].getIndex()==-1)
        this->arreglo[index-1].setIndex(OVER-1);
    this->OVER++;
    sort(index-this->NBlocks);
}

bool DataBase::isLastBlock(int index){
    if(index<this->CANTBLOCK-1){
        return this->mapIndex[index+1][0] == 0;
    }
    return true;
}

bool DataBase::isSobrePoblado(int index, datos reg){
    int cont = 0;
    int min = this->arreglo[index].getClave();
    for(int i=index; i<index+this->NBlocks; i++){
        if(this->arreglo[i].getClave()!=0) cont++;
    }
    if(reg.getClave()>min&&reg.getClave()<this->arreglo[index+cont-1].getClave()) return false;
    return cont >= this->NBlocks/2;
}

datos DataBase::find(int key){
    int ind = block(key);
    datos temp;
    if(ind == -1) return temp;
    for(int i= ind; i<ind+this->NBlocks;i++){
        if(this->arreglo[i].getClave()==key) temp = this->arreglo[i];
    }
    if(temp.getClave()==0){
        for(int i=this->arreglo[ind+this->NBlocks-1].getIndex(); i<this->OMAX; i++){
            if(this->arreglo[i].getClave()==key) temp = this->arreglo[i];
        }
    }
    return temp;
}

int DataBase::block(int key){
    int bloque = -1;
    for(int i=0; i<this->CANTBLOCK; i++){
        if(i == this->CANTBLOCK-1){
            if(key>= this->mapIndex[i][0]) bloque = this->mapIndex[i][1];
        }else if(key>= this->mapIndex[i][0]&&key<= this->mapIndex[i+1][0]) bloque= this->mapIndex[i][1];
    }
    return bloque;
}

bool DataBase::nextMax(int index, int valor){
    return this->mapIndex[index][0] > valor;
}

datos DataBase::element(int index){
    return this->arreglo[index];
}

int DataBase::getMap(int index){
    return this->mapIndex[index][1];
}
/*
void DataBase::sort(int index){
    datos temp;
    for(int i=index; i<index+this->NBlocks-1; i++){
        for(int j= i+1; j<index+this->NBlocks; j++){
            if(this->arreglo[j].getClave()!=0 && this->arreglo[j+1].getClave()!=0){
                if(this->arreglo[i].getClave()>this->arreglo[j].getClave()){
                    temp = this->arreglo[i];
                    this->arreglo[i] = this->arreglo[j];
                    this->arreglo[j] = temp;
                }
            }else{
                i+=this->OMAX;
                break;
            }

        }
    }
}
*/
void DataBase::sort(int index) {
    for (int i = index; i < index + this->NBlocks - 1; i++) {
        bool swapped = false;
        for (int j = index; j < index + this->NBlocks - i - 1; j++) {
            if (this->arreglo[j].getClave() != 0 && this->arreglo[j + 1].getClave() != 0 &&
                this->arreglo[j].getClave() > this->arreglo[j + 1].getClave()) {
                std::swap(this->arreglo[j], this->arreglo[j + 1]);
                swapped = true;
            }
        }
        if (!swapped) {
            break;
        }
    }
    // Mover elementos con valor 0 al final del arreglo
    int i = index;
    int j = index + this->NBlocks - 1;
    while (i < j) {
        if (this->arreglo[i].getClave() == 0) {
            std::swap(this->arreglo[i], this->arreglo[j]);
            j--;
        } else {
            i++;
        }
    }
}
void DataBase::carga(){
    for(int i=0 ; i<this->CANTBLOCK; i++){
        this->mapIndex[i][1] = i*this->NBlocks;
    }
}


void DataBase::show(){
    std::cout<<"Primary data:"<<std::endl;
    for(int i = 0; i<this->PMAX; i++){
        if(i%this->NBlocks == 0) std::cout<<"------------------"<<std::endl;
        std::cout<<this->arreglo[i].getClave()<<"  Direccionamiento OF "<<this->arreglo[i].getIndex()<<std::endl;
    }
    std::cout<<"------------------"<<std::endl;
    std::cout<<"Overflow:"<<std::endl;
    for(int i = this->PMAX; i<this->OMAX; i++){
        std::cout<<this->arreglo[i].getClave()<<std::endl;
    }
}
