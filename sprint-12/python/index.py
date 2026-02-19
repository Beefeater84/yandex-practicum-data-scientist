import pandas as pd
import os
from sqlalchemy import create_engine
from dotenv import load_dotenv

# Загрузка переменных окружения из .env файла
load_dotenv()

db_config = {
    'user': os.getenv('DB_USER'),
    'pwd': os.getenv('DB_PASSWORD'), 
    'host': os.getenv('DB_HOST'),
    'port': int(os.getenv('DB_PORT')),
    'db': os.getenv('DB_NAME')
}

connection_string = 'postgresql://{}:{}@{}:{}/{}'.format(
    db_config['user'],
    db_config['pwd'],
    db_config['host'],
    db_config['port'],
    db_config['db'],
)

engine = create_engine(connection_string)

query = '''
SELECT *
FROM afisha.purchases
LIMIT 5
'''

df = pd.read_sql_query(query, con=engine)
print(df)