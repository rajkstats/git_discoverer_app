div(
    class = "container",
    id    = "application_ui",
    column(
        width = 4,
        wellPanel(
            div(
                id = "input-main",
                pickerInput(
                    inputId  = "language_selection",
                    label    = "Language",
                    choices  = c("Python", "R", "JavaScript"), 
                    multiple = FALSE,
                    selected = "R",
                    options = pickerOptions(
                        actionsBox = FALSE,
                        liveSearch = TRUE,
                        size = 10
                    )
                ),
                pickerInput(
                    inputId  = "trend_frequency",
                    label    = "Trending",
                    choices  = c("Daily", "Weekly", "Monthly"), 
                    selected = "Daily",
                    multiple = FALSE
                )
            ),
            
            div(
                id = "input_buttons",
                actionButton(inputId = "get_trending", label = "Analyze", icon = icon("chart-line")),
            ),
            
        )    