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
    if(reg.getClave()==0) return;
    for(int i=0; i<this->CANTBLOCK; i++){
        if(isLastBlock(i)){
            if(isSobrePoblado(getMap(i))){
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
    for(int i=index; i<index+this->NBlocks; i++){
        if(this->arreglo[i].getClave()==0){
            this->arreglo[i] = reg;
            sort(index);
            break;
        }
        if(this->arreglo[i].getClave()==reg.getClave()) break;
    }
    if(this->arreglo[index+this->NBlocks-1].getClave()!=0&&
            this->arreglo[index+this->NBlocks-1].getClave()!=reg.getClave()) insertOF(reg, index+this->NBlocks);
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

bool DataBase::isSobrePoblado(int index){
    int cont = 0;
    for(int i=index; i<index+this->NBlocks; i++){
        if(this->arreglo[i].getClave()!=0) cont++;
    }
    return cont >= this->NBlocks/2;
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

void DataBase::sort(int index){
    datos temp;
    for(int i=index; i<index+this->NBlocks-1; i++){
        for(int j= i+1; j<index+this->NBlocks; j++){
            if(this->arreglo[i].getClave()!=0 && this->arreglo[j].getClave()!=0){
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
