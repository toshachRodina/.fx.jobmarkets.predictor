# =======================================================================================================================================================================================================
# SUBJECT        : seek - job search site summary job listing data by work category
# OBJECT TYPE    : python - BeautifulSoup
# OBJECT NAME    : py_b4s_au_seek
# CREATED BY     : Harold Delaney
# CREATED ON     : 20170216
# SOURCE         : seek [ https://www.seekbusiness.com.au/ ]
# PREPERATION    : SCRAPE - python - BeautifulSoup - scrapes summary data from site and stores in sqlite in preparation for etl to sqlserver
# FREQUENCY      : DAILY
#               
# REMARKS        : 1) 
#                  2) 
#                  3)
# =======================================================================================================================================================================================================
# =============================================================================
# ENVIRNMENT AND LIBRARY SETUP -- START
# =============================================================================
import nltk
from nltk.tokenize import sent_tokenize, word_tokenize # TOKENIZE - split block into sentences or word etc
from nltk.tokenize import PunktSentenceTokenizer
from nltk.corpus import stopwords # CORPUS - remove/filter joining/filler words (and, but, a, in etc)
from nltk.stem import PorterStemmer # STEMMING - take words back to their base meaning (ride and riding mean same thing and could be grouped as singular ride)
from nltk.corpus import state_union

train_text = state_union.raw("2005-GWBush.txt")
sample_text = state_union.raw("2006-GWBush.txt")


custom_sent_tokenizer = PunktSentenceTokenizer(sample_text)

tokenized = custom_sent_tokenizer.tokenize(sample_text)

def process_content():
    try:
        for i in tokenized:
            words = nltk.word_tokenize(i)
            tagged = nltk.pos_tag(words)
            
            print(tagged)
    except Exception as e:
        print(str(e))
        
        
process_content()        
    

# ps = PorterStemmer()
# 
# example_words = ["python","pythoner","pythoning","pythoned","pythonly"]
# 
# # for w in example_words:
# #     print(ps.stem(w))
# 
# new_text = "It is very important to be pythonly while you are pythoning with python. All pythoners have pythoned poorly at least once."
# 
# words = word_tokenize(new_text)
# for w in words:
#     print(ps.stem(w))



# text = '''A 53-year-old man was drinking with friends at his home in Corio last night when two intruders allegedly stormed in and began beating him with a pole, according to Nine. It's believed the incident was sparked by a neighbourhood dispute.'''
# 
# stop_words = set(stopwords.words("english"))
# 
# words = word_tokenize(text)
# 
# filtered_sentence = []
# 
# for w in words:
#     if w not in stop_words:
#         filtered_sentence.append(w)
#         
# print(filtered_sentence)        





# print(sent_tokenize(text))
# print()
# print()
# print(word_tokenize(text))
# print()
# print()
# for i in word_tokenize(text):
#     print (i)