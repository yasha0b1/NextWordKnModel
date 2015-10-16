# ui.R
library(shiny)
library(googleVis)
library(shinydashboard)
shinyUI(dashboardPage(skin="black",
                      
                      
                      dashboardHeader(title = "Next Word Text Prediction",
                                      titleWidth = 450),
                      dashboardSidebar(disable = TRUE),
                      
                      dashboardBody(
                          tags$head(tags$style(HTML('
                                                    /* Sidebar font size */
                                                    .sidebar-menu>li>a {
                                                    font-size:16px;
                                                    }
                                                    /* Box title font size */
                                                    .box-header .box-title, .box-header>.fa, .box-header>.glyphicon, .box-header>.ion {
                                                    font-size: 20px;
                                                    }
                                                    /* Overall font size */
                                                    body {
                                                    font-size: 16px;
                                                    }
                                                    /* Table properties */
                                                    td {
                                                    padding-left: 15px;
                                                    padding-right: 15px;
                                                    vertical-align: middle;
                                                    }
                                                    /* Expand and center title */
                                                    .main-header .logo {
                                                    float:inherit;
                                                    width:inherit;
                                                    }
                                                    .main-header .navbar {
                                                    display: none;
                                                    }
                                                    '))),
                          
                          skin="blue",
                          fluidRow(
                              box(
                                  title = "Enter word or phrase below:", status="primary",
                                  textInput("phrase", label = "", value = ""),
                                  skin="blue",
                                  actionButton("goButton", "Next Word..."),width=950,
                                  align = "center"
                              )
                              
                          ),
                          fluidRow(
                              
                              box(
                                  footer="left-click to complete phrase, Right-click to go back",
                                  status="primary",
                                  solidHeader = TRUE,
                                  htmlOutput("dates_plot"),
                                  width=950,
                                  align = "center"
                              )
                          )
                          
                          
                      ))
)




