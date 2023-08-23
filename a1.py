lista = [3, 6, 1, 8, 2]

x = 0
y = 0
z = 0

for x in lista:
    y = x
    if y < x:
        z = y
        y = x

        print(lista)