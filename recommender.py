import pandas as pd
import numpy as np
from nltk.corpus import stopwords
from sklearn.metrics.pairwise import linear_kernel
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.decomposition import LatentDirichletAllocation
import re
import random
import sqlalchemy as sql
import pymysql

def preProcessing(text):
    REPLACE_BY_SPACE = re.compile('[/(){}\[\]\|@,;]')
    REMOVE_BAD_SYMBOLS = re.compile('[^0-9a-z #+_]')
    STOPWORDS = set(stopwords.words('english'))
    text = text.lower()
    text = REPLACE_BY_SPACE.sub(' ', text) 
    text = REMOVE_BAD_SYMBOLS.sub('', text) 
    text = ' '.join(word for word in text.split() if word not in STOPWORDS) 
    return text

def getRecommendations(idx, cosine_similarities):
    recommended_hotels = []
    score_series = pd.Series(cosine_similarities[idx]).sort_values(ascending = False)
    top_3_indexes = score_series.iloc[1:5].index    
    for i in top_3_indexes:
        if(i != 0):
            recommended_hotels.append(i)
    return recommended_hotels

def dbConnect():
    connect_string = "mysql+pymysql://coder:coder@204.48.25.246/oyo"
    dbConn = sql.create_engine(connect_string)
    return dbConn

def recommenderSystem(u_idx):
    dbConn = dbConnect()
    idx = int(pd.read_sql("select hotel_id from bookings where user_id ="+str(u_idx)+" limit 1",con=dbConn).iloc[0]['hotel_id'])
    df = pd.read_sql("select id,description from hotels",con=dbConn)
    df['description'] = df.description.apply(preProcessing)

    df.set_index('id', inplace = True)
    tf = TfidfVectorizer(analyzer='word', ngram_range=(1, 3), min_df=0, stop_words='english')
    tfidf_matrix = tf.fit_transform(df['description'])
    cosine_similarities = linear_kernel(tfidf_matrix, tfidf_matrix)
    
    return getRecommendations(idx,cosine_similarities)
    
print(recommenderSystem(1))
