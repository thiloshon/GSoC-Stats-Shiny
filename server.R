library(shiny)
library(ggplot2)
library(knitr)
set.seed(123)


shinyServer(function(input, output) {
    
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
    
    output$topics <- renderPlot({
        no <- input$topicsNumber
        offset <- input$topicsoffset
        
        if ((no + offset) < 440){
            start <- offset + 1
            end <- offset + no
        }else {
            start <- 440 - no
            end <- 440
        }
        
        ggplot(topicMatrix[start:end,], aes(x = topicList, y = Freq, fill = topicList)) +
            geom_bar(stat = "identity") + theme(axis.text.x = element_text(angle = 40, hjust = 1)) +
            labs(x = "", y = "Number of Organizations", title = "Topics covered by organizations") +
            scale_fill_discrete(guide = FALSE)
    })
    
    output$technologies <- renderPlot({
        no <- input$technologiesNumber
        offset <- input$technologiesoffset
        
        if ((no + offset) < 271){
            start <- offset + 1
            end <- offset + no
        }else {
            start <- 271 - no
            end <- 271
        }
        
        ggplot(technoMatrix[start:end,], aes(x = technoList, y = Freq, fill = technoList)) +
            geom_bar(stat = "identity") + theme(axis.text.x = element_text(angle = 40, hjust = 1)) +
            labs(x = "", y = "Number of Organizations", title = "Technologies used by organizations") +
            scale_fill_discrete(guide = FALSE)
    })
    
    output$projects <- renderPlot({
        no <- input$projectsNumber
        offset <- input$projectsoffset
        
        if ((no + offset) < 201){
            start <- offset + 1
            end <- offset + no
        }else {
            start <- 201 - no
            end <- 201
        }
        
        
        ggplot(temp[start: end,], aes(x = OrganizationName, y = CompletedProjects, fill = OrganizationName)) +
            geom_bar(stat = "identity") + theme(axis.text.x = element_text(angle = 30, hjust = 1)) +
            labs(x = "", y = "Number of Successful projects", title = "Successful projects by organizations") +
            scale_fill_discrete(guide = F) 
    })
    
    output$mytable = DT::renderDataTable({
        organizationTable
    })

    output$topicsData = DT::renderDataTable({
        topicMatrix$topicList <- as.character(topicMatrix$topicList)
        colnames(topicMatrix) <- c("Topics Covered", "Number of projects covering the topic")
        topicMatrix
    })
    
    output$technologiesData = DT::renderDataTable({
        technoMatrix$technoList <- as.character(technoMatrix$technoList)
        colnames(technoMatrix) <- c("Technologies Covered", "Number of projects covering the technology")
        technoMatrix
    })
})
