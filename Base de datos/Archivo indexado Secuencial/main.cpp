#include <iostream>
#include <limits>
#include "Database.h"
using namespace std;

int main()
{
    int over, omax, n;
    cout << "Enter the initial parameters for the database:" << endl;
    cout << "OVER (value where the overflow area starts): ";
    while (!(cin >> over) || over <= 0) {
        cin.clear();
        cin.ignore(numeric_limits<streamsize>::max(), '\n');
        cout << "Invalid input. Please enter a positive non-zero integer for OVER: ";
    }
    cout << "OMAX (total length of the area of data): ";
    while (!(cin >> omax) || omax <= 0) {
        cin.clear();
        cin.ignore(numeric_limits<streamsize>::max(), '\n');
        cout << "Invalid input. Please enter a positive non-zero integer for OMAX: ";
    }
    cout << "N (number of values per block): ";
    while (!(cin >> n) || n <= 0) {
        cin.clear();
        cin.ignore(numeric_limits<streamsize>::max(), '\n');
        cout << "Invalid input. Please enter a positive non-zero integer for N: ";
    }

    Database base(over + 1, omax, n);
    char choice;
    do {
        cout << endl << "Choose an option:" << endl;
        cout << "1. Add a register" << endl;
        cout << "2. Search for a register" << endl;
        cout << "3. Show areas" << endl;
        cout << "4. Exit" << endl;
        cout << ">> ";
        cin >> choice;

        switch (choice) {
            case '1': {
                int key;
                char value;
                cout << "Enter the key (a positive non-zero integer): ";
                while (!(cin >> key) || key <= 0) {
                    cin.clear();
                    cin.ignore(numeric_limits<streamsize>::max(), '\n');
                    cout << "Invalid input. Please enter a positive non-zero integer for the key: ";
                }
                cout << "Enter the value (a character): ";
                while (!(cin >> value)) {
                    cin.clear();
                    cin.ignore(numeric_limits<streamsize>::max(), '\n');
                    cout << "Invalid input. Please enter a character for the value: ";
                }
                Datos newRegistro(key, value);
                base.addRegister(newRegistro);
                cout << "New register added successfully!" << endl;
                break;
            }
            case '2': {
                int key;
                cout << "Enter the key to search for (a positive non-zero integer): ";
                while (!(cin >> key) || key <= 0) {
                    cin.clear();
                    cin.ignore(numeric_limits<streamsize>::max(), '\n');
                    cout << "Invalid input. Please enter a positive non-zero integer for the key: ";
                }
                Datos registroEncontrado = base.findRegister(key);
                if (registroEncontrado.getDato() != '*') {
                    cout << "Registro encontrado: " << registroEncontrado.getDato() << endl;
                }
                else {
                    cout << "No se ha encontrado el registro con la llave especificada" << endl;
                }
                break;
            }
            case '3': {
                base.showAreas();
                break;
            }
            case '4':
                break;
            default:
                cout << "Invalid choice. Please choose an option from the menu." << endl;
        }
    } while (choice != '4');

    return 0;
}
