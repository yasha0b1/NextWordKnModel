
<script type="text/javascript" src="http://www.math.union.edu/locate/Cervone/transfer/mathjax/mathjax-in-github.user.js"></script>
[A word prediction app ](https://jacob-govshteyn.shinyapps.io/myApp)




App description
========================================================

__Internals:__

Ngrams in the range of 2-5 where constructed from ~150,000 lines of news, blogs , and twitter social media training data entries:

To analyze n-gram frequencies, the following preprocessing steps were performed:

1. Remove punctuation from text corpus.
3. Transform words to lower case.
3. Strip text of additional white spaces.
4. replaced all sparse words with an `<UNK>` placeholder


We want a heuristic that more accurately estimates the number of times we might expect to see word w in a new unseen context. The _Kneser-Ney_ intuition is to base our estimate on the number or different contexts word w has appeared in([ Huang, X. & Deng, L. (2010). An Overview of Modern Speech Recognition.](http://research.microsoft.com/pubs/118769/Book-Chap-HuangDeng2010.pdf)).

\[P_{\mathit{KN}}(w_i \mid w_{i-1}) = \dfrac{\max(c(w_{i-1} w_i) - \delta, 0)}{\sum_{w'} c(w_{i-1} w')} + \lambda \dfrac{\left| \{ w_{i-1} : c(w_{i-1}, w_i) > 0 \} \right|}{\left| \{ w_{j-1} : c(w_{j-1},w_j) > 0\} \right|}\]


where $$\lambda(w_{i-1}) = \dfrac{\delta}{c(w_{i-1})} \left| \{w' : c(w_{i-1}, w') > 0\} \right|$$

this is new sum exp (![][\sum_{k=0}^{n}2^k])in remote.

========================================================
_Links and references_
 
- Word Predictor [Shiny app](https://jacob-govshteyn.shinyapps.io/NextWordKnModel)  
 
- [Data Science Specialization](https://www.coursera.org/specialization/jhudatascience/1) by Johns Hopkins University
- [Natural Language Processing](https://www.coursera.org/course/nlp) by Stanford University on coursera
