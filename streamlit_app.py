import streamlit as st
import pandas as pd
import numpy as np

df = np.random.randn(10, 20)
st.dataframe(df)
