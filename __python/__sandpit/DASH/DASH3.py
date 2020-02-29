import dash
import dash_core_components as dcc
import dash_html_components as html
from dash.dependencies import Input, Output
import datetime
import sqlite3
import pandas as pd

# CREATE YOUR CONNECTION.
cnx = sqlite3.connect('D:\Sync\__lanoitan\@data\PY_WEB_DATA_OLD.db')

#print(df.head())

# BUILD DASBOARD ELEMENTS
app = dash.Dash()

app.layout = html.Div(children=[
    # PAGE HEADER
    html.H1(children='My First Dash'),
    
    html.Div(children='''
        Symbol to Chart : 
    '''),

    dcc.Input(id='input', value='', type='text'),
    
    html.Div(id='output-chart')
])

@app.callback(Output(component_id='output-chart', component_property='children'), 
              [Input(component_id='input', component_property='value')]
              )   


def update_chart(input_data):

    # LOAD DATAFRAME
    df = pd.read_sql_query('''select distinct
                                      MSMT_DTE_ID
                                    , DATA_TYPE
                                    , TRADE_DT
                                    , INDEX_VAL
                                    , HIGH_VAL
                                    , LOW_VAL
                                    , TTL_MRKT_VAL
                                    , DIV_MRKT_VAL 
                                 from PY_COMMODITY_DATA
                                where DATA_TYPE = '{0}'
    
    '''.format(input_data), 
                           cnx)
    
    return dcc.Graph(
        id='example-graph',
        figure={
            'data': [
                {'x': df.TRADE_DT, 'y': df.INDEX_VAL, 'type': 'line', 'name': commodity}
            ],
            'layout': {
                'title': 'Commodity History : {0}'.format(commodity)
            }
        }
    )


if __name__ == '__main__':
    app.run_server(debug=True)