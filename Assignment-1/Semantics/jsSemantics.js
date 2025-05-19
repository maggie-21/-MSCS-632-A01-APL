function outer() {
    let message = "Hello";
    return function inner() {
        console.log("Closure message:", message);  // Closure
    };
}

function scopedFunction() {
    let x = 10;
    if (true) {
        let y = 20;
        console.log("Scope y:", y); // ✅ Block scoped and accessible here
    }
    console.log("Scope x:", x);
    // console.log("Scope y:", y); // ❌ Uncommenting this will error - block-scoped
}

function addDynamic(a, b) {
    return a + b;  // May result in coercion
}

// Closure
const closureFunc = outer();
closureFunc();

// Scope
scopedFunction();

// Type system
console.log("Add integers:", addDynamic(5, 3));
console.log("Add strings:", addDynamic("5", "3"));
console.log("Add string and int:", addDynamic("5", 3));  // "53"
