from pickle import FALSE, TRUE
import random
sum = 0
zmones = 0
for _ in range(3):
    for _ in range(100000000):
        zmones +=1
        laikas = 0
        aptarnautas = FALSE
        while aptarnautas == FALSE:
            x = random.randint(1,100)
            if laikas == 12:
                laikas +=1
                aptarnautas = TRUE
                break
            laikas += 1
            if x < 50:
                aptarnautas = TRUE
                sum = sum + laikas

    print(zmones)
    print(sum/zmones)