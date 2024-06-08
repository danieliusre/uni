# funkcija nr.8 : cos(x) = x
# metodai 1, 3
# Danielius Rekus 2016028
import numpy as np
import matplotlib.pyplot as plt

########## SURASTI INTERVALA ##########
# funkcijos
def f0(x):
    return np.cos(x)

def g0(x):
    return x

# basic cos(x) intervalas
x = np.linspace(0, 2*np.pi, 400)

# cos x ir x reiksmes intervale
y1 = f0(x)
y2 = g0(x)

# plot
plt.figure(figsize=(8, 6))
plt.plot(x, y1, label='cos(x)')
plt.plot(x, y2, label='x')
plt.xlabel('x')
plt.ylabel('y')
plt.legend()
plt.grid()
plt.title('Plot of cos(x) and x')
plt.axhline(0, color='black',linewidth=0.5)
plt.axvline(0, color='black',linewidth=0.5)
plt.show()

# cos(x) = x sprendinys intervale [0, 1]
interval_start = 0
interval_end = 1

# funkcija ir isvestine
def f(x):
    return np.cos(x) - x

def df(x):
    return -np.sin(x) - 1

# spejimas
x0 = 0.4

# paprastuju iteraciju metodas (1), g(x) = cos(x)
x_values_fp_conv = [x0]
f_values_fp_conv = [f0(x0)]
q = abs(-np.sin(x0))

def simple_iteration(x0, tol=1e-6, max_iter=100):
    x = x0
    iterations = [] # iteracijos lentelei
    x_values = []  # x reiksmes grafikam

    for i in range(max_iter):
        x_new = np.cos(x)
#       print(f"xnew {x_new:.6f}")
        error = abs(f(x))
        iterations.append((i, x_new, error))
        x_values.append(x_new)

        x_values_fp_conv.append(x_new)
        f_values_fp_conv.append(f0(x_new))
                
        if error < tol:
            return x_new, iterations, x_values
        x = x_new
    return None, iterations, x_values

# Niutono metodas (3)
x_values_newton_conv = [x0]
f_values_newton_conv = [f0(x0)]

def newton_method(x0, tol=1e-6, max_iter=100):
    x = x0
    iterations = [] # iteracijos lentelei
    x_values = []  # x reiksmes grafikam
    for i in range(max_iter):
        x_new = x - f(x) / df(x)
        error = abs(x_new - x)
        iterations.append((i, x_new, error))
        x_values.append(x_new)
        
        x_values_newton_conv.append(x_new)
        f_values_newton_conv.append(f0(x_new))
        
        if error < tol:
            return x_new, iterations, x_values
        x = x_new
    return None, iterations, x_values



# sprendiniai, iteracijos, lenteles
print("\nStarting guess x0:", x0)
if(q < 1):
    print("Convergence Factor q = g'(x0):", q, "< 1, should converge")
    simple_solution, simple_iterations, x_values_simple_iteration = simple_iteration(x0, tol=1e-5)
else:
    print("Convergence Factor q = g'(x0):", q, ">= 1, probably will not converge")

print("\nSimple Iteration Method:")
print("Solution:", simple_solution)
print("Iterations:")
print("Iteration\tGuess\tAbsolute Error")
for i, guess, error in simple_iterations:
    print(f"{i}\t\t    {guess:.6f}\t{error:.6f}")

print("\n\n")
if df(x0) == 0:
    print("Derivative at initial guess x0: 0")
    print("Newton's method may not converge.")
else:
    print("Derivative at initial guess x0:", df(x0))
    print("Newton's method will likely converge.")
    newton_solution, newton_iterations, x_values_newton = newton_method(x0, tol=1e-6)

print("\nStarting guess x0:", x0)
print("Newton's Method:")
print("Solution:", newton_solution)
print("Iterations:")
print("Iteration\tGuess\tAbsolute Error")
for i, guess, error in newton_iterations:
    print(f"{i}\t\t    {guess:.6f}\t{error:.6f}")
    

# grafikai
plt.figure(figsize=(12, 6))
plt.subplot(1, 2, 1)
plt.plot(x_values_simple_iteration, label="Simple Iteration")
plt.xlabel("Iteration")
plt.ylabel("Approximation")
plt.title("Convergence of Simple Iteration")
plt.legend()

plt.subplot(1, 2, 2)
plt.plot(x_values_newton, label="Newton's Method")
plt.xlabel("Iteration")
plt.ylabel("Approximation")
plt.title("Convergence of Newton's Method")
plt.legend()

plt.tight_layout()
plt.show()

plt.figure(figsize=(8, 6))
plt.plot(x_values_simple_iteration, label="Simple Iteration", color='blue')
plt.plot(x_values_newton, label="Newton's Method", color='red')
plt.xlabel("Iteration")
plt.ylabel("Approximation")
plt.title("Convergence of Simple Iteration and Newton's Method")
plt.legend()
plt.grid(True)
plt.show()

# Convergence of Simple Iteration Method
x = np.linspace(interval_start, interval_end, 400)
y1 = f0(x)
y2 = g0(x)
plt.figure(figsize=(8, 6))
plt.plot(x, y1, label='cos(x)')
plt.plot(x, y2, label='x')
plt.scatter(x_values_fp_conv, f_values_fp_conv, color='red', label='Newton Iterations')
plt.xlabel('x')
plt.ylabel('y')
plt.grid()
plt.title('Plot of cos(x) and x. Convergence of Simple Iteration Method')
plt.axhline(0, color='black',linewidth=0.5)
plt.axvline(0, color='black',linewidth=0.5)
#plt.xlim(0.7, 0.75)
plt.show()

# Convergence of Simple Iteration Method
x = np.linspace(interval_start, interval_end, 1000)
y1 = f0(x)
y2 = g0(x)
plt.figure(figsize=(8, 6))
plt.plot(x, y1, label='cos(x)')
plt.plot(x, y2, label='x')
plt.scatter(x_values_fp_conv, f_values_fp_conv, color='red', label='Fixed Point Iterations')
plt.xlabel('x')
plt.ylabel('y')
plt.grid()
plt.title('Plot of cos(x) and x. Convergence of Simple Iteration Method')
plt.axhline(0, color='black', linewidth=0.5)
plt.axvline(0, color='black', linewidth=0.5)

# Starting guess and the corresponding f(x) value
x_start = x0
f_start = f0(x0)

# Plot the convergence lines
for i in range(len(x_values_fp_conv)):
    x_current = x_values_fp_conv[i]
    f_current = f0(x_current)
    
    # Vertical line from x_current to f_start
    #plt.vlines(x_current, f_start, f_current, colors='r', linestyles='dotted')
    plt.vlines(x_current, min(f_start, f_current), max(f_start, f_current), colors='r', linestyles='dotted')

    # Horizontal line from x_start to x_current
    #plt.hlines(f_current, x_start, x_current, colors='r', linestyles='dotted')
    plt.hlines(f_current, min(x_start, x_current), max(x_start, x_current), colors='r', linestyles='dotted')

    # Update the starting point for the next line segment
    x_start = x_current
    f_start = f_current

# Set the x and y limits to match your function's behavior
plt.xlim(min(x_values_fp_conv), max(x_values_fp_conv))
plt.ylim(min(f_values_fp_conv), max(f_values_fp_conv))

plt.legend()
plt.show()


# Convergence of Newtons Method
x = np.linspace(interval_start, interval_end, 400)
y1 = f0(x)
y2 = g0(x)
plt.figure(figsize=(8, 6))
plt.plot(x, y1, label='cos(x)')
plt.plot(x, y2, label='x')
plt.scatter(x_values_newton_conv, f_values_newton_conv, color='red', label='Newton Iterations')
plt.xlabel('x')
plt.ylabel('y')
plt.grid()
plt.title('Plot of cos(x) and x. Convergence of Newtons Method')
plt.axhline(0, color='black',linewidth=0.5)
plt.axvline(0, color='black',linewidth=0.5)
#plt.xlim(0.7, 0.78)
plt.show()

"""
# Starting guess and the corresponding f(x) value
x_start = x0
f_start = f0(x0)

# Plot the convergence lines
for i in range(len(x_values_fp_conv)):
    x_current = x_values_fp_conv[i]
    f_current = f0(x_current)
    
    # Vertical line from x_current to f_start
    plt.vlines(x_current, f_start, f_current, colors='r', linestyles='dotted')
    
    # Horizontal line from x_start to x_current
    plt.hlines(f_current, x_start, x_current, colors='r', linestyles='dotted')
    
    # Update the starting point for the next line segment
    x_start = x_current
    f_start = f_current

# Set the x and y limits to match your function's behavior
plt.xlim(min(x_values_fp_conv), max(x_values_fp_conv))
plt.ylim(min(f_values_fp_conv), max(f_values_fp_conv))

plt.xlabel('x')
plt.ylabel('f(x)')
plt.title('Convergence Lines')
plt.grid(True)
plt.show()
"""

# Create a figure and axis object
fig, ax = plt.subplots(figsize=(8, 6))

# Plot the function f0(x) and g0(x)
ax.plot(x, y1, label='cos(x)')
ax.plot(x, y2, label='x')

# Plot the points generated by Newton's Method
ax.scatter(x_values_newton_conv, f_values_newton_conv, color='red', label='Newton Iterations')

# Plot the convergence lines for Newton's Method
for i in range(len(x_values_newton_conv)):
    x_current = x_values_newton_conv[i]
    f_current = f0(x_current)

    # Vertical line from x_current to f_current
    ax.vlines(x_current, f_start, f_current, colors='g', linestyles='dotted')

    # Horizontal line from 0 to x_current
    ax.hlines(f_current, x_start, x_current, colors='g', linestyles='dotted')

# Set labels, title, and legend
ax.set_xlabel('x')
ax.set_ylabel('y')
ax.set_title('Plot of cos(x) and x. Convergence of Newtons Method')
ax.axhline(0, color='black', linewidth=0.5)
ax.axvline(0, color='black', linewidth=0.5)
ax.grid()
ax.legend()

# Display the plot
plt.show()


