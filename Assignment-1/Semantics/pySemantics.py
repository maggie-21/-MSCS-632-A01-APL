def outer():
    message = "Hello"
    def inner():
        print("Closure message:", message)  # Closure
    return inner

def scoped_function():
    x = 10
    if True:
        y = 20
    print("Scope x:", x)
    print("Scope y:", y)  # y is accessible due to Python's function-level scope

def dynamic_typing_example(a, b):
    return a + b  # Works with both strings and integers

# Closure
closure_func = outer()
closure_func()

# Scope
scoped_function()

# Type system
print("Add integers:", dynamic_typing_example(5, 3))
print("Add strings:", dynamic_typing_example("5", "3"))
