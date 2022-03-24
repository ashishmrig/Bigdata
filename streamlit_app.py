import streamlit as st
import pandas as pd

# Add a selectbox to the sidebar:
add_selectbox = st.sidebar.selectbox(
    'How would you like to be contacted?',
    ('Email', 'Home phone', 'Mobile phone')
)

df = pd.read_csv('./Sample_NeMedFile')
df
