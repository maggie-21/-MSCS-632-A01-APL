#include <iostream>
using namespace std;

void printData(int* arr, int size) {
    for (int i = 0; i < size; ++i) {
        cout << arr[i] << " ";
    }
    cout << endl;
}

int main() {
    int* data = new int[5]{1, 2, 3, 4, 5}; // manual heap allocation
    printData(data, 5);
    delete[] data; // manual deallocation
    // If you forget this, memory leak occurs
}
