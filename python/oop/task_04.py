class DataFrameReporter:
    def __init__(self, float_format='0.05f', percent_format='0.02%', include_all=False):
        self.float_format = float_format
        self.percent_format = percent_format
        self.include_all = include_all
    
    def show_report(self, df, title=None):
        if title:
            print(title)
    
        print('Number of columns:', df.shape[1])
        print('Number of rows:', df.shape[0])

        duplicates = df.duplicated().sum()
        print('Number of duplicates:', duplicates)

        print('Share of duplicates:', format(duplicates / df.shape[0], self.percent_format))

        print(df.describe(include='all' if self.include_all else None))
        
        # print the total number of missing values in the entire dataframe
        print('Number of missing values:', df.isna().sum().sum())
        
        # print the share of missing values in the entire dataframe as a floating-point number
        # in the format specified by float_format
        print('Share of missing values:', format(df.isna().mean(axis=None), self.float_format))


import pandas as pd

data = pd.read_csv('payments.csv')

# do not change the code below - it is for testing the correctness of show_report with different settings
reporter_1 = DataFrameReporter(float_format='0.02f', percent_format='0.03%')
reporter_2 = DataFrameReporter(float_format='0.03f', percent_format='0.01%', include_all=True)

reporter_1.show_report(data, 'Report in format 1:')
print()
reporter_2.show_report(data, 'Report in format 2:')