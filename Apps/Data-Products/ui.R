#
# ui.R
#
library(shiny)
library(BH)
library(rCharts)
require(markdown)
require(data.table)
library(dplyr)
library(DT)

shinyUI(
  
  navbarPage("MTCARS",
             
             #-------------------------------------------------------------------------------
             tabPanel("Regression",
                      
                      sidebarPanel(
                        
                        h4("Description"),
                        p("This application is designed to provide a simple visualization for the mtcars dataset.", 
                          "This bsically plots the regression line between mpg and other variables upon choice.",
                          "Correlation among them and Clustering."),
                        
                        radioButtons("radio_regresor", label = h3("Choose regressors of model: mpg ~ x"),
                                     choices = list("disp"         = 1, 
                                                    "hp"           = 2, 
                                                    "drat"         = 3, 
                                                    "wt"           = 4, 
                                                    "factor(cyl)"  = 5,
                                                    "factor(vs)"   = 6,
                                                    "factor(am)"   = 7,
                                                    "factor(gear)" = 8,
                                                    "factor(carb)" = 9),
                                     selected    = 1),
                        
                        
                        checkboxInput("checkbox_abline", label = "Regression Line", value = TRUE),
                        hr(),
                        tags$a(href="index.html", "Application Help!")
                      ),
                      
                      mainPanel(
                        plotOutput('plot1'),
                        plotOutput('plot2')
                      )
                      
             ),
             #-------------------------------------------------------------
             tabPanel("Correlation",
                      
                      sidebarPanel(
                        
                        h4("Description"),
                        p("This application is designed to provide a simple visualization for the mtcars dataset.", 
                          "This bsically plots the regression line between mpg and other variables upon choice.",
                          "Correlation among them and Clustering."),
                        
                        h4("Correlation"),
                        p("Positive correlations are displayed in blue and negative correlations in red color.",
                          "Color intensity and the size of the circle are proportional to the correlation coefficients.",
                          "In the right side of the correlogram, the legend color shows the correlation coefficients and the corresponding colors.")
                      
                      ),
                      
                      
                      mainPanel(
                        plotOutput('corr1')
                      )
                      
             ),
             
             #-------------------------------------------------------------
             tabPanel("Clustering",
                      
                      sidebarPanel(
                        
                        h4("Description"),
                        p("This application is designed to provide a simple visualization for the mtcars dataset.", 
                          "This bsically plots the regression line between mpg and other variables upon choice.",
                          "Correlation among them and Clustering."),
                        
                        h4("Clustering"),
                        p(" In the data set mtcars, we can run the distance matrix with hclust, and plot a dendrogram that displays a hierarchical relationship among the vehicles.")
                       
                        
                        
                       
                        
                      ),
                      
                      
                      
                      
                      mainPanel(
                        plotOutput('cluster1'),
                        plotOutput('cluster2')
                      )
                      
             )
             
             #-------------------------------------------------------------
             
             
             
             
  )
)


