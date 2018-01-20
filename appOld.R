#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
ui <- fluidPage(# Application title
    titlePanel("Google Summer of Code Statistics"),
    
    mainPanel(
        tabsetPanel(
            tabPanel("Plot", plotOutput("categoryBar"),
                     sliderInput(
                         "bins",
                         "Number of bins:",
                         min = 1,
                         max = 50,
                         value = 30
                     ),
                     plotOutput("categoryPie"),
                     sliderInput(
                         "bins",
                         "Number of bins:",
                         min = 1,
                         max = 50,
                         value = 30
                     ),
                     plotOutput("technologies"),
                     plotOutput("topics"),
                     plotOutput("projects")
            ),
            tabPanel("Summary",  dataTableOutput('table')),
            tabPanel("Table", tableOutput("table"))
        )
    ),
    
    # Sidebar with a slider input for number of bins
    sidebarLayout(sidebarPanel(
        sliderInput(
            "bins",
            "Number of bins:",
            min = 1,
            max = 50,
            value = 30
        )
    )
    
    # Show a plot of the generated distribution
    ))

# Define server logic required to draw a histogram
server <- function(input, output) {
    library(ggplot2)
    library(scales)
    
    organizationTable <- read.csv("gsoc.csv")
    organizationTable[] <- lapply(organizationTable, as.character)
    
    categoryMatrix <-
        sort(table(organizationTable$Category), decreasing = T)
    categoryMatrix <- as.data.frame(categoryMatrix)
    
    
    technoList <-
        unlist(strsplit(organizationTable$Technologies, " , "))
    technoList <- trimws(technoList)
    technoMatrix <- sort(table(technoList), decreasing = T)
    technoMatrix <- as.data.frame(technoMatrix)
    
    
    topicList <- unlist(strsplit(organizationTable$Topics, " , "))
    topicList <- trimws(topicList)
    topicMatrix <- sort(table(topicList), decreasing = T)
    
    topicMatrix <- as.data.frame(topicMatrix)
    
    organizationTable$CompletedProjects <- as.numeric(organizationTable$CompletedProjects)
    temp <- organizationTable[order(organizationTable$CompletedProjects, decreasing = T),]
    temp$OrganizationName <- factor(temp$OrganizationName, levels = temp$OrganizationName)
    
    
    
    output$categoryBar <- renderPlot({
             ggplot(categoryMatrix, aes(
            x = Var1,
            y = Freq,
            fill = Var1
        )) +
            geom_bar(stat = "identity") + theme(axis.text.x = element_text(angle = 40, hjust = 1)) +
            labs(x = "", 
                 y = "Number of Organizations",
                 title = "Number of Organizations in each fields") +
            scale_fill_discrete(name = "Organizations") +
            theme(axis.text.x = element_blank())
    })
    
    # output$categoryPie <- renderPlot({
    #     ggplot(categoryMatrix,
    #            aes(x = "", y = Freq, fill = Var1)) +
    #         geom_bar(stat = "identity", width = 1) +
    #         coord_polar("y", start = 0) +
    #         geom_text(aes(label = percent((Freq / 201))),
    #                   size = 4,
    #                   position = position_stack(vjust = 0.5)) +
    #         theme(
    #             axis.text = element_blank(),
    #             axis.ticks = element_blank(),
    #             panel.grid  = element_blank()
    #         ) +
    #         labs(x = "",
    #              y = "",
    #              title = "Percentage of the Organizations in each fields") +
    #         scale_fill_discrete(name = "Organizations")
    # })
        
    output$technologies <- renderPlot({
        ggplot(technoMatrix, aes(x = technoList, y = Freq, fill = technoList)) +
            geom_bar(stat = "identity") + theme(axis.text.x = element_text(angle = 40, hjust = 1)) +
            labs(x = "", y = "Number of Organizations", title = "Technologies used by organizations") +
            scale_fill_discrete(guide = FALSE)
    })
    
    output$topics <- renderPlot({
        ggplot(topicMatrix, aes(x = topicList, y = Freq, fill = topicList)) +
            geom_bar(stat = "identity") + theme(axis.text.x = element_text(angle = 40, hjust = 1)) +
            labs(x = "", y = "Number of Organizations", title = "Topics covered by organizations") +
            scale_fill_discrete(guide = FALSE)
    })
    
    output$projects <- renderPlot({
            ggplot(temp, aes(x = OrganizationName, y = CompletedProjects, fill = OrganizationName)) +
            geom_bar(stat = "identity") + theme(axis.text.x = element_text(angle = 30, hjust = 1)) +
            labs(x = "", y = "Number of Successful projects", title = "Successful projects by organizations") +
            scale_fill_discrete(guide = F) 
    })
    
  
    output$table <- renderDataTable(organizationTable)
    
    
}

# Run the application
shinyApp(ui = ui, server = server)
