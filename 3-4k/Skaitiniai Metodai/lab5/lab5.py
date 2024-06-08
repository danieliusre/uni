import numpy as np
import matplotlib.pyplot as plt

def f(t, y):
    return (t**4 * np.sin(t/2) + 2*y) / t

def exact_solution(t):
    return 4 * t**2 * np.sin(t/2) - 2 * t**3 * np.cos(t/2) - 2 * t**2

h = 0.5
t = np.arange(np.pi, 4*np.pi + h, h)
s0 = 2*np.pi**2 # Initial Condition

s = np.zeros(len(t))
s[0] = s0

errors = np.zeros(len(t))

for i in range(0, len(t) - 1):
    s[i + 1] = s[i] + h * f(t[i], s[i])
    errors[i + 1] = np.abs(s[i + 1] - exact_solution(t[i + 1]))
    
for i in range(len(t)):
    print(f"t = {t[i]:.2f}, Approximate = {s[i]:.6f}, Exact = {exact_solution(t[i]):.6f}, Error = {errors[i]:.6f}")

plt.figure(figsize=(12, 8))
plt.plot(t, s, 'bo--', label='Approximate')
plt.plot(t, exact_solution(t), 'g', label='Exact')
plt.title('Approximate and Exact Solution for ODE')
plt.xlabel('t')
plt.ylabel('y(t)')
plt.grid()
plt.legend(loc='lower right')
plt.show()
