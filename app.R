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
library(shiny) # Some advanced functionality depends on the shiny package being loaded server-side
library(shinyjs)
library(data.table)

source(file = "00_scripts/git_functions.R")

#trending_repos <- trending_repos_on_github(language = "python", since = "weekly",gtoken = gtoken)
#trending_repos <- tibble::rowid_to_column(trending_repos, "id")


# FUNCTIONS ----
github_app_auth()

# FUNCTIONS ----
navbar_page_with_inputs <- function(...) {
    navbar <- shiny::navbarPage(...)

    return(navbar)
}


make_cards <- function(data) {
    data %>%
        mutate(id = as_factor(id)) %>%
        group_by(id) %>%
        group_split() %>%
        
        map(.f = function(data) {
            
            # Card 1
            div(
                class = "col-sm-4",
                style = "display:flex;",
                div(
                    class = "panel panel-default",
                    style = "width:100%;",
                    #  div(
                    #      class = "panel-heading",
                    #      span(class = "label label-info", "AWS")
                    # ),
                    div(
                        class = "panel-body",
                        style = "padding:20px;",

                        # image
                        tags$img(
                            class = "img-fluid img-thumbnail",
                            style = "width:100%;height:auto;border:none;",
                            src   = data$avatar
                        ),
                        
                        br(), br(),
                        tags$h4(
                            data$name,
                            style = "font-size: 18px; font-weight: bold; text-overflow:ellipsis;"
                        ),
                        p(data$description),
                        a(
                            type   = "button",
                            class  = "btn btn-primary",
                            target = "_blank",
                            href   = data$url,
                            "View Repo"
                        ),
                        # Github Stars
                        div(
                            class = "btn btn-default btn-sm pull-right",
                            span(class = "glyphicon glyphicon-star", data$stars)
                        ),
                        # Github Forks
                        div(
                            class = "btn btn-default  btn-sm pull-right",
                            span(class = "fas fa-code-branch", data$forks)
                        ),
                        
                    ),
       
                )
            )
        }) %>%
        
        tagList()
}




# UI -----
ui <- fluidPage(
    
    # 1.0 HEAD ----
    tagList(
        tags$head(HTML("<title>Git Discoverer</title>"))
    ),
    style = "padding:0px;",
    
    
    
    navbar_page_with_inputs(
    # 2.1 Application Title ----
    title = div(
        tags$img(
            src = "https://www.business-science.io/img/business-science-logo.png",
            width  = "30",
            height = "30",
            style  = "-webkit-filter: drop-shadow(3px 3px 3px #222);"
        ),
        "GitDiscoverer"
    ),
    collapsible = TRUE,
    
    theme = shinytheme("paper"),

    # PANEL START: Trending Repositories ----
    tabPanel(
        title = "Trending Repositories",
        
        # JS ----
        shinyjs::useShinyjs(),

        
        # Application UI ----
        div(
            id    = "application_ui",

            column(
                width =3,
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
                        actionButton( inputId = "get_trending", label = "Find",icon = icon("chart-line")),
                        div(
                            class = "pull-right",
                            actionButton(inputId = "settings_toggle", label = NULL, icon = icon("cog"))
                        )
                    ),
                    
                    div(
                        id = "input_settings",
                        hr(), 
                        radioGroupButtons(inputId = 'var', label = 'Sort By',choices = c(Stars='stars',Forks='forks'),selected = 'stars'),
                        #actionButton(inputId = "sort_stars", label = "Sort By",icon = icon("star")),
                        #actionButton(inputId = "sort_forks", label = "Sort By",icon = icon("code-branch")),
                    ) %>% hidden()
                )
            ),
            
            # 1.3.2 App Library ----
            div(
                class = "container",
                id    = "app-library",
                uiOutput(outputId = "output_cards")
            )
         )  
        
    ), # PANEL END :TR ----
    
    # PANEL START:Trending Developers ----
    tabPanel(
        title = "Trending Developers"
    ) # PANEL END :TD ----

) 
)
# SERVER ----    
server <- function(input, output, session) {

    # Toggle Input Settings ----
    observeEvent(input$settings_toggle,{
        toggle(id = "input_settings", anim = TRUE)
    })
    
    
    # Language Selection ----
    language <- eventReactive(input$get_trending,{
        input$language_selection
    }, ignoreNULL = FALSE)
    
    # Trend Frequency ----
    trend_freq <- eventReactive(input$get_trending,{
        input$trend_frequency
    }, ignoreNULL = FALSE)

    
    # Trending Repos ---- 
    trending_repos <- reactive({
        tr <- trending_repos_on_github(language = language(), since = trend_freq(),gtoken = gtoken)
        # Sorting based on selection stars/forks
        tr <- tr[order(unlist(tr %>% pull(input$var)), decreasing = TRUE),]
        tr <- tibble::rowid_to_column(tr, "id")
        
    })
    
    
    # Render Trending Cards ----
    output$output_cards <- renderUI({
        
        div(
            class = "container",
            div(
                class = "row",
                style = "display:-webkit-flex; flex-wrap:wrap;",
                trending_repos() %>%  make_cards()
            )
        )
        
    })

}    


# RUN APP ----
shinyApp(ui = ui, server = server)

    
    
    
    
    
    
    