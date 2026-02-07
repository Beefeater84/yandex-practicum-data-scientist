import pandas as pd

class DataFrameReporter:
    def __init__(self, float_format='0.05f', percent_format='0.02%', include_all=False):
        self.float_format = float_format
        self.percent_format = percent_format
        self.include_all = include_all

    # добавьте в класс метод show_report
    def show_report(self, df, title: str = None):
        if (title != None):
            print(title)
        else:
            pass

        dublicates_share = df.duplicated(subset=None).sum() / df.shape[0]
        dublicates_share_formatted = format(dublicates_share, self.percent_format)

        print(f'Количество столбцов: {df.shape[1]}')
        print(f'Количество строк: {df.shape[0]}')
        print(f'Количество дубликатов: {df.duplicated().sum()}')
        print(f'Доля дубликатов: {dublicates_share_formatted}')
    
reporter = DataFrameReporter()

import pandas as pd

data = pd.read_csv('payments.csv')

# вызовите метод show_report для reporter, передав в него датафрейм
reporter.show_report(data)