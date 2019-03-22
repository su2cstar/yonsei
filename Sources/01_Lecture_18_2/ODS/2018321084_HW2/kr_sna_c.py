# -*- coding: utf-8 -*-
"""
Created on Sun Sep 30 11:05:33 2018

@author: Sang
"""

import networkx as nx
import itertools
from collections import Counter
import re
from kornounextractor.noun_extractor import extract
import konlpy.tag

def get_words_list(counter_list):
    words = []
    for word, count in counter_list:
        words.append(word)
    return words

def get_sentences(content):
    sentences = re.split(r'[\.\?\!]\s+', content)
    return sentences

def add_ties(g, sentence, komoran):

#각 문장에 대해서, 각 문장에서 함께 사용되는 단어들 사이에 관계 형성하기

    NN_words = komoran.nouns(sentence)
        
    selected_words =[]
    for noun in set(NN_words):
        if noun in list(g.nodes()):
            selected_words.append(noun)

    for pair in list(itertools.combinations(list(selected_words), 2)):
        if pair[0] == pair[1]:
            continue
        if pair in g.edges(): 
            g[pair[0]][pair[1]]['weight'] += 1
            
        else:
            g.add_edge(pair[0], pair[1], weight=1 )
    
    return g


def form_network(g, document, komoran):
#원본 데이터와 가장 많이 출현하는 명사 단어 x개를 사용해서 그 단어들 사이의 관계 형성하기
    for sentence in document:
        g = add_ties(g, sentence, komoran)
        
    return g



def do_kr_sna(text, final_nouns, stopwords, fre=2, num=20, list_of_words= None, userdic = True):
    text = text.replace('\n', ' ')
    
    if userdic:
        with open('usrdic/dic.txt', 'w', encoding='utf8') as f:
            for word in sorted(extract(text, freq=fre)):
                f.write(word+'\tNNG\n')
    
    komoran = konlpy.tag.Komoran(userdic='usrdic/dic.txt')
    
    Nouns = komoran.nouns(text)
    
    #------------------------------------------------
    # 단어 빈도 파악하기 (Frequency analysis)
    c = Counter(final_nouns)
    if list_of_words == None:
        list_of_words = get_words_list(c.most_common(num))

    # 원본 텍스트 데이터를 문장으로 쪼개기
    # in order to find ties between words, we first need to split the article content into sentences
    text1 = re.sub(r'[^\.\?\!\s\w\d]', ' ', text.replace('\n', ' '))
    text2 = re.sub(r'([\.\?\!])',r'\1 ', text1)
    article_sentences = get_sentences(text2)
    
    # 가장 많이 출현하는 num개의 명사 단어들에 대해서 네트워크 생성하기

    G = nx.Graph()
    G.add_nodes_from(list_of_words)
    G = form_network(G, article_sentences, komoran)
    
    return G