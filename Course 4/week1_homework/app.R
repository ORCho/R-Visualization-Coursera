library(shiny)
library(tidyverse)

#####Import Data

dat<-read_csv(url("https://www.dropbox.com/s/uhfstf6g36ghxwp/cces_sample_coursera.csv?raw=1"))
dat<- dat %>% select(c("pid7","ideo5"))
dat<-drop_na(dat)

ui<-fluidPage(
    
    titlePanel("Shiny Homework1"),
    
    sidebarLayout(
        
        sidebarPanel(
            sliderInput("checked_groups", "Select Five Point Ideology(1=very liberal, 5=very conservative):",  
                        min = 1, max = 5, value = 1)
        ),
        
        mainPanel(
            plotOutput("distPlot")
        )
    )
)

    
    
    server<-function(input,output){
        
        output$distPlot<-renderPlot({
            
            plot_dat<-filter(dat, ideo5 %in% input$checked_groups)
            
            ggplot(
                dat=plot_dat,
                aes(x=pid7))+
                geom_bar()+
                scale_x_continuous(limits = c(0,8)) +
                scale_y_continuous(limits = c(0,120))+
                labs(x = "7 Point Party ID, 1=Very D, 7=Very R")
            }) 
    }

shinyApp(ui,server)