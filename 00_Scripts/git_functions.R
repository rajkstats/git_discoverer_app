# FUNCTIONS ----

get_symbol_from_user_input <-
    function(user_input){
        user_input  %>% pluck(1,1) 
    }

github_app_auth <- function() {
    
    # Can be github, linkedin etc depending on application
    oauth_endpoints("github")
    
    # Change based on what you
    app <- oauth_app(appname = "Rshinycontest",
                     key = "4938920f10b0889d440f",
                     secret = "0fda89a95c741ce903fcacee66d3c09d2730ee15")
    
    # Get OAuth credentials
    github_token <- oauth2.0_token(oauth_endpoints("github"), app)
    # gtoken is global environment    
    gtoken <<- config(token = github_token)
    
}

# trending_github_repos() function returns the daily/weekly/monthly trending repos in selected language respectively using unofficial github trending API

trending_repos_on_github <- function(language, since, gtoken) {

    req <- GET(str_glue("https://github-trending-api.now.sh/repositories?language=",language,"&since=",since), gtoken)
    
    # Retreiving results from API
    json <- content(req)
    trending_repos<- jsonlite::fromJSON(jsonlite::toJSON(json)) %>% as_tibble()
    #trending_repos$name <- str_glue('<a href="{trending_repos$url}">{trending_repos$name}"</a>"')
    trending_repos <-  trending_repos %>% select("author", "name","url", "description","avatar","stars", "forks", "builtBy", "languageColor")
    return(trending_repos)
    
}

# trending_github_dev() function returns the daily/weekly/monthly trending developers in selected language using unofficial github trending API


trending_developers_on_github <- function(language,since,gtoken){
    req <- GET(paste0("https://github-trending-api.now.sh/developers?language=",language,"&since=",since), gtoken)
    json <- content(req)
    trending_dev <- jsonlite::fromJSON(jsonlite::toJSON(json)) %>% as_tibble() 
    trending_dev <- data.table(username = trending_dev$username,name = trending_dev$name,url = trending_dev$url,avatar = trending_dev$avatar,repo_name = trending_dev$repo$name,repo_desc = trending_dev$repo$description,repo_url = trending_dev$repo$url,stringsAsFactors = TRUE)
    
    #checks whether any developer name is NULL, then replace by username
    pos <- which(trending_dev$name == 'NULL')
    ifelse(length(pos) > 0,trending_dev$name[pos]<- trending_dev$username[pos],"")
    
    #trending_dev$name <- paste0('<a href="',trending_dev$url,'">',trending_dev$username ,"</a>")
    #trending_dev$repo_name <- paste0('<a href="',trending_dev$repo_url,'">',trending_dev$repo_name ,"</a>")
    #trending_dev$avatar<- paste0('<img src="',trending_dev$avatar,'" height="52"></img>')
    #trending_dev <- trending_dev[,c(4,2,5,6)]
    #colnames(trending_dev) <- c("Developer","Name","Repository","Description")
    
    return(trending_dev)
}

# Github Trending Deep Learing Projects -----
#https://api.github.com/search/repositories?q=deep-learning OR CNN OR RNN OR "convolutional neural network" OR "recurrent neural network"&sort=stars&order=desc

# Github Trending Machine Learning Projects  ----
#https://api.github.com/search/repositories?q=machine-learning OR "ml" OR "machine learning"+lnaguage:R&sort=stars&order=desc

trending_projects_on_github <- function(project, language) {
    
    if(project == "dl") {
        search_q <- 'deep-learning OR CNN OR RNN OR "convolutional neural network" OR "recurrent neural network"'
    } else if(project == "ml") {
        search_q <- 'machine-learning OR ml'
    } 
    
    filter <- '&sort=stars&order=desc'
    
    url <- modify_url("https://api.github.com", path = "search/repositories", query = list(q = search_q))

    # modified url
    m_url <- str_glue(url,"+language:",language,filter, collapse ="")
    
    req<- GET(m_url)
    
    if(status_code(req)!=200){
        print("Error in Request")
    }
        
    #length(content(req)$items)
    
    json <- content(req)
    
    #str(json, max.level = 1)   
    
    good_stuff <- json %>% 
        as_tibble() %>%
        flatten() 
    
    # extracting relevant columns
    df <- good_stuff %>%
        pull(items) %>%
        map_df(`[`, c( "name", "html_url", "description","stargazers_count", "forks" ,"language"))
    

    # changing column names for convenience
    colnames(df) <- c("repo_name", "repo_url", "repo_desc","stars","forks", "language")
    
    # gets repo avatar and user type (user/org)
    dt <-  good_stuff %>% 
        pull(items) %>%
        map_df(`[[`, c("owner"))
    
    result <- data.table(df,avatar = dt$avatar_url, user_type = dt$type )
    
    return(result)
    
}



