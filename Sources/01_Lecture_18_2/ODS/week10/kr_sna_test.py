# -*- coding: utf-8 -*-
"""
Created on Fri Nov  2 17:12:46 2018

@author: Sang
"""

import requests
from bs4 import BeautifulSoup

from kr_sna import do_kr_sna

def get_article(url):
    # Obtain three types of information about a news article
    r = requests.get(url)
    soup = BeautifulSoup(r.text, 'lxml')
    news_title = soup.title.text
    publisher = soup.find('meta', attrs={'name':'twitter:creator'}).get('content')
    news_content = soup.find('div', attrs = {'id':'articleBodyContents'}).text
    news_content = news_content.split('{}')[1].strip()
    return news_title, publisher, news_content

url = 'https://news.naver.com/main/read.nhn?oid=421&sid1=100&aid=0003646082&mid=shm&mode=LSD&nh=20181018225255'
title, publisher, content = get_article(url)

stopwords = ['재테크','배포','금지', '기자', 'co','kr','나가기','페이스북','com', '.kr', '뉴스1']

from kornounextractor.noun_extractor import extract

with open('dic.txt', 'w', encoding='utf8') as f:
    for word in sorted(extract(content, freq=2.0)):
        f.write(word+'\tNNG\n')
        
import konlpy.tag
komoran = konlpy.tag.Komoran(userdic='dic.txt')

Nouns = komoran.nouns(content)

final_nouns = Nouns.copy()
unique_nouns = set(Nouns)
for word in unique_nouns:
    if len(word) == 1:
        while word in final_nouns:
            final_nouns.remove(word)
    if word in stopwords:
        while word in final_nouns:
            final_nouns.remove(word)
            
g = do_kr_sna(content, final_nouns, stopwords, num=10)

import networkx as nx

import matplotlib.pyplot as plt
nx.draw_networkx(g)
plt.show()