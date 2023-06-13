#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)
library(here)
library(readr)

# Define server logic required to draw a histogram
shinyServer(function(input, output, session){
  default_directory <- here("results")
  files <- list.dirs(default_directory,recursive = FALSE)
  observe({
    updateSelectInput(session,"directory",choices=files)
  })
  
  observe({
    if(!is.null(input$directory)){
      params_filename <- file.path(input$directory,"params0.dat")
      git_filename <- file.path(input$directory,"git_details")
      analysis_filename <- file.path(input$directory,"plot_results.html")
      if(!is.null(params_filename)){
        if(file.exists(params_filename)){
          output$paramfile <- renderText({
            file_contents <- paste(read_lines(params_filename),collapse="\n")
          })
        }
        else {
          output$paramfile <- renderText({
            file_contents <- paste("File ",params_filename," not found")
          })
        }
      }
      if(!is.null(git_filename)){
        if(file.exists(git_filename)){
          output$gitfile <- renderText({
            file_contents <- paste(read_lines(git_filename),collapse="\n")
          })
        }
        else {
          output$gitfile <- renderText({
            file_contents <- paste("File ",git_filename," not found")
          })
        }
      }
      if(!is.null(analysis_filename)){
        if(file.exists(analysis_filename)){
          output$analysisfile <- renderUI({
            includeHTML(analysis_filename)
          })
        }
        else {
          output$analysisfile <- renderUI({
            p("HTML file doesn't exist")
          })
        }
      }
    }
  })
})
