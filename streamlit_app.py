import streamlit as st
import pandas as pd
import numpy as np
import plotly.express as px


# Add a selectbox to the sidebar:
st.title('NE-Med Faculty Summary Report FY2021' )

df = pd.read_csv('./Sample_NeMedFile.csv')
group_labels = df["Clinical Productivity"]
st.write(group_labels)




