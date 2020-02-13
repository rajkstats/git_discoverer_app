# UI ----

favorites_ui <-  function(id, repo_name, repo_avatar, repo_link, main_icon = "chart-line",
                          bg_color = "default", text_color = "default") {
    ns <- NS(id)
    
    div(
        id    = ns("favorites"),
        class = "panel panel-default",
        style = "padding:0px;",
        div(
            class = str_glue("panel-body bg-{bg_color} text-{text_color}"),
            p(class = "pull-right", icon(class = "fa-4x", main_icon)),
            h4(class = "text-left",ns(repo_name)),
            #image
            tags$img(
                class="img-responsive left-block",
                style = "width:50%;border:none;",
                src   = ns(repo_avatar)
            ),
            br(),
            a(
                type   = "button",
                class  = "align-self-end btn btn-lg btn-block btn-primary",
                target = "_blank",
                href   = ns(repo_link),
                "View Repo"
            ),
        )
    )
}

validate_favorites <- function(input, output, session){
    
    
    eventReactive(input$favorites_add,{
        
        validate <- FALSE
        if(input$user_name == user && input$password == pwd){
            validate <- TRUE
        } 
        
        if(validate) shinyjs::hide(id = "login")
        
        validate
    })
}