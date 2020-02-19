# Repository Stats

language <- "R"
since <- "Daily"

req <- GET(paste0("https://github-trending-api.now.sh/repositories?language=",language,"&since=",since), gtoken)

# Retreiving results from API
json <- content(req)
trending_repos<- jsonlite::fromJSON(jsonlite::toJSON(json)) %>% as_tibble()
trending_repos <-  trending_repos %>% select("author", "name","url", "description","avatar","stars", "forks", "builtBy", "languageColor")

trending_repos$url[[1]]

# open issues
# https://api.github.com/repos/hadley/dplyr/issues
# open issues
# https://api.github.com/repos/calthaus/ncov-cfr/issues

base <- "https://api.github.com/"
repo <- "hadley/dplyr"
paste0(base, "/repos/", repo, "/tags")


tag <- github_get(paste0(base, "/repos/", repo, "/tags"))
tag_names <- vapply(tag, function(x) x$name, character(1))
# closed issues


# Average Day to Close an Issue


# Open Pull Requests


# Average Days to Pull


# Issues by Status and Date (Open/Closed)


# Tags on Each Card

Sys.sleep(0.72)
tag <- github_get(paste0(base, "/repos/", repo, "/tags"))
tag_names <- vapply(tag, function(x) x$name, character(1))

#request will return the list of tags for the libgit2/libgit2 repository
# API for all releases 
# https://api.github.com/repos/tidyverse/dplyr/tags


# Lists all branches
# https://api.github.com/repos/tidyverse/dplyr/branches

# API for Gists Information
# https://developer.github.com/v3/gists/

# API for gists forks 
# https://gist.github.com/hadley
# https://api.github.com/gists/eb5c97bfbf257d133a7337b33d9f02d1/forks

# API for Repo Topics
# curl -H "Accept: application/vnd.github.mercy-preview+json" https://api.github.com/repos/twbs/bootstrap/topics

# Tags on Each Card
# tags_repo <- get_repo_tags("tidyverse","dplyr")

get_repo_tags <-  function(owner, repo){
    value <-"application/vnd.github.mercy-preview+json"
    base_url <- "https://api.github.com/repos/"
    repo_url <- str_glue(base_url,owner,"/",repo,"/topics")
    req <- GET(repo_url, add_headers(Accept = value))
    json <- content(req)
    tag_names <-  jsonlite::fromJSON(jsonlite::toJSON(json)) %>% as_tibble()
    return(tag_names)
}


