library(shiny)
library(shinysurveys)
library(googledrive)
library(googlesheets4)
source("www/setup-sheets.R")

df <- data.frame(question = c("What is your favorite food?",
                              "(Optional) What's your name?"),
                 option = NA,
                 input_type = "text",
                 input_id = c("favorite_food", "name"),
                 dependence = NA,
                 dependence_value = NA,
                 required = c(TRUE, FALSE))

ui <- fluidPage(
    tags$script(src = "reset.js"),
    surveyOutput(df = df,
                 survey_title = "Hello, World!",
                 survey_description = "A demo survey")
)

server <- function(input, output, session) {
    renderSurvey(df = df)

    observeEvent(input$submit, {

        shiny::showModal(
            shiny::modalDialog(title = "Congratulations, you completed your first shinysurvey!",
                               "Thanks for listening to my thesis presentation (: \n
                               Feel free to submit another favorite food!"))

        responses <- data.frame(favorite_food = input$favorite_food,
                                name = input$name)

        sheet_append(ss = pres_sheet_id, data = responses)

    })
}

shinyApp(ui, server)

