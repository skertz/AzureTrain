import math
import sys
import numpy as np
import pandas as pd
pd.options.display.max_rows = 20
pd.options.display.max_columns = 15
infile = 'small_car_data.csv'
pd.set_option('display.max_rows', 500)
pd.set_option('display.max_colwidth', -1)
data = pd.read_csv(infile)
print data.values
print data.columns
#data.groupby(['Cylinders']).min()
old=data.groupby(['Acceleration']).agg([pd.np.min], [pd.np.max])

print data
print old

