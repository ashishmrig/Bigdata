import streamlit as st
import pandas as pd

# Add a selectbox to the sidebar:
add_selectbox = st.sidebar.write(
    'NE Med Faculty Summary Report FY2021'
    )

df = pd.read_csv('./Sample_NeMedFile.csv')
df
