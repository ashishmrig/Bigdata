import streamlit as st
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt


# Add a selectbox to the sidebar:
st.title('Client Faculty Summary Report FY2021' )

df = pd.read_csv('./Sample_NeMedFile.csv')
new_df = df.T.reset_index()
new_df.columns = new_df.iloc[0]
c = list(new_df.columns)
c[0] = 'None'
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

ch2 = 'None'
st.sidebar.header("Choose the metric for Y-axis")
ch1 = st.sidebar.radio(
    "Pick one",
    tuple(c)
)

if ch1 == 'RVUs':
    ch2 = st.sidebar.radio(
    "Pick optional second metric",
    ('None', 'Clinic Visits') )
if ch1 == 'Clinic Visits':
    ch2 = st.sidebar.radio(
    "Pick optional second metric",
    ('None', 'RVUs') )
if ch1 == 'wRVU / Clinic':
    ch2 = st.sidebar.radio(
    "Pick optional second metric",
    ('None', '# visits / clinic') )
if ch1 == '# visits / clinic':
    ch2 = st.sidebar.radio(
    "Pick optional second metric",
    ('None', 'wRVU / Clinic') )
if ch1 == 'Beginning Balance':
    ch2 = st.sidebar.radio(
    "Pick optional second metric",
    ('None', 'Ending Balance') )
if ch1 == 'Ending Balance':
    ch2 = st.sidebar.radio(
    "Pick optional second metric",
    ('None', 'Beginning Balance') )

    
ax = plt.figure( figsize = (15,9) )
if ch1 != 'None':
    plt.plot(new_df["Clinical Productivity"], new_df[ch1], label = ch1)
else:
    plt.plot()

if ch2 != 'None':
    plt.plot(new_df["Clinical Productivity"], new_df[ch2], label = ch2)
    plt.ylabel(ch1+' & '+ch2, fontsize=15)
else:
    plt.ylabel(ch1, fontsize=15)
    
plt.xlabel('Clinical Productivity', fontsize=15)
plt.legend()
st.pyplot(ax)






