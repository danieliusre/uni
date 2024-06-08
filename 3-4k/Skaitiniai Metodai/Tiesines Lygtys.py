#Danielius Rekus 2016028
#Studento Nr 8 - Uzd 8 ir 12
import numpy as np
import time
import matplotlib.pyplot as plt

#-------------------8-------------------
def generate_penta_matrix(N):
    A = np.zeros((N, N))
    for i in range(N):
        if i == 0:
            A[i, i] = 30
            if N > 1:
                A[i, i + 1] = -16
                if N > 2:
                    A[i, i + 2] = 1
        elif i == 1:
            A[i, i] = 30
            A[i, i - 1] = -16
            if N > 2:
                A[i, i + 1] = -16
            if N > 3:
                A[i, i + 2] = 1
        elif i == N - 1:
            A[i, i] = 30
            A[i, i - 1] = -16
            if N > 2:
                A[i, i - 2] = 1
        elif i == N - 2:
            A[i, i] = 30
            A[i, i - 1] = -16
            A[i, i + 1] = -16
            A[i, i - 2] = 1
        else:
            A[i, i - 2] = 1
            A[i, i - 1] = -16
            A[i, i] = 30
            A[i, i + 1] = -16
            A[i, i + 2] = 1

    return A

# Cholesky Decomposition
def perform_cholesky_decomposition(A, N):
    L = np.zeros((N, N))
    iterations = 0

    for i in range(N):
        for j in range(i + 1):
            s = sum(L[i][k] * L[j][k] for k in range(j))
            iterations += j + 1  # Increment iteration count for each inner loop

            if i == j:
                L[i][j] = np.sqrt(A[i][i] - s)
            else:
                L[i][j] = (1.0 / L[j][j] * (A[i][j] - s))
    return L, iterations

# Forward substitution
def perform_forward_substitution(L, B, N):
    Y = np.zeros(N)
    for i in range(N):
        Y[i] = B[i]
        for j in range(i):
            Y[i] -= L[i][j] * Y[j]
        Y[i] /= L[i][i]
    return Y

# Backward substitution
def perform_backward_substitution(L_T, Y, N):
    X = np.zeros(N)
    for i in range(N - 1, -1, -1):
        X[i] = Y[i]
        for j in range(i + 1, N):
            X[i] -= L_T[j][i] * X[j]
        X[i] /= L_T[i][i]
    return X

def generate_F_vector(N, X):
    c = 1 / ((N + 1) ** 2)
    F = [c + 2 * (X[i + 1] - X[i - 1])**2 if i != 0 and i != N - 1 else c + 2 * (X[i] - X[N - 2])**2 for i in range(N)]
    return F

def solve_cholesky_iterative(N, epsilon):
    A = generate_penta_matrix(N)
    print("Matrix A:\n", A)
    X = np.zeros(N)
    L, cholesky_iterations = perform_cholesky_decomposition(A, N)

    iteration = 0
    start_time = time.time()
    while True:
        F = generate_F_vector(N, X)

        Y = perform_forward_substitution(L, F, N)
        X_new = perform_backward_substitution(L.T, Y, N)

        error = np.max(np.abs(X_new - X))
        if error < epsilon:
            break
        X = X_new
        iteration += 1

    end_time = time.time()
    elapsed_time = end_time - start_time

    print(f"N = {N}, Iterations (Cholesky): {cholesky_iterations}")
    print(f"N = {N}, Iterations (Iterative): {iteration}")
    print("Solution X:", X_new)
    print(f"Elapsed time: {elapsed_time:.6f} seconds\n")

    return elapsed_time

def analyze_runtimes(start_N, end_N, step, epsilon):
    n_values = np.arange(start_N, end_N + 1, step)
    runtimes = []

    for N in n_values:
        elapsed_time = solve_cholesky_iterative(N, epsilon)
        runtimes.append(elapsed_time)

    plt.figure(figsize=(8, 6))
    plt.plot(n_values, runtimes, linestyle='-')
    plt.title("Cholesky Decomposition Runtimes")
    plt.xlabel("N")
    plt.ylabel("Runtime (seconds)")
    plt.grid(True)
    plt.show()

N = 10
error = 1e-6
solve_cholesky_iterative(N, error)
#analyze_runtimes(1, 15, 1, 1e-6)
#-------------------12-------------------

def jacobi_method(A, b, x, epsilon, max_iterations):
    D = np.diag(np.diag(A))
    LU = A - D
    x_prev = x.copy()

    for iteration in range(max_iterations):
        x = np.dot(np.linalg.inv(D), b - np.dot(LU, x))
        if np.linalg.norm(x - x_prev, np.inf) < epsilon:
            return x, iteration + 1
        x_prev = x.copy()

    return x, max_iterations

def jacobi_method2(A, b, x, epsilon, max_iterations):
    n = len(A)
    D = np.zeros((n, n))
    LU = np.zeros((n, n))

    for i in range(n):
        D[i, i] = A[i, i]
        for j in range(n):
            if i != j:
                LU[i, j] = A[i, j]

    x_prev = np.copy(x)

    for iteration in range(max_iterations):
        for i in range(n):
            sigma = 0
            for j in range(n):
                if i != j:
                    sigma += A[i, j] * x_prev[j]
            x[i] = (b[i] - sigma) / A[i, i]

        if np.max(np.abs(x - x_prev)) < epsilon:
            return x, iteration + 1
        x_prev = np.copy(x)

    return x, max_iterations

N = 10
error = 1e-6
A = generate_penta_matrix(N)
X = np.zeros(N)
b = generate_F_vector(N, X)
max_iterations = 1000

solution, iterations = jacobi_method2(A, b, X, error, max_iterations)
print("\n Jacobi Method\nSolution:", solution)
print("Number of Iterations:", iterations)
