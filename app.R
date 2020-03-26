# GitDiscoverer ----

# Required Libraries ----

# 1. Authentication ----
library(httpuv)  # Allows R code to listen for and interact with HTTP and WebSocket clients
library(httr)  # Required for Oauth 2.0

# 2. Data Manipulation ----
library(tidyverse) # Set of pkgs for data science: dplyr, ggplot2, purrr, tidyr, ...
library(jsonlite) # Required to convert between Json & R object
library(data.table) # Provides high-performance version of base R dataframes
library(dplyr) # A grammar of data manipulation 
library(purrr) # Provides functional programming toolkit for R

# 3. Shiny ----
library(shiny) # Web Application Framework for R
library(shinythemes) # Return the URL for a Shiny theme
library(shinyjs) #Easily improve the user experience of your Shiny apps in seconds
library(shinyWidgets) # Custom inputs widgets for Shiny.
library(shinyjs)
library(waiter) # For Loading Screens
library(shinycustomloader) # For Loading Bars on navbar page 
library(sever) # For Waiting Screen

# Sourcing custom functions here
source(file = "00_Scripts/git_functions.R")
source(file = "00_Scripts/info_card.R")
source(file = "00_Scripts/cards_functions.R")
source(file = "00_Scripts/helper_functions.R")


#options(shiny.autoreload = TRUE)

# App Layout -----

# Application Auth ----
github_app_auth()


# FUNCTIONS ----

navbar_page_with_inputs <- function(...) {
  navbar <- shiny::navbarPage(...) 
  return(navbar)
}


# UI -----
ui <- fluidPage(
  
  use_sever(),
  use_waiter(), 
  use_steward(),
  waiter_show_on_load(spin_hexdots()),
  
  shinyjs::useShinyjs(),
  
  # Google Analytics
  tags$head(includeHTML(("www/google-analytics.html"))),
  
  
  # 1.0.0 HEAD ----
  
  tagList(
    tags$head(HTML("<title>Git Discoverer</title>")),
    
  ),
  style = "padding:0px;",
  
  
  
  
  # 1.1.0 JUMBOTRON COMPONENT ----
  div(
    class = "container-fluid",
    style = "padding:0;",
    id = "jumbotron",
    div( # component
      class = "jumbotron",
      style = "background-image:url('github.jpg'); background-size: cover;margin-bottom:0;",
      div(
        class = "jumbotron-ui-box text-default bg-primary bg-default",
        style = "color:white; background-color:rgba(0,0,0,0.5); padding:25px;",
        h1("GitDiscoverer",tags$small("for DS community", style = "color: white; font-size:50%;"), style = "color: white;"),
        br(),
        a(href = "https://www.linkedin.com/post/edit/6646058848618708994/", class = "btn btn-primary", "Write us a Review", style = "text-transform: inherit;")
      )
    )
  ),
  
  
  div(
    
    id = "app-content",
    style="font-weight:100; font-size:initial;",
    
    # 2.0.0 NAVBAR PAGE ----
    navbar_page_with_inputs(
      
      # 2.1.0 Application Title ----
      title = div(
        # adding share it buttons
        tags$script(src= '//platform-api.sharethis.com/js/sharethis.js#property=5c80c0e64c495400114fe801&product=inline-share-buttons',async='async'),
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
      
      
      # 2.2.0 PANEL START:Trending Repos ----
      tabPanel(
        #style = "font-size:initial; font-weight:100;",  
        title = "Trending Repositories",
        
        # 2.2.1 CSS ----
        tags$head(
          tags$link(rel = "stylesheet", type = "text/css", href = "styles.css")
        ),
        
        
        # 2.2.2 Application UI ----
        div(
          id    = "application_ui",
          class = "container",
          
          fluidRow(
            column(
              width =3,
              wellPanel(
                style= "background-color:#525f7f;",
                div(
                  id = "input-main",
                  selectInputLang(inputId = "language_selection",choices  = c("R", "Python", "JavaScript")),
                  selectInputTrend(inputId  = "trend_frequency"),
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
                  style = "width:max-content; color:aliceblue; font-family:sans-serif; font-size:15px; font-weight:bold;",
                  radioButtonsSort(inputId = 'var', choices =  c("trend","stars","forks"), selected = "trend"),
                ) %>% hidden()
              )
            ),
            
            
            # 2.2.3 Output Cards ----
            column(
              width =9,  
              div(
                id    = "app-library",
                withLoader(uiOutput(outputId = "output_cards"), type = "html", loader = "loader6")
              )
            )
          )
          
        )  
        
      ), # 2.2.4 PANEL END :Trending Repos ----
      
      # 2.3.0 PANEL START:Trending Developers ----
      tabPanel(
        title = "Trending Developers",
        
        # 2.3.1 CSS ----
        tags$head(
          tags$link(rel = "stylesheet", type = "text/css", href = "styles.css")
        ),
        
        # 2.3.2 JS ----
        shinyjs::useShinyjs(),
        
        # 2.3.4 Application UI ----
        div(
          id    = "application_ui_dev",
          class = "container",
          fluidRow(
            
            column(
              width =3,
              wellPanel(
                style= "background-color:#525f7f;",
                div(
                  id = "input-main-dev",
                  selectInputLang(inputId = "language_selection_dev",choices  = c("R", "Python", "JavaScript")),
                  selectInputTrend(inputId  = "trend_frequency_dev")
                ),
                div(
                  id = "input_buttons_dev",
                  actionButtonFind(inputId = "get_trending_dev"),
                )
              )
            ),
            
            # 2.3.5 Output Cards ----
            column(
              width =9, 
              div(
                id    = "cards-dev",
                withLoader(uiOutput(outputId = "output_dev_cards"), type = "html", loader = "loader6")
              )
            )
          )
        )
        
      ), # 2.3.6 PANEL END :Trending Developers ----
      
      # 2.4.0 PANEL START:Popular Projects ----
      tabPanel(
        title = "Popular Projects",
        
        # 2.4.1 CSS ----
        tags$head(
          tags$link(rel = "stylesheet", type = "text/css", href = "styles.css")
        ),
        
        # 2.4.2 JS ----
        shinyjs::useShinyjs(),
        
        # 2.4.3 Application UI ----
        div(
          id    = "application_ui_projects",
          class = "container",
          fluidRow(
            
            column(
              width =3,
              wellPanel(
                style= "background-color:#525f7f;",
                div(
                  id = "input-main-project",
                  selectInputLang(inputId  = "language_selection_project",choices  = c("R", "Python")),
                  selectInputProj(inputId  = "project_selection")
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
                  style = "width:max-content; color:aliceblue; font-family:sans-serif; font-size:15px; font-weight:bold;",
                  radioButtonsSort(inputId = 'var1', choices =  c("stars","forks"), selected = "stars")
                ) %>% hidden()
              )
            ),
            # 2.4.4 Output Cards ----
            column(
              width =9, 
              div(
                id    = "cards-project",
                withLoader(uiOutput(outputId = "output_project_cards"), type = "html", loader = "loader6")
              )
            )
          )
        )
      ),# 2.4.5 PANEL END:Popular Projects End ----
      
      # 2.5.0 PANEL START: About App ----
      tabPanel(
        title = "About",
        
        # 2.5.1 CSS ----
        tags$head(
          tags$link(rel = "stylesheet", type = "text/css", href = "styles.css")
        ),
        
        mainPanel(
          htmlOutput("instructions"),
          style="font-weight:100; font-size:initial;",
        ) #main Panel closed
        
      ) # 2.5.2 PANEL END: About App ----
    )
  )
)

# SERVER ----    
server <- function(input, output, session) {
  
  # Loader ----
  sever()
  Sys.sleep(2) #  something that takes time
  
  waiter_hide()
  
  
  # 1.0 Trending Repos ----
  
  # 1.1 Toggle Input Settings ----
  observeEvent(input$settings_toggle,{
    toggle(id = "input_settings", anim = TRUE)
  })
  
  
  # 1.2 Language Selection Repositories ----
  language <- eventReactive(input$get_trending,{
    input$language_selection
  }, ignoreNULL = FALSE)
  
  # 1.3 Trend Frequency Repositories ----
  trend_freq <- eventReactive(input$get_trending,{
    input$trend_frequency
  }, ignoreNULL = FALSE)
  
  
  # 1.4 Get Trending Repos ---- 
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
  
  # 1.5 Render Trending Repositories Cards ----
  output$output_cards <- renderUI({
    div(
      class = "row",
      style = "display:-webkit-flex; flex-wrap:wrap;",
      trending_repos() %>%  make_cards()
    )
  })
  
  # 2.0 Trending Developers
  
  # 2.1 Language Selection Developers ----
  language_dev <- eventReactive(input$get_trending_dev,{
    input$language_selection_dev
  }, ignoreNULL = FALSE)
  
  # 2.2 Trend Frequency Developers ----
  trend_freq_dev <- eventReactive(input$get_trending_dev,{
    input$trend_frequency_dev
  }, ignoreNULL = FALSE)
  
  # 2.3 Get Trending Developers ---- 
  trending_dev <- reactive({
    tr <- trending_developers_on_github(language = language_dev(), since = trend_freq_dev(),gtoken = gtoken)
    tr <- tibble::rowid_to_column(tr, "id")
    
  })
  
  # 2.4 Render Trending Developers Cards ----
  output$output_dev_cards <- renderUI({
    div(
      class = "row",
      style = "display:-webkit-flex; flex-wrap:wrap;",
      trending_dev() %>%  make_dev_cards()
    )
  })
  
  # 3.0 Popular Projects ----
  
  # 3.1 Toggle Input Settings ----
  observeEvent(input$settings_toggle_pro,{
    toggle(id = "input_settings_pro", anim = TRUE)
  })
  
  # 3.2 Project Selection ----
  project <- eventReactive(input$get_trending_pro,{
    input$project_selection
  }, ignoreNULL = FALSE)
  
  # 3.3 Language Selection Projects ----
  language_project <- eventReactive(input$get_trending_pro,{
    input$language_selection_project
  }, ignoreNULL = FALSE)
  
  
  # 3.4 Get Popular Projects ---- 
  trending_projects <- reactive({
    tr <- trending_projects_on_github(project = project(), language = language_project())
    # Sorting based on selection stars/forks
    if(input$var1 == "stars" | input$var1 == "forks") {
      tr <- tr[order(unlist(tr %>% pull(input$var1)), decreasing = TRUE),]
    } 
    tr <- tibble::rowid_to_column(tr, "id")
    
  })
  
  
  # 3.5 Render Trending Project Cards ----
  output$output_project_cards <- renderUI({
    div(
      class = "row",
      style = "display:-webkit-flex; flex-wrap:wrap;",
      trending_projects() %>%  make_project_cards()
    )
  })
  
  # 4.0 About App ----
  output$instructions <- renderUI({           
    includeMarkdown(knitr::knit(file.path("text", "about.md"))
    )           
  })
  
}    


# RUN APP ----
shinyApp(ui = ui, server = server)

