import streamlit as st
import pandas as pd
pd_c=pd.read_csv(r'C:\Users\28962\Documents\GitHub\DSML\17_ml_ops\17.2_building_cars24_ml_tool\cars24-car-price.csv')

st.header('Cars 24 price predictor')

col1, col2, col3, col4 = st.columns(4)

with col1:
    ft= st.selectbox(
        "Select Fuel type",
        ["Petrol", "Diesel", "CNG","Electric"])
with col2:
    tt=st.radio('select transmission',["Manual","Automatic"])
    
with col3:
    tt=st.radio('select number of seats',["1","2","3","4"])
    
engine=st.slider('set engine power',500,5000,100)

encd = { "fuel_type": { "Petrol" :1,
"Diesel" :2,
"CNG" :3,
"Electric" :4 }, "tt": { "Manual" :1,
"Automatic" :2 }
      }
        


if st.button("Predict"):
    st.write("buttom pressed")



st.dataframe(pd_c)

