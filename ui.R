#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(shinyFiles)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  fluidRow(
    column(width=8,selectInput("directory","Select Directory",choices=NULL)),
           #shinyDirButton("dir","Select Directory", title="Selected Directory")),
    column(width=12,tabsetPanel(
      id="dynamicTabs",
      tabPanel("Params",verbatimTextOutput("paramfile")),
      tabPanel("Git details",verbatimTextOutput("gitfile")),
      tabPanel("Analysis",htmlOutput("analysisfile"))
    ))
  )
))
