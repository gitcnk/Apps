# CLT user interface
library(mosaic)
colleges <- read_csv(file = 'https://raw.githubusercontent.com/gitcnk/Data/master/colleges2016.csv')

mydata <- select_if(colleges, is.numeric)
nsim <- 1E4


ui <- fluidPage(
    
    titlePanel("Colleges in the US"),
    
    sidebarPanel(width = 3,
                 
                 varSelectInput(inputId = "variable", 
                                label = "Pick a Variable:", mydata),
                 
                 
                 sliderInput(inputId="n",
                             label = "Sample Size n",
                             value = 30,
                             min= 10,
                             max= 500, 
                             step= 50),
                 
                 
                 textOutput(outputId = "popmean"),
                 
                 textOutput(outputId = "test2")
    ),
    
    mainPanel(
        fluidRow(plotOutput("Pop", width = '600px', height = '300px' )),
        
        fluidRow(plotOutput('SamDist',width = '600px', height = '330px'))
    )
)

