import streamlit as st
import pandas as pd
import numpy as np
import plotly.figure_factory as ff

# Add a selectbox to the sidebar:
st.title('NE Med Faculty Summary Report FY2021' )

df = pd.read_csv('./Sample_NeMedFile.csv')
#group_labels = df[0]
print(df.iloc[:, 0])




