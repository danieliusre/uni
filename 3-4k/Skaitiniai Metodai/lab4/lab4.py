import numpy as np
import matplotlib.pyplot as plt
#------------------------------------------------------------------------------
#                                   PART 1
#------------------------------------------------------------------------------
def Aproksimavimas(file_path):
    def readfile(file_path):
        x_coordinates = []
        y_coordinates = []

        with open(file_path, 'r') as file:
            lines = file.readlines()

            for line in lines:
                x, y = map(float, line.split())
                x_coordinates.append(x)
                y_coordinates.append(y)

        return x_coordinates, y_coordinates

    def findA(m, x, y):
        n = len(x)
        Phi = np.zeros((n, m + 1))

        for i in range(n):
            for j in range(m + 1):
                Phi[i][j] = x[i] ** j

        Phi_T = Phi.T
        y_vector = np.array(y).reshape(n, 1)
        Phi_T_Phi = np.dot(Phi_T, Phi)
        Phi_T_y = np.dot(Phi_T, y_vector)
        a = np.linalg.solve(Phi_T_Phi, Phi_T_y)

        return a

    def calculate_error(a, x, y):
        n = len(x)
        m = len(a) - 1
        Phi = np.zeros((n, m + 1))
        

        for i in range(n):
            for j in range(m + 1):
                Phi[i][j] = x[i] ** j

        y_pred = np.dot(Phi, a)
        error = np.sum((y - y_pred) ** 2)

        return error

    def plot(x, y, a, title):
        plt.scatter(x, y, label='Data Points')
        x_range = np.linspace(min(x), max(x), 100)
        y_range = np.polyval(a[::-1], x_range)
        plt.plot(x_range, y_range, label=f'Approximate Function (m={len(a)-1})', color='red')
        plt.title(title)
        plt.xlabel('x')
        plt.ylabel('y')
        plt.legend()
        plt.show()

    x_coordinates, y_coordinates = readfile(file_path)

    a1 = findA(1, x_coordinates, y_coordinates)
    print("a1 coefs:\n", a1)
    error1 = calculate_error(a1, x_coordinates, y_coordinates)
    plot(x_coordinates, y_coordinates, a1, f'Model Order m=1 (Error: {error1:.4f})')

    a3 = findA(3, x_coordinates, y_coordinates)
    print("a3 coefs:\n", a3)
    error3 = calculate_error(a3, x_coordinates, y_coordinates)
    plot(x_coordinates, y_coordinates, a3, f'Model Order m=3 (Error: {error3:.4f})')

    if error1 < error3:
        print(f"The better function is of order m = 1. (Error: {error1:.4f}) < (Error: {error3:.4f})\n")
    else:
        print(f"The better function is of order m = 3. (Error: {error3:.4f}) < (Error: {error1:.4f})\n")
#------------------------------------------------------------------------------
#                                   PART 2
#------------------------------------------------------------------------------
def Integravimas():
    def simpsons_rule(f, a, b, n):
        h = (b - a) / n
        result = f(a) + f(b)

        for i in range(1, n, 2):
            result += 4 * f(a + i * h)

        for i in range(2, n - 1, 2):
            result += 2 * f(a + i * h)

        result *= h / 3

        return result

    def func(x):
        return 2 / x**3

    true_value = 8 / 9
    n_values = []
    h_values = []
    approx_values = []
    true_errors = []
    print(f"{'n': <4}{'h': <10}{'Approximate Value': <20}{'True Error': <20}")

    for n in range(20, 201, 20):
        h = round((3 - 1) / n, 3)
        approximate_value = simpsons_rule(func, 1, 3, n)
        true_error = abs(true_value - approximate_value)

        print(f"{n:<4}{h:<10}{approximate_value:<20}{true_error:<20}")
        n_values.append(n)
        h_values.append(h)
        approx_values.append(approximate_value)
        true_errors.append(true_error)

    plt.figure(figsize=(10, 6))
    plt.loglog(h_values, true_errors, marker='o', linestyle='-', color='b')
    plt.title('Error Analysis for Simpson\'s Rule')
    plt.xlabel('h (Step Size)')
    plt.ylabel('True Error')
    plt.grid(True)
    plt.show()
#------------------------------------------------------------------------------
#                                   PART 3
#------------------------------------------------------------------------------
def Integravimas2():
    def adaptive_simpsons_rule(f, a, b, tol, max_depth=100):
        def recursive_simpsons_rule(a, b, fa, fb, fc, depth):
            h = (b - a) / 2
            c = (a + b) / 2
            f_mid_left = f((a + c) / 2)
            f_mid_right = f((b + c) / 2)
    
            left_simpson = h * (fa + 4 * f_mid_left + fc) / 6
            right_simpson = h * (fc + 4 * f_mid_right + fb) / 6
            approx_integral = left_simpson + right_simpson
            if depth <= 0 or abs(approx_integral-(8/9)) < tol:
                return approx_integral
            else:
                left_integral = recursive_simpsons_rule(a, c, fa, f_mid_left, fc, depth - 1)
                right_integral = recursive_simpsons_rule(c, b, fc, f_mid_right, fb, depth - 1)
                return left_integral + right_integral
    
        fa, fb, fc = f(a), f(b), f((a + b) / 2)
        integral_approximation = recursive_simpsons_rule(a, b, fa, fb, fc, max_depth)
        return integral_approximation
    
    def func(x):
        return 2 / x**3
    
    true_value = 8 / 9
    tolerance = 1e-6
    
    print(f"{'N':<4}{'Approximate Value':<20}{'True Error':<20}")
    n_values = []
    approx_values = []
    true_errors = []
    for n in range(2, 16):
        approximate_value = adaptive_simpsons_rule(func, 1, 3, tolerance, max_depth=n)
        true_error = abs(true_value - approximate_value)
    
        print(f"{n:<4}{approximate_value:<20}{true_error:<20}")
        n_values.append(n)
        approx_values.append(approximate_value)
        true_errors.append(true_error)
    
    plt.figure(figsize=(10, 6))
    plt.plot(n_values, true_errors, marker='o', linestyle='-', color='b')
    plt.title('Error Analysis for Adaptive Simpson\'s Rule')
    plt.xlabel('Depth of Recursion')
    plt.ylabel('True Error')
    plt.grid(True)
    plt.show()

#------------------------------------------------------------------------------
#                                   MAIN
#------------------------------------------------------------------------------
Aproksimavimas(r'duom2.txt')

Integravimas()

Integravimas2()