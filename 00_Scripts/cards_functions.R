
make_tags <- function(data) {
  data %>%
    mutate(tag = as_factor(tag)) %>%
    group_by(tag) %>%
    group_split() %>%
    
    map(.f = function(data){
      span(class = str_glue("label label-success"), data$tag, style="min-height: 10; max-height: 10;overflow-y: scroll;")
    }) %>%
    
    tagList()
}


# Make Repository Cards ----
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
                    
          
                    #For Adding tags on cards ----
                    if(nrow(data %>% pluck("tags",1))!=0) {
                      div(
                        class = "panel-heading",
                        data %>% pluck("tags",1) %>% make_tags()     
                    )},
                    div(
                        class = "panel-body",
                        style = "padding:20px;",
                        
                        # image
                        tags$img(
                          class = "img-fluid img-thumbnail img-size",
                          style = "width:100%;height:auto;border:none;",
                            src   = data$avatar
                        ),
                        
                        br(), br(),
                        tags$h4(
                            data$name,
                            style = "font-size: 18px; font-weight: bold; text-overflow:ellipsis; color: currentColor;"
                        ),
                        div(
                        class = "crop",
                        style = "display: block; display: -webkit-box;max-width: 200px; -webkit-line-clamp: 4; -webkit-box-orient: vertical;overflow: hidden;text-overflow: ellipsis; font-family: monospace;",
                        p(data$description)
                        ),
                        br(),
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

# Make Developer Cards ----

make_dev_cards <- function(data) {
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
                    div(
                        class = "panel-body",
                        style = "padding:20px; word-break:break-all;",
                        
                        # image
                        tags$img(
                            class = "img-fluid img-thumbnail img-size",
                            style = "width:100%;height:auto;border:none;",
                            src   = data$avatar
                        ),
                        
                        br(),
                        # Developer Name
                        a(
                            type   = "button",
                            data$name,
                            href = data$url,
                            style = "font-size: 18px; font-weight: bold; text-overflow:ellipsis;"
                        ),
                        br(),
                        # Repo Name
                        a(
                        span(class = "glyphicon glyphicon-folder-close fa-fw"),   
                        style = "color: currentColor;"
                        ),
                        a(
                            type   = "button",
                            data$repo_name,
                            href = data$repo_url,
                            style = "font-size: 18px; font-weight: bold; text-overflow:ellipsis;"
                        ),
                        # Repo Description
                        div(
                          class = "crop",
                          style = "display: block; display: -webkit-box;max-width: 200px; -webkit-line-clamp: 4; -webkit-box-orient: vertical;overflow: hidden;text-overflow: ellipsis; font-family: monospace;",
                          p(data$repo_desc)
                        ),

                    ),
                    
                )
            )
        }) %>%
        
        tagList()
}

# Make Project Cards ---- 
make_project_cards <- function(data) {
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
                    #For Adding tags on cards ----
                    if(nrow(data %>% pluck("tags",1))!=0) {
                      div(
                        class = "panel-heading",
                        data %>% pluck("tags",1) %>% make_tags()     
                      )},
                    div(
                        class = "panel-body",
                        style = "padding:20px; word-break:break-all;",
                        
                        # image
                        tags$img(
                          class = "img-fluid img-thumbnail img-size",
                          style = "width:100%;height:auto;border:none;",
                            src   = data$avatar
                        ),
                        
                        br(),
                        # Repo Name
                            tags$h4(
                                data$repo_name,
                                style = "font-size: 18px; font-weight: bold; text-overflow:ellipsis; color: currentColor;display:block;"
                            ),
    
                        # Repo Description
                        div(
                          class = "crop",
                          style = "display: block; display: -webkit-box;max-width: 200px; -webkit-line-clamp: 4; -webkit-box-orient: vertical;overflow: hidden;text-overflow: ellipsis; font-family: monospace;",
                          p(data$repo_desc)
                        ),
                        br(),
                        a(
                            type   = "button",
                            class  = "btn btn-primary",
                            target = "_blank",
                            href   = data$repo_url,
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

