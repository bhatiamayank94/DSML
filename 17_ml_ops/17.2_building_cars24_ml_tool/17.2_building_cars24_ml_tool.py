import streamlit as st
import pandas as pd
import yfinance as yf

# Streamlit basics

st.header('Stock market analysis')


# Getting a dataframe from  radio input for stock and range input for date
a=st.radio("Choose your stock",["MSFT","ADANIENT.BO","RELIANCE.NS","IOC.NS"])

col1, col2=st.columns(2)
with col1:
    start_date=st.date_input("Choose start date",'2020-01-01')

with col2:
    end_date=st.date_input("Choose end date")

ticker = yf.Ticker(a)
ticker_df=ticker.history('1d',start=start_date,end=end_date)


st.write("Ticker data")
st.dataframe(ticker_df)

# getting a chart 
st.line_chart(ticker_df['Close'])

# CAR PRED MODEL

