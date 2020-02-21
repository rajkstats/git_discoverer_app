# GitDiscoverer ----

# App Layout -----

# Version 2

# Credits ----
# https://unsplash.com/photos/842ofHC6MaI


# Libraries ----

library(devtools) # Collection of package development tools.

# Authentication
library(httpuv)  # Allows R code to listen for and interact with HTTP and WebSocket clients
library(httr)  # Required for Oauth 2.0

# Data Manipulation
library(tidyverse) # Set of pkgs for data science: dplyr, ggplot2, purrr, tidyr, ...
library(jsonlite) # Required to convert between Json & R object
library(data.table)
library(dplyr)
library(purrr)

# Shiny
library(shiny) # Web Application Framework for R
library(shinythemes) # Return the URL for a Shiny theme
library(shinyjs) #Easily improve the user experience of your Shiny apps in seconds
library(shinyWidgets) # Custom inputs widgets for Shiny.
library(shiny) # Some advanced functionality depends on the shiny package being loaded server-side
library(shinyjs)
library(waiter) # For Loadimng Screens
library(shinycssloaders)
library(sever)
library(shinycustomloader) # For Loading bars 
library(rintrojs)

source(file = "00_Scripts/git_functions.R")
source(file = "00_Scripts/info_card.R")
source(file = "00_Scripts/cards_functions.R")
source(file = "00_Scripts/helper_functions.R")


options(shiny.autoreload = TRUE)
#trending_repos <- trending_repos_on_github(language = "python", since = "weekly",gtoken = gtoken)
#trending_repos <- tibble::rowid_to_column(trending_repos, "id")


# Application Auth ----
github_app_auth()

#current_user_favorites <- c("AAPL", "GOOG", "NFLX")

# FUNCTIONS ----
navbar_page_with_inputs <- function(...) {
  navbar <- shiny::navbarPage(...)
  
  return(navbar)
}


# UI -----
ui <- fluidPage(
  
  use_sever(),
  use_waiter(include_js = FALSE), 
  use_steward(),
  use_waitress(),
  waiter_show_on_load(spin_hexdots()),
  shinyjs::useShinyjs(),
  #includeCSS("www/loading-content.css"),
  
  # 1.0 HEAD ----
  tagList(
    tags$head(HTML("<title>Git Discoverer</title>")),
    
  ),
  style = "padding:0px;",
  
  
  #div(id = "loading-content", "Hard = Those that create something you'd be proud of...",
  #   img(src = "ajax-loader-bar.gif")),
  # JUMBOTRON COMPONENT ----
  div(
    class = "container-fluid",
    style = "padding:0;",
    id = "jumbotron",
    #column( # structure
      #width = 12,
      div( # component
        class = "jumbotron",
        style = "background-image:url('github.jpg'); background-size: cover;margin-bottom:0;",
        div(
          class = "jumbotron-ui-box text-default bg-primary bg-default",
          style = "color:white; background-color:rgba(0,0,0,0.5); padding:25px;",
          
          # User Inputs Go here
          h1("GitDiscoverer", style = "color: white;"),
          br(),
          a(href = "#", class = "btn btn-primary", "Learn More")
          
        )
      )
    #)
    ),
  
  
  # The main app code goes here
  hidden(
      
    div(
      
      id = "app-content",
      
      
      navbar_page_with_inputs(
        
        
        # 2.1 Application Title ----
        title = div(
          # tags$img(
          #   src = "gd.png",
          #   width  = "30",
          #   height = "30",
          #   style  = "-webkit-filter: drop-shadow(3px 3px 3px #222);"
          # ),
          tags$h1("GitDiscoverer"),
          tags$style(HTML("
                        @import url('//fonts.googleapis.com/css?family=Titillium+Web:700');
                        
                        h1{
                        font-family:'Titillium Web', sans-serif;;
                        font-size: 30px;
                        font-weight: 400;
                        letter-spacing: -1px;
                        line-height: 1.2;
                        display:contents;
                        #color: #008B8B;
                        }
                        
                        ")) #style closed
          
        ),
        collapsible = TRUE,
        
        theme = shinytheme("paper"),
        
        # PANEL START: Trending Repositories ----
        tabPanel(
          title = "Trending Repositories",
        
          # CSS ----
          #shinythemes::themeSelector(),
          tags$head(
            tags$link(rel = "stylesheet", type = "text/css", href = "styles.css")
          ),
          
          # JS ----
          shinyjs::useShinyjs(),
          
          
          # HEADER -----    
          
          # 2.0 FAVORITES ----
          # div(
          #     class = "container hidden-sm hidden-xs",
          #     id = "favorite_container",
          # 
          #     div(
          #         class = "",
          #         column(
          #             width = 12,
          #             h5(class= "pull-left","Favorites"),
          #             actionButton(inputId = "favorites_clear", "Clear Favorites", class = "pull-right"),
          #             actionButton(inputId = "favorites_toggle", "Show/Hide", class = "pull-right")
          #         )
          #     ),
          #     div(
          #         class = "container",
          #         id    = "favorite_cards",
          #         column(
          #             width =3,
          #             info_card(repo_name = "AiLearning",
          #                       repo_avatar = "https://avatars3.githubusercontent.com/u/24802038?v=4",
          #                       repo_link = "https://github.com/apachecn/AiLearning")
          #         ),
          #         column(
          #             width =3,
          #             info_card(repo_name = "airflow",
          #                       repo_avatar = "https://avatars0.githubusercontent.com/u/47359?v=4",
          #                       repo_link = "https://github.com/apache/airflow")
          # 
          #         )
          #     )
          # ),
          
          
          # Application UI ----
          div(
            id    = "application_ui",
            class = "container",
            column(
              width =3,
              wellPanel(
                div(
                  id = "input-main",
                  pickerInputLang(inputId = "language_selection",choices  = c("R", "Python", "JavaScript")),
                  pickerInputTrend(inputId  = "trend_frequency"),
                ),
                div(
                  id = "input_buttons",
                  actionButtonFind(inputId = "get_trending"),
                  div(
                    class = "pull-right",
                    actionButtonSettings(inputId = "settings_toggle")
                  )
                ),
                div(
                  id = "input_settings",
                  hr(), 
                  style = "width:max-content;",
                  radioButtonsSort(inputId = 'var', choices =  c("trend","stars","forks"), selected = "trend"),
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
          title = "Trending Developers",
          
          # CSS ----
          #shinythemes::themeSelector(),
          tags$head(
            tags$link(rel = "stylesheet", type = "text/css", href = "styles.css")
          ),
          
          # JS ----
          shinyjs::useShinyjs(),
          
          # Application UI ----
          div(
            id    = "application_ui_dev",
            class = "container",
            column(
              width =3,
              wellPanel(
                div(
                  id = "input-main-dev",
                  pickerInputLang(inputId = "language_selection_dev",choices  = c("R", "Python", "JavaScript")),
                  pickerInputTrend(inputId  = "trend_frequency_dev")
                ),
                div(
                  id = "input_buttons_dev",
                  actionButtonFind(inputId = "get_trending_dev"),
                )
              )
            ),
            
            
            # 1.3.2 App Library ----
            div(
              class = "container",
              id    = "cards-dev",
              uiOutput(outputId = "output_dev_cards")
            )
          )
          
        ), # PANEL END :TD ----
        
        # PANEL START:Trending Projects ----
        tabPanel(
          title = "Popular Projects",
          # CSS ----
          #shinythemes::themeSelector(),
          tags$head(
            tags$link(rel = "stylesheet", type = "text/css", href = "styles.css")
          ),
          
          # JS ----
          shinyjs::useShinyjs(),
          
          # Application UI ----
          div(
            id    = "application_ui_projects",
            class = "container",
            column(
              width =3,
              wellPanel(
                div(
                  id = "input-main-project",
                  pickerInputLang(inputId  = "language_selection_project",choices  = c("R", "Python")),
                  pickerInput(
                    inputId  = "project_selection",
                    label    = "Project",
                    choices  = c(ML = "ml", DL = "dl"), 
                    selected = "ml",
                    multiple = FALSE
                  )
                ),
                div(
                  id = "input_buttons_pro",
                  actionButtonFind(inputId = "get_trending_pro"),
                  div(
                    class = "pull-right",
                    actionButtonSettings(inputId = "settings_toggle_pro")
                  )
                ),
                div(
                  id = "input_settings_pro",
                  hr(), 
                  style = "width:max-content;",
                  radioButtonsSort(inputId = 'var1', choices =  c("stars","forks"), selected = "stars")
                ) %>% hidden()
              )
            ),
            
            # 1.3.2 App Library ----
            div(
              class = "container",
              id    = "cards-project",
              uiOutput(outputId = "output_project_cards")
            )
          )
        )# TabPanel Projects End ----
      )
    )
  )
)

# SERVER ----    
server <- function(input, output, session) {
  
  # Simulate work being done for 1 second
  #show("loading-content") # make the loading pane appear
  sever()
  Sys.sleep(2) #  something that takes time

  waiter_hide()

  
  show("app-content")
  
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
  
  # Trending Repos ---- 
  trending_repos <- reactive({
    
    tr <- trending_repos_on_github(language = language(), since = trend_freq(),gtoken = gtoken)
    # Sorting based on selection stars/forks
    if(input$var == "stars" | input$var == "forks") {
      tr <- tr[order(unlist(tr %>% pull(input$var)), decreasing = TRUE),]
    } else{
      tr <- trending_repos_on_github(language = language(), since = trend_freq(),gtoken = gtoken)
    }
    
    tr <- tibble::rowid_to_column(tr, "id")
    
  })
  
  
  # Language Selection Developers ----
  language_dev <- eventReactive(input$get_trending_dev,{
    input$language_selection_dev
  }, ignoreNULL = FALSE)
  
  # Trend Frequency Developers ----
  trend_freq_dev <- eventReactive(input$get_trending_dev,{
    input$trend_frequency_dev
  }, ignoreNULL = FALSE)
  
  # Trending Developers ---- 
  trending_dev <- reactive({
    tr <- trending_developers_on_github(language = language_dev(), since = trend_freq_dev(),gtoken = gtoken)
    tr <- tibble::rowid_to_column(tr, "id")
    
  })
  
  
  # Trending Project Selection ----
  observeEvent(input$settings_toggle_pro,{
    toggle(id = "input_settings_pro", anim = TRUE)
  })
  
  project <- eventReactive(input$get_trending_pro,{
    input$project_selection
  }, ignoreNULL = FALSE)
  
  # Language Selection Projects ----
  language_project <- eventReactive(input$get_trending_pro,{
    input$language_selection_project
  }, ignoreNULL = FALSE)
  
  
  # Trending Projects ---- 
  trending_projects <- reactive({
    tr <- trending_projects_on_github(project = project(), language = language_project())
    # Sorting based on selection stars/forks
    if(input$var1 == "stars" | input$var1 == "forks") {
      tr <- tr[order(unlist(tr %>% pull(input$var1)), decreasing = TRUE),]
    } 
    tr <- tibble::rowid_to_column(tr, "id")
    
  })
  
  
  # FAVORITES ----
  
  #     # 2.1 Reactive Values - User Favorites ----
  #     reactive_values <- reactiveValues()
  #     reactive_values$favorites_list <- current_user_favorites
  #     
  #     # 2.2 Add Favorites ----
  #     observeEvent(input$favorites_add, {
  #         new_symbol <- get_repo_from_user_input(input$stock_selection)
  #         reactive_values$favorites_list <- c(reactive_values$favorites_list, new_symbol) %>% unique()
  #     })
  #     
  #     # 2.3 Render Favorite Cards ----
  #     output$favorite_cards <-renderUI({
  #         
  #         if(length(reactive_values$favorites_list)>0){
  #             
  #             generate_favorite_cards(
  #                 favorites  = reactive_values$favorites_list,
  #                 from       = today() - days(180), 
  #                 to         = today(),
  #                 mavg_short = input$mavg_short,
  #                 mavg_long  = input$mavg_long
  #             )
  #             
  #         } else {
  #             reactive_values$favorites_list <- NULL
  #         }
  #         
  #     })
  #     
  #     # 2.4 Delete Favorites ----
  #     observeEvent(input$favorites_clear,{
  #         modalDialog(
  #             title = "Clear Favorites",
  #             size = "m",
  #             easyClose = TRUE,
  #             
  #             p("Are you sure you want to remove favorites?"),
  #             br(),
  #             div(
  #                 selectInput(inputId = "drop_list",
  #                             label = "Remove Single Favorite",
  #                             choices = reactive_values$favorites_list %>% sort()),
  #                 actionButton(inputId = "remove_single_favorite",
  #                              label   = "Clear Single",
  #                              class   = "btn-warning"),
  #                 actionButton(inputId = "remove_all_favorites",
  #                              label   = "Clear ALL Favorites",
  #                              class   = "btn-danger")
  #                 
  #             ),
  #             
  #             footer = modalButton("Exit")
  #         ) %>% showModal()
  #     })
  #     
  #     # 2.4.1 Clear Single ----
  #     observeEvent(input$remove_single_favorite,{
  #         
  #         
  #         reactive_values$favorites_list <- reactive_values$favorites_list %>%
  #             .[reactive_values$favorites_list != input$drop_list]
  #         
  #         
  #         updateSelectInput(session = session, 
  #                           inputId = "drop_list",
  #                           choices = reactive_values$favorites_list %>% sort()
  #         )
  #         
  #     })
  #     
  #     # 2.4.2 Clear All ----
  #     observeEvent(input$remove_all_favorites,{
  #         reactive_values$favorites_list <- NULL
  #         
  #         updateSelectInput(session = session, 
  #                           inputId = "drop_list",
  #                           choices = ""
  #         )
  #     })
  #     
  #     
  #     # 2.5 Show/Hide Favorites ----
  #     observeEvent(input$favorites_toggle,{
  #         shinyjs::toggle(id = "favorite_card_section", anim = TRUE, animType = "slide")
  #     })
  #     
  # }
  

  
  # Render Trending Repositories Cards ----
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

  
  # Render Trending Developers Cards ----
  output$output_dev_cards <- renderUI({
    
    div(
      class = "container",
      div(
        class = "row",
        style = "display:-webkit-flex; flex-wrap:wrap;",
        trending_dev() %>%  make_dev_cards()
      )
    )
    
  })
  
  # Render Trending Project Cards ----
  output$output_project_cards <- renderUI({
    
    div(
      class = "container",
      div(
        class = "row",
        style = "display:-webkit-flex; flex-wrap:wrap;",
        trending_projects() %>%  make_project_cards()
      )
    )
    
  })
  
  hide("loading-content",anim=TRUE, animType = "fade") # make the loading pane disappear
  
  
}    


# RUN APP ----
shinyApp(ui = ui, server = server)