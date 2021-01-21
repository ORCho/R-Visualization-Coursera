library(shiny)
library(tidyverse)
library(plotly)
library(DT)
library(RColorBrewer)
library(ggthemes)


#####Import Data

dat<-read_csv(url("https://www.dropbox.com/s/uhfstf6g36ghxwp/cces_sample_coursera.csv?raw=1"))
dat<- dat %>% select(c("pid7","ideo5","newsint","gender","educ","CC18_308a","region"))
dat<-drop_na(dat)

#####Make your app

ui <- navbarPage(
  
  title="Data Visualization with R",
  
  ##page 1
  tabPanel("Page 1",
           ##sidebar
           sidebarLayout(
             sidebarPanel(
               sliderInput(
                 inputId="checked_groups",
                 label="Select Five Point Ideology (1=Very liberal, 5=Very Conservative)",
                 min=1,
                 max=5,
                 value=3,
                 sep=""),
             ),
             
             mainPanel(
               tabsetPanel(
                 tabPanel("Tab 1", plotOutput("plot1")), 
                 tabPanel("Tab 2", plotOutput("plot2"))
               )
             )
           ),
           
           
           
  ),
  
  
  ##page 2 plot 3
  tabPanel("Page 2",
           ##sidebar Page 2
           sidebarLayout(
             sidebarPanel(
               
               checkboxGroupInput(inputId="gender1",
                                  label="Please choose  gender",
                                  choices=c("Male"=1, "Female"=2)
               ),
               
               
             ),
             mainPanel(
               plotlyOutput(outputId = "plot3")
             ),
           )
           
           
  ),
  
  ## page 3 table 1
  tabPanel("Page 3",
           
           sidebarLayout(
             sidebarPanel(
               
               selectInput(
                 inputId="region1",
                 label="Please select which region you want to check?",
                 choices=c(
                   "Northwest"=1,
                   "Midwest"=2,
                   "South"=3,
                   "West"=4
                 ),
                 selected=c("Northwest"=1,
                            "Midwest"=2,
                            "South"=3,
                            "West"=4)
                 
               ),
             ),
             
             mainPanel(
               dataTableOutput("table1", 
                               height = 500)
             ),
           )
  )##page
  
)







server<-function(input,output){
  
  output$plot1<-renderPlot({
    ## plot 1 in page 1a
    plot_dat<-filter(dat, ideo5 %in% input$checked_groups)
    
    ggplot(
      plot_dat,
      aes(x=pid7))+
      geom_bar()+
      scale_x_continuous(limits = c(0,8)) +
      scale_y_continuous(limits = c(0,120))+
      labs(x = "7 Point Party ID, 1=Very D, 7=Very R")+
      theme_solarized()
  }) 
  
  ## plot 2 in page 1b
  
  output$plot2<-renderPlot({
    
    plot_dat1<-filter(dat, ideo5 %in% input$checked_groups)
    
    ggplot(
      plot_dat1,
      aes(x=CC18_308a))+
      geom_bar()+
      scale_x_continuous(limits = c(0,5)) +
      scale_y_continuous(limits = c(0,150))+
      labs(x = "Trump Support")
  }) 
  
  
  ## plot 3 in page 2
  
  output$plot3 <- renderPlotly({
    
    dat_plot3<-filter(dat, gender %in% input$gender1 )
    dat_plot3$Gender2 <- recode(dat_plot3$gender,`1`="Male", '2'="Female")
    
    ggplot(dat_plot3,
           aes(x=educ,y=pid7))+
      geom_jitter(aes(colour = Gender2))+
      geom_smooth(method = lm)+ 
      theme(legend.position="none")+
      scale_color_brewer(palette="Set1")
    
  })
  
  ## page 3 table 
  
  output$table1 <- renderDataTable({
    dat_table<-filter(dat, region %in% input$region1)
  })
  
  
  #####Hint: when you make the data table on page 3, you may need to adjust the height argument in the dataTableOutput function. Try a value of height=500
  
} 

shinyApp(ui,server)