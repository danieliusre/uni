import matplotlib.pyplot as plt

def simpsons_rule(f, a, b, n):
    h = round(b - a) / n 
    result = f(a) + f(b)

    for i in range(1, n, 2):
        result += 4 * f(a + i * h)

    for i in range(2, n - 1, 2):
        result += 2 * f(a + i * h)

    result *= h / 3

    return result

def func(x):
    return 2 / x**3

# True value of the integral on [1, 3]
true_value = 8 / 9

# Table header
print(f"{'n': <4}{'h': <10}{'Approximate Value': <20}{'True Error': <20}")

for n in range(20, 201, 20):
    h = round((3 - 1) / n, 3)
    approximate_value = simpsons_rule(func, 1, 3, n)
    true_error = abs(true_value - approximate_value)

    print(f"{n:<4}{h:<10}{approximate_value:<20}{true_error:<20}")

n_values = []
h_values = []
approx_values = []
true_errors = []

for n in range(20, 201, 20):
    h = round((3 - 1) / n, 3)
    approximate_value = simpsons_rule(func, 1, 3, n)
    true_error = abs(true_value - approximate_value)

    n_values.append(n)
    h_values.append(h)
    approx_values.append(approximate_value)
    true_errors.append(true_error)

# Plot
plt.figure(figsize=(10, 6))
plt.loglog(h_values, true_errors, marker='o', linestyle='-', color='b')
plt.title('Error Analysis for Simpson\'s Rule')
plt.xlabel('h (Step Size)')
plt.ylabel('True Error')
plt.grid(True)
plt.show()