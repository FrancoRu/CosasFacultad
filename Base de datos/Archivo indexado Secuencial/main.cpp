#include <iostream>
#include "database.h"
using namespace std;

int main()
{
    DataBase base(13,20,4);
    datos dato1(1,'a');
    datos dato2(15,'b');
    datos dato3(9,'c');
    datos dato4(8,'d');
    datos dato5(16,'e');
    datos dato6(18,'a');
    datos dato7(19,'b');
    datos dato8(25,'c');
    datos dato9(17,'d');
    datos dato10(30,'e');
    //datos dato11(9,'a');
    datos dato12(32,'e');
    datos dato13(33,'Z');
     datos dato14(0,'e');
     datos dato15(10,'e');
     //datos dato16(11,'e');
    base.add(dato1);
    base.add(dato2);
    base.add(dato3);
    base.add(dato4);
    base.add(dato5);
    base.add(dato6);
    base.add(dato7);
    //base.show();
    base.add(dato8);
    base.add(dato9);
    base.add(dato10);
    //base.add(dato11);
    base.add(dato12);
    base.add(dato13);
    base.add(dato14);
    base.show();
    std::cout<<base.find(34).getDato()<<std::endl;
}
