selectInputLang <- function(inputId, choices) {
    tags$div(
        style = "color:aliceblue; font-family:sans-serif; font-size:15px;font-weight:bolder;",
        selectInput(inputId, label = "Language",  choices , multiple = FALSE, selected = "R")
    )
}

selectInputTrend <- function(inputId) {
    tags$div(
        style = "color:aliceblue; font-family:sans-serif; font-size:15px;font-weight:bolder;",
        selectInput(inputId ,
                    label    = "Trending",
                    choices  = c("Daily", "Weekly", "Monthly"), 
                    selected = "Daily",
                    multiple = FALSE
        )
    )
}

selectInputProj <- function(inputId) {
    tags$div(
        style = "color:aliceblue; font-family:sans-serif; font-size:15px;font-weight:bolder;",
        selectInput(
            inputId  = "project_selection",
            label    = "Project",
            choices  = c("Machine Learning" = "ml", "Deep Learning" = "dl"), 
            selected = "ml",
            multiple = FALSE
        )
    )
}   

actionButtonFind <- function(inputId) {
    actionButton( inputId , label = "Find",icon = icon("chart-line"))
}

actionButtonSettings <- function(inputId) {    
    actionButton(inputId, label = NULL, icon = icon("cog"))
}

radioButtonsSort <- function(inputId, choices, selected) {
       radioGroupButtons(inputId, label = 'Sort By',choices = choices, selected = selected )
}
