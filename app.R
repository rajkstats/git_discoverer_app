# GitDiscoverer ----

# App Layout -----

# Version 2

# Libraries ----
library(tidyverse)
library(jsonlite) # Required to convert between Json & R object
library(httpuv)  # Allows R code to listen for and interact with HTTP and WebSocket clients
library(httr)  # Required for Oauth 2.0
library(tidyverse) # Set of pkgs for data science: dplyr, ggplot2, purrr, tidyr, ...
library(shiny) # Web Application Framework for R
library(shinythemes) # Return the URL for a Shiny theme
library(devtools) # Collection of package development tools.
library(shinyjs) #Easily improve the user experience of your Shiny apps in seconds
library(shinyWidgets) # Custom inputs widgets for Shiny.
library(rsconnect) # Deployment Interface for R Markdown Documents and Shiny Applications
library(shiny) # Some advanced functionality depends on the shiny package being loaded server-side
library(shinyjs)
library(data.table)

source(file = "00_scripts/git_functions.R")
source(file = "00_scripts/info_card.R")
#source(file = "00_scripts/panel_card.R")
source(file = "00_scripts/generate_favorite_cards.R")
#source(file = "00_scripts/crud_operations_mongodb.R")

current_user_favorites <- c("tidyverse", "r4ds", "r-shiny")


# FUNCTIONS ---- 

github_app_auth()

#trending_repos <- trending_repos_on_github(language = "python", since = "daily", gtoken = gtoken)

#trending_repos

#trending_dev <- trending_developers_on_github(language = "python", since = "daily", gtoken = gtoken)

#trending_dev


# UI ----

ui <- navbarPage(
    
    title       =  "GitDiscoverer",
    inverse     = FALSE,
    collapsible = TRUE,
    
    theme = shinytheme("paper"),
    
    tabPanel(
        
        title =  "Trending Repositories",  
        
        # CSS ----
        #shinythemes::themeSelector(),
        
        tags$head(
            tags$link(rel = "stylesheet", type = "text/css", href = "styles.css")  
        ),
        
        # JS ----
        shinyjs::useShinyjs(),
        
        # 1.0  HEADER ----
        div(
            class = "container",
            id    = "header",
            h1(class = "page-header","GitDiscoverer", tags$small("placeholder")),
        ),

        # 2.0 Application UI ----
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
                        div(
                            class = "pull-right",
                            actionButton(inputId = "settings_toggle", label = NULL, icon = icon("cog"))
                        )
                    ),
                    
                    div(
                        id = "input_settings",
                        hr(),
                        sliderInput(inputId = "repo_stars", label = "Stars", value = 20, min = 5, max = 40),
                        sliderInput(inputId = "repo_forks", label = "Forks", value = 50, min = 50, max = 120)
                    ) %>% hidden()
                )    
            ),
            
            column(
                width = 8, 
                div(
                    class = "panel",
                    div(
                        class = "panel-header",
                        h4("Trending Repositories")
                    ),
                    div(
                        class = "panel-body",
                        #dataTableOutput(outputId = "repos")
                        div(
                            class = "container",
                            id    = "favorite_cards",
                            column(
                                width =3,
                                info_card(repo_name= 'r-shiny', repo_avatar = "",desc = "hello",forks = "23", stars = "50")
                            ),
                            column(
                                width =3,
                                info_card(repo_name= 'r4ds', repo_avatar = "",desc = "hello 123",forks = "23", stars = "50")
                                
                            )
                        )
                    )
                )
            )
        ),
    ),
    tabPanel(
        title = "Trending Developers",
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
            ),
            
            column(
                width = 8, 
                div(
                    class = "panel",
                    div(
                        class = "panel-header",
                        h4("Trending Developers")
                    ),
                    div(
                        class = "panel-body",
                        dataTableOutput(outputId = "dev")
                    )
                )
            )
        )
    )
)
        
        
        # SERVER ----
        
        server <- function(input, output, session) {
            
            # Toggle Input Settings ----
            observeEvent(input$settings_toggle,{
                toggle(id = "input_settings", anim = TRUE)
            })
            
            
            # User Input ----
            
            language <- eventReactive(input$get_trending,{
                input$language_selection
            }, ignoreNULL = FALSE)
            
            trend_freq <- eventReactive(input$get_trending,{
                input$trend_frequency
            }, ignoreNULL = FALSE)
            
            
            # Get Trending Repositories data ----
            trending_repos <- reactive({
                trending_repos_on_github(language = language(), since = trend_freq(), gtoken)
            })
            
            # Trending repositories ----
            output$repos <- renderDataTable({
                trending_repos()
            })
            
            # Get Trending Developers data ----
            trending_dev <- reactive({
                trending_developers_on_github(language = language(), since = trend_freq(), gtoken)
            })
            
            # Trending repositories ----
            output$dev <- renderDataTable({
                trending_dev()
            })
       
            
        }
        
        
        # RUN APP ----
        shinyApp(ui = ui, server = server)
        
        
        
        
        
        
        
        
        
        