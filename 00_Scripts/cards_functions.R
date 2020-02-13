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
                            style = "font-size: 18px; font-weight: bold; text-overflow:ellipsis; color: currentColor;"
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
                    #  div(
                    #      class = "panel-heading",
                    #      span(class = "label label-info", "AWS")
                    # ),
                    div(
                        class = "panel-body",
                        style = "padding:20px; word-break:break-all;",
                        
                        # image
                        tags$img(
                            class = "img-fluid img-thumbnail",
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
                        p(data$repo_desc),
                        # a(
                        #     type   = "button",
                        #     class  = "btn btn-primary",
                        #     target = "_blank",
                        #     href   = data$url,
                        #     "View Repo"
                        # ),
                        # # Github Stars
                        # div(
                        #     class = "btn btn-default btn-sm pull-right",
                        #     span(class = "glyphicon glyphicon-star", data$stars)
                        # ),
                        # # Github Forks
                        # div(
                        #     class = "btn btn-default  btn-sm pull-right",
                        #     span(class = "fas fa-code-branch", data$forks)
                        # ),
                        # 
                    ),
                    
                )
            )
        }) %>%
        
        tagList()
}


