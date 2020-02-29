import datetime
import pandas_datareader.data as web
import sqlite3
import pandas as pd

# CREATE YOUR CONNECTION.
cnx = sqlite3.connect('D:\Sync\__lanoitan\@data\PY_WEB_DATA_OLD.db')
# LOAD DATAFRAME
df = pd.read_sql_query("select MSMT_DTE_ID, DATA_TYPE, TRADE_DT, INDEX_VAL, HIGH_VAL, LOW_VAL, TTL_MRKT_VAL, DIV_MRKT_VAL from PY_COMMODITY_DATA", 
                       cnx)



# df.reset_index(inplace=True)
# df.set_index("Date", inplace=True)
# df = df.drop("Symbol", axis=1)

print(df.head())