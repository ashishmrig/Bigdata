import streamlit as st
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt


# Add a selectbox to the sidebar:
st.title('NE-Med Faculty Summary Report FY2021' )

df = pd.read_csv('./Sample_NeMedFile.csv')
new_df = df.T.reset_index()
new_df.columns = new_df.iloc[0]
new_df = new_df.drop(df.index[0])

new_df["RVUs"] = new_df["RVUs"].astype(int)
new_df["Clinic Visits"] = new_df["Clinic Visits"].astype(int)
new_df['# of Clinics'] = new_df['# of Clinics'].astype(int)
new_df['# Hours at VA'] = new_df['# Hours at VA'].astype(int)
new_df['wRVU / Clinic'] = new_df['wRVU / Clinic'].astype(int)
new_df['wRVU / Visit'] = new_df['wRVU / Visit'].astype(int)
new_df['# visits / clinic'] = new_df['# visits / clinic'].astype(int)
new_df['Beginning Balance'] = new_df['Beginning Balance'].astype(int)
new_df['Ending Balance'] = new_df['Ending Balance'].astype(int)

ch = st.sidebar.radio(
    "Choose the metric for Y-axis?",
    tuple(new_df.columns)
)
ax = plt.figure( figsize = (15,9) )
plt.plot(new_df["Clinical Productivity"], new_df[ch])
plt.xlabel('Clinical Productivity', fontsize=15)
plt.ylabel(ch, fontsize=15)
st.pyplot(ax)






