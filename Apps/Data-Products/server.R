#
# server.R
#
library(shiny)
library(graphics)
library(stats)
library(ggplot2)
library(corrplot)
library(ape)


data(mtcars)

idx_regresor <- 1
flg_abline   <- TRUE

shinyServer(function(input, output, session) {
  
  idx_regresor <- reactive({ input$radio_regresor  })
  
  flg_abline   <- reactive({ input$checkbox_abline })
  
  output$plot1 <- renderPlot({
    y  <- mtcars$mpg; y_lab = "mpg"
    
    i <- idx_regresor()
    
    if ( i == 1 ) { x <- mtcars$disp         ; x_lab = "disp"        } 
    if ( i == 2 ) { x <- mtcars$hp           ; x_lab = "hp"          } 
    if ( i == 3 ) { x <- mtcars$drat         ; x_lab = "drat"        }  
    if ( i == 4 ) { x <- mtcars$wt           ; x_lab = "wt"          } 
    if ( i == 5 ) { x <- factor(mtcars$cyl)  ; x_lab = "factor(cyl)" } 
    if ( i == 6 ) { x <- factor(mtcars$vs)   ; x_lab = "factor(vs)"  } 
    if ( i == 7 ) { x <- factor(mtcars$am)   ; x_lab = "factor(am)"  } 
    if ( i == 8 ) { x <- factor(mtcars$gear) ; x_lab = "factor(gear)"} 
    if ( i == 9 ) { x <- factor(mtcars$carb) ; x_lab = "factor(carb)"}
    
    fit     <- lm( y ~ x )
    formula <- sprintf("%s ~ %s", y_lab, x_lab )
    
    plot(x, y, xlab = x_lab, ylab = y_lab)
    
    if ( flg_abline() ) {
      abline(coef = fit$coefficients, col = "red")  
    }
  })
  #--------------------------------------------------------------------
  output$plot2 <- renderPlot({
    y  <- mtcars$mpg; y_lab = "mpg"
    
    i <- idx_regresor()
    
    if ( i == 1 ) { x <- mtcars$disp         ; x_lab = "disp"        } 
    if ( i == 2 ) { x <- mtcars$hp           ; x_lab = "hp"          } 
    if ( i == 3 ) { x <- mtcars$drat         ; x_lab = "drat"        }  
    if ( i == 4 ) { x <- mtcars$wt           ; x_lab = "wt"          } 
    if ( i == 5 ) { x <- factor(mtcars$cyl)  ; x_lab = "factor(cyl)" } 
    if ( i == 6 ) { x <- factor(mtcars$vs)   ; x_lab = "factor(vs)"  } 
    if ( i == 7 ) { x <- factor(mtcars$am)   ; x_lab = "factor(am)"  } 
    if ( i == 8 ) { x <- factor(mtcars$gear) ; x_lab = "factor(gear)"} 
    if ( i == 9 ) { x <- factor(mtcars$carb) ; x_lab = "factor(carb)"}
    
    
    
    
    qplot(x, y, xlab = x_lab, ylab = y_lab,color = mtcars$cyl)
    
  })
  
  #-----------------------------------------------------------------
  output$corr2 <- renderPlot({
    mcor <- cor(mtcars)
    corrplot(mcor, method = "shade", shade.col = NA, tl.col = "black", tl.srt = 45)
  })
  
  #-----------------------------------------------------------------
  output$corr1 <- renderPlot({
    mcor <- cor(mtcars)
    corrplot(mcor)
  })
  #-----------------------------------------------------------------
  output$scatter <- renderPlot({
    mtcars$cyl <- as.factor(mtcars$cyl)
    qplot(mpg, disp, data = mtcars, color = cyl)
    
  })
  #-----------------------------------------------------------------
  output$cluster1 <- renderPlot({
    plot(hclust(dist(scale(mtcars))), main='Hierarchical clustering of cars', sub='1973-74 model year', xlab='Cars', ylab="")
  })
  #---------------------------------------------------------------------
  
  output$cluster2 <- renderPlot({
    hc = hclust(dist(mtcars))
    plot(as.phylo(hc), type = "fan", 
         tip.color = hsv(runif(15, 0.65, 0.95), 1, 1, 0.7), 
         edge.color = hsv(runif(10, 0.65, 0.75), 1, 1, 0.7),
         edge.width = runif(20,  0.5, 3),
         use.edge.length = TRUE,
         col = "gray80")
  })
  #---------------------------------------------------------------------
  
})
