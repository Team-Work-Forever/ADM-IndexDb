from random import randint
import random  

def retirar_atributo_insert():

    codes = []

    with open('file.sql', 'r', encoding='utf-8') as arquivo:
        for linha in arquivo:
            code = linha.split("VALUES (")[1].split(",")[0].strip("'")
            codes.append(code)

    return codes

def create_insets():

    codes = retirar_atributo_insert()

    with open('inserts_finish.sql', 'w', encoding='utf-8') as arquivo:
        for i in range(10):
            year = randint(16 ,22)
            years = '20' + str(year) + str(year+1)
            idType = randint(0, 2)
            value = randint(0,20)
            arquivo.write("INSERT into dbo.Class_IndexType (year, id_index_type, code_class, value) VALUES ('{}', {}, '{}', {});\n".format(years, idType, random.choice(codes), value))

create_insets()