#include <iostream>
#include <functional>  // ✅ Include this for std::function

using namespace std;

// Closure via lambda
std::function<void()> outer() {
    string message = "Hello";
    return [message]() {
        cout << "Closure message: " << message << endl;
    };
}

// Scope demonstration
void scopedFunction() {
    int x = 10;
    if (true) {
        int y = 20;
        cout << "Scope y: " << y << endl;  // ✅ Accessible here
    }
    // cout << y << endl;  // ❌ Uncommenting this gives error: y not in scope
    cout << "Scope x: " << x << endl;
}

// Static type system demonstration
int add(int a, int b) {
    return a + b;
}

int main() {
    // Type system
    cout << "Add: " << add(5, 3) << endl;

    // Closure
    auto closureFunc = outer();
    closureFunc();

    // Scope
    scopedFunction();

    return 0;
}
