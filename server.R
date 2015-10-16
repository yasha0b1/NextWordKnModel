# server.R


source("nextword.R")

treeGraph<-function(str.words){
    dt.tree<-buildTree(str.words,3,3);dt.tree[,dummy:=kn%%1]
    gTreeMap<-gvisTreeMap(dt.tree,  idvar="choice", parentvar="parent",
                sizevar="kn", colorvar="dummy",
                options=list(width=1220, height=350,
                             gvis.listener.jscode = "
                             var selected_word = data.getValue(chart.getSelection()[0].row,0);
                             var parentIndex = 0;
                             
                             google.visualization.events.addListener(chart, 'rollup', function () {
                             selected_word = data.getValue(chart.getSelection()[0].row,0);
                             Shiny.onInputChange('selected_word',selected_word);
                             });
                             Shiny.onInputChange('selected_word',selected_word);")
    )
    return(gTreeMap)
}

nextw <- function(phrase, lang, safemode) {
    if(length(strsplit(phrase, " ")[[1]])==0){return()}
    print(length(phrase))
    t.tree<-buildTree(phrase)
    t.tree[,dummy:=kn%%1]
    
    return(t.tree[2:6]$choice)
}
shinyServer(function(input, output,session) {
    withProgress(message = 'Loading Data ...', value = NULL, {
        Sys.sleep(0.25)
        dat <- data.frame(x = numeric(0), y = numeric(0))
        withProgress(message = 'App Initializing', detail = "part 0", value = 0, {
            for (i in 1:10) {
                dat <- rbind(dat, data.frame(x = rnorm(1), y = rnorm(1)))
                incProgress(0.1, detail = paste(":", i*10,"%"))
                Sys.sleep(0.5)
            }
        })
        
        # Increment the top-level progress indicator
        incProgress(0.5)
    })
    
    observe({
        updateTextInput(session, "phrase",value = onGraphSelect())
        
        
    })
    
    
    onGraphSelect<-eventReactive(input$selected_word,{
        paste(onPhraseUpdate(), input$selected_word)
    })
    onPhraseUpdate <- eventReactive(input$goButton, {
        input$phrase
    })
    output$dates_plot <- renderGvis({
        withProgress(message = 'building Tree Graph',
                     detail = 'This may take a while...', value = 0, {
                     })
        phrase<-onPhraseUpdate()
        if(length(strsplit(phrase, " ")[[1]])==0){return()}
        tgraph<-treeGraph(phrase)
        tgraph
    })    
})





