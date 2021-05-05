library(shiny)
library(bubbles)
source("www/setup-sheets.R")

ui <- fluidPage(
    h1("Bubble Chart of Demo Responses"),
    actionButton("update", "Update"),
    bubblesOutput("bubbly")
)

server <- function(input, output, session) {

    data <- reactiveValues(food = NULL,
                           name = NULL)

    observeEvent(input$update, {

        values <- read_sheet(pres_sheet_id)

        data$food <- values$favorite_food[!is.na(values$favorite_food)]
        data$name <- values$name

        print(data$food)

    })

    output$bubbly <- renderBubbles({

        req(input$update)

        bubbles(1:length(data$food),
                label = data$food,
                color = rainbow(length(data$food), s = 0.6),
                textColor = "#000000")

    })

}

shinyApp(ui, server)
