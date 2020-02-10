info_card <- function(repo_name, repo_avatar,desc,forks, stars, main_icon = "chart-line") {
    
    div(
        class = "panel panel-default",
        style = "padding: 0px;",
        div(
            class = "panel-body",
            h4(repo_name),
            h5(desc),
            p(class = "text text-default", forks, stars)
        )
    )
    
}


