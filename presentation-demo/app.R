library(shiny)
library(shinysurveys)
library(googledrive)
library(googlesheets4)
library(bubbles)
source("www/setup-sheets.R")

df <- data.frame(question = c("What is your favorite food?",
                              "What's your name?"),
                 option = NA,
                 input_type = "text",
                 input_id = c("favorite_food", "name"),
                 dependence = NA,
                 dependence_value = NA,
                 required = c(TRUE, FALSE))

ui <- fluidPage(
    tags$head(
        tags$script(src = "reset.js"),
        tags$link(rel = "stylesheet", type = "text/css", href = "styles.css")
    ),
tabsetPanel(
    tabPanel(title = "Survey",
             surveyOutput(df = df,
                          survey_title = "Hello, World!",
                          survey_description = "A demo survey")
    ),
    tabPanel(title = "Results",
             column(width = 8, offset = 2,
                    h1("Bubble Chart of Demo Responses"),
                    bubblesOutput("bubbly"))
    )
)
)

server <- function(input, output) {

    renderSurvey(df)


    data <- reactiveValues(food = NULL,
                           name = NULL)

    observeEvent(input$submit, {


        # Show Modal Dialogue
        shiny::showModal(
            shiny::modalDialog(title = "Congratulations, you completed your first shinysurvey!",
                               "Thanks for listening to my thesis presentation (: \n
                               Feel free to submit another favorite food!", easyClose = TRUE))

        # Create Response Data Frame
        responses <- data.frame(favorite_food = input$favorite_food,
                                name = input$name)

        # Write Response to Google Sheet
        sheet_append(ss = pres_sheet_id, data = responses)


        # Read in responses
        values <- read_sheet(pres_sheet_id)

        data$food <- values$favorite_food[!is.na(values$favorite_food)]
        data$name <- values$name

        # Reset Text Update Manually
        shiny::updateTextInput(inputId = "name")

    })

    output$bubbly <- renderBubbles({

        if (!is.null(data$food))

            bubbles(1:length(data$food),
                    label = data$food,
                    color = rainbow(length(data$food), s = 0.6),
                    textColor = "#000000")

    })

}

shinyApp(ui = ui, server = server)
