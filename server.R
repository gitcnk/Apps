# Server for the CLT app

library(mosaic)
library(tidyverse)
colleges <- read_csv(file = 'https://raw.githubusercontent.com/gitcnk/Data/master/colleges2016.csv')

mydata <- select_if(colleges, is.numeric)
nsim <- 1E4

server <- function(input, output) 
{
    pop_mean <- reactive({ mean(mydata[[input$variable]])})
    
    myn <- reactive({input$n})
    
    output$test1 <- renderText(myn())
    
    output$popmean <- renderText(pop_mean())
    
    
    
    output$Pop <- renderPlot({
        ggplot(mydata) +
            aes(x = !!input$variable) + 
            geom_histogram() +
            labs(title = 'Distribution of the Selected Variable',
                 subtitle = 'Data Source: US Colleges',
                 x = 'Variable of interest')
    })
    
    output$SamDist<- renderPlot({
        
        
        mysamples <- matrix( 0, nrow = nsim, ncol = input$n)
        mysamples <- do(nsim)*sample(mydata[[input$variable]], size = input$n)
        mymeans <- apply(mysamples, MARGIN = 1, FUN = mean)
        
        ggplot() +
            aes( x = mymeans) +
            geom_histogram() +
            labs(title = 'Sampling Distribution of the Sample Mean',
                 subtitle = '',
                 x = 'sample mean')
    })
    #  }
    
    
}

