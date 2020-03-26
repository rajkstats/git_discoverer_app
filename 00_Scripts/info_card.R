info_card <- function(repo_name, repo_avatar,repo_link, main_icon = "chart-line",
                      bg_color = "default", text_color = "default") {
    
    div(
        class = "panel panel-default",
        style = "padding:0px;",
        div(
            class = str_glue("panel-body bg-{bg_color} text-{text_color}"),
            p(class = "pull-right", icon(class = "fa-4x", main_icon)),
            h4(class = "text-left",repo_name),
            #image
            tags$img(
                class="img-responsive left-block",
                style = "width:50%;border:none;",
                src   = repo_avatar
            ),
            br(),
            a(
                type   = "button",
                class  = "align-self-end btn btn-lg btn-block btn-primary",
                target = "_blank",
                href   = repo_link,
                "View Repo"
            ),
        )
    )
    
}


