import numpy as np
import pandas as pd
import urllib.request
import binascii
from bs4 import BeautifulSoup
import time

def korToHex(kor):
    seq = str(binascii.b2a_hex(kor.encode('utf-8')))[2:-1].upper()
    out=''
    for i in list(map(''.join, zip(*[iter(seq)]*2))):
        out =  out + '%'+i
    return out

def getEngName(city,town):
    try:
        url = 'http://www.jusoen.com/addreng.asp?p1='+korToHex(city)+'+'+korToHex(town)+'&x=0&y=0'
        korAd = city+' '+town
        html=urllib.request.urlopen(url)
        soup=BeautifulSoup(html,'html.parser')
        han = pd.Series(soup.select('div.result.result_v1 > div > table')[0].select('dl > dd > span')).map(lambda x : x.text)
        eng = pd.Series(soup.select('div.result.result_v1 > div > table')[0].select('td > strong')).map(lambda x : x.text)
        df = pd.DataFrame([han,eng]).transpose()
        df.columns = ['Kor', 'Eng']
        out = df[df.apply(lambda x : korAd in x['Kor'],axis =1)].reset_index(drop = True).iloc[0,1].split(',')[-3:]
    except:
        url = 'http://www.jusoen.com/addreng.asp?p1='+korToHex(town)+'&x=0&y=0'
        korAd = city + ' ' + town
        html=urllib.request.urlopen(url)
        soup=BeautifulSoup(html,'html.parser')
        han = pd.Series(soup.select('div.result.result_v1 > div > table')[0].select('dl > dd > span')).map(lambda x : x.text)
        eng = pd.Series(soup.select('div.result.result_v1 > div > table')[0].select('td > strong')).map(lambda x : x.text)
        df = pd.DataFrame([han,eng]).transpose()
        df.columns = ['Kor', 'Eng']
        out = df[df.apply(lambda x : korAd in x['Kor'],axis =1)].reset_index(drop = True).iloc[0,1].split(',')[-3:]
    outstr =  ','.join(out)
    return outstr
