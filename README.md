Next Word Prediction
========================================================
author: Jacob Govshteyn
date: Aug 2015



[A word prediction app ](https://jacob-govshteyn.shinyapps.io/NextWordKnModel)


App description
========================================================

__Internals:__

Ngrams in the range of 2-5 where constructed from ~150,000 lines of news, blogs , and twitter social media training data entries:

To analyze n-gram frequencies, the following preprocessing steps were performed:

1. Remove punctuation from text corpus.
3. Transform words to lower case.
3. Strip text of additional white spaces.
4. replaced all sparse words with an `<UNK>` placeholder

How the app works:
========================================================
> Enter Partial Phrase in Text Box
![alt text](phrase.PNG)

__Submit Server Request__
![alt text](next.PNG) 
> Complete The Phrase
![alt text](treeMap.PNG)


- Word Predictor [Shiny app](https://jacob-govshteyn.shinyapps.io/NextWordKnModel)  