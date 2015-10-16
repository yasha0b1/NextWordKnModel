
## Load in data 
library(googleVis)
library("data.table")
library("RSQLite")
drv <- dbDriver("SQLite")
con <- dbConnect(drv, dbname = "data/topstrWords.db")
topPredictions.nada<-data.table(dbGetQuery(con, "SELECT * FROM topstrWords1 WHERE history = 'NADA'"))
setkey(topPredictions.nada,prediction)
load("data/hash.uniqueWords.rds")
load("data/list.topstrWords.base.rds")
CleanString <- function(wordStr) {
    #remove select punctuation 
    removePunctuation<- function(x) {
        x<- gsub("[^[:alnum:][:space:]\'-]", "", x)
        gsub("(\\w[\'-]\\w)|[[:punct:]]", "\\1", x)  
    }
    
    removeNumeric <- function(x) {
        x <- gsub("(\\w*[0-9]+\\w*)", "", x)
    }
    trim<-function(x){
        # compress and trim whitespace
        x <- gsub("\\s+"," ",x)
        x <- gsub("^\\s+|\\s+$", "", x)
    }
    x <- trim(removeNumeric(removePunctuation(tolower(wordStr))))
}

formatString<-function(str.words){
    str.words<-CleanString(str.words)
    str.words<-filterUnk(str.words)
    if(length(str.words)==0){return()}
    arr.words<-strsplit(str.words, " ")[[1]]
    last<-length(arr.words)
    fist<- if(last<=2) 1 else last-2
    str.words<-do.call(paste, c(as.list(arr.words[fist:last]), sep=" "))
    str.words
}
filterUnk<-function(wordStr){
    wordArray<-sapply(strsplit(wordStr, " ")[[1]],function(x) if(!is.null(hash.uniqueWords[[x]])){x} else{"<unk>"})
    x<-do.call(paste, c(as.list(wordArray), sep=" "))
}


topPredict<-function(str.words){
    if(length(str.words)==0){return()}
    str.words<-formatString(str.words)
    str.words<-gsub("'", "''", str.words)
    topPredictions<-topPredictions.nada
    arr.words<-strsplit(str.words, " ")[[1]]
    last<-length(arr.words)
    fist<- if(last<=2) 1 else last-2
    for(i in (last-fist+1):1)
    {
        topPrediction<-data.table(dbGetQuery(con, paste0("SELECT * FROM topstrWords",i," WHERE history = '",str.words,"'")))
        if(nrow(topPrediction)){
            setkey(topPrediction,prediction)
            topPredictions<-rbind(topPredictions,topPrediction[!topPredictions][prediction!='<unk>'])
            setkey(topPredictions,prediction)
            topPredictions[,kn:=kn+1]
        }
        arrLowerOder<-strsplit(str.words, " ")[[1]][-1]
        str.words<-do.call(paste, c(as.list(arrLowerOder), sep=" "))
    }
    topPredictions<-rbind(topPredictions,list.topstrWords.base)
    setkey(topPredictions,prediction)
    setorder(topPredictions,-kn)
    topPredictions
}
buildTree<-function(str.words,Depth=3,Breadth=3){
    if(length(str.words)==0){return()}
    cln.words<-formatString(str.words)
    topPredictions<-topPredict(cln.words)
    dt.tree<-data.table(parent=NA,choice=" ",kn=c(5))
    dt.leaves<-topPredictions[,j=list(parent =  " ",choice=prediction), by=list(kn)][1:Breadth]
    buildLeaves<-function(choice,dt.leaves)
    {
        history<-paste(str.words,choice,sep=" ")
        topPredictions<-topPredict(history)
        dt.prediction<-topPredictions[,j=list(parent=choice,choice=paste(choice,prediction,sep=" ")), by=list(kn)][1:Breadth]
        dt.prediction
    }
    dt.tree<-rbind(dt.tree,dt.leaves)
    for(i in 1:(Depth-1))
    {
        list.leaves<-lapply(dt.leaves$choice,function(x) buildLeaves(x))
        dt.leaves<-rbindlist(list.leaves)
        dt.tree<-rbind(dt.tree,dt.leaves)
    }
    dt.tree
}




