# Scipt para a Questão 1

import sqlite3
import pandas as pd


## Functions

def conectar_banco(db):
    """
    Conecta ao banco de dados
    ---
    db - nome do banco de dados
    """

    # Cria conexão
    conn = sqlite3.connect(db)
    # Cursor
    c = conn.cursor()
    return conn, c

def criar_tabela(nome_tabela, conn, schema):
    """
    Cria uma tabela no banco de dados SQLite
    ---
    nome_tabela - nome da tabela criada
    conn - conexão com o banco
    schema - nome do schema
    """

    # Ler arquivo local
    arquivo = f'data-analytics-engineer-test/Data/{nome_tabela}.csv'
    df = pd.read_csv(arquivo)
    # Carga das tabelas para o banco, schema de acordo com os parâmetros
    df.to_sql(nome_tabela, conn, schema, 'replace', False)


## Parâmetros

database = 'test_analytics_engineer.db'
schema =  'test_analytics_engineer'
nome_tabelas = ['Country', 
               'League', 
               'Match', 
               'Player_Attributes', 
               'Player', 
               'Team_Attributes', 
               'Team']


# Carga no banco de dados
conn, c = conectar_banco(database)
for nome in nome_tabelas:
    criar_tabela(nome, conn, schema)