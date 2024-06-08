import numpy as np
import matplotlib.pyplot as plt

def readfile(file_path):
    
    x_coordinates = []
    y_coordinates = []
    
    with open(file_path, 'r') as file:
        lines = file.readlines()
    
        for line in lines:
            x, y = map(float, line.split())
            x_coordinates.append(x)
            y_coordinates.append(y)
    
    #print("x coordinates:", x_coordinates)
    #print("y coordinates:", y_coordinates)
    
    return x_coordinates, y_coordinates

# f1 = a0 + a1x, m = 1
# f2 = a0 + a1x + a2x^2 + a3x^3, m = 3

def findA(m, x, y):
    n = len(x)  
    # phi = (n) x (m + 1)
    Phi = np.zeros((n, m + 1))
    
    for i in range(n):
        for j in range(m + 1):
            Phi[i][j] = x[i] ** j

    # phi.T
    Phi_T = Phi.T

    y_vector = np.array(y).reshape(n, 1)

    # Phi_T * Phi 
    Phi_T_Phi = np.dot(Phi_T, Phi)
    # Phi_T * y
    Phi_T_y = np.dot(Phi_T, y_vector)

    # Phi_T_Phi * a = Phi_T_y
    a = np.linalg.solve(Phi_T_Phi, Phi_T_y)

    #print("Coefficients a:", a)
    
    return a

def calculate_error(a, x, y):
    n = len(x)
    m = len(a) - 1
    Phi = np.zeros((n, m + 1))

    # Construct the matrix Phi
    for i in range(n):
        for j in range(m + 1):
            Phi[i][j] = x[i] ** j

    # Calculate the predicted y values
    y_pred = np.dot(Phi, a)

    # Calculate the error as the sum of squared norms
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
    

file_path = r'C:\Users\danie\Desktop\Skaitiniai Metodai\lab4\duom2.txt'
x_coordinates, y_coordinates = readfile(file_path)

# Model with m=1
a1 = findA(1, x_coordinates, y_coordinates)
error1 = calculate_error(a1, x_coordinates, y_coordinates)
plot(x_coordinates, y_coordinates, a1, f'Model Order m=1 (Error: {error1:.4f})')

# Model with m=3
a3 = findA(3, x_coordinates, y_coordinates)
error3 = calculate_error(a3, x_coordinates, y_coordinates)
plot(x_coordinates, y_coordinates, a3, f'Model Order m=3 (Error: {error3:.4f})')

if error1 < error3:
    print(f"The better function is of order m = 1. (Error: {error1:.4f}) < (Error: {error3:.4f})")
else:
    print(f"The better function is of order m = 3. (Error: {error3:.4f}) < (Error: {error1:.4f})")
    