pickerInputLang <- function(inputId, choices) {
    pickerInput(inputId, label = "Language",  choices , multiple = FALSE, selected = "R",
                options = pickerOptions(
                    actionsBox = FALSE,
                    liveSearch = TRUE,
                    size = 10
                )
    )
}

pickerInputTrend <- function(inputId) {
    pickerInput(inputId ,
        label    = "Trending",
        choices  = c("Daily", "Weekly", "Monthly"), 
        selected = "Daily",
        multiple = FALSE
    )
}

actionButtonFind <- function(inputId) {
    actionButton( inputId , label = "Find",icon = icon("chart-line"))
}

actionButtonSettings <- function(inputId) {    
    actionButton(inputId, label = NULL, icon = icon("cog"))
}

radioButtonsSort <- function(inputId) {
    radioGroupButtons(inputId, label = 'Sort By',choices = c(Stars='stars',Forks='forks'),selected = 'stars')
}
