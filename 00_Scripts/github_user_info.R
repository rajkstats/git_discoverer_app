# github_user_info() function returns the information of given user using Github API

github_user_info <- function(username, gtoken,d){

   # strips all whitespaces from inputs given by user if any  
   username <- str_replace_all(string=username, pattern=" ", repl="")
  
  # assign default users i.e influencers if there is no input
  if(username == "")
    username <- "hmason,hadley,rasbt,rhiever,mbostock,prakhar1989,amueller,AllenDowney,mdancho84,jph00,bcaffo,rdpeng"
  else  
    username <- username

  info_list <- list()
  j <- 1
  
  # Checks from where input is coming from and applies the following
  if(d==0)
    username<- unlist(strsplit(username, split=","))
  
  for(i in username){  
    
    # User Info ----
    # Use API
    req <- GET(paste0("https://api.github.com/users/", i), gtoken)
    # Extract content from a request
    json1 <- content(req)
    info <- jsonlite::fromJSON(jsonlite::toJSON(json1))
    info <- info[c('name','company', 'blog', 'location','public_repos',
                   'followers', 'following','html_url','avatar_url')] 
    info <- as_tibble(cbind(Attributes = names(info), t(info)))
    info$name <- paste0('<a href="',info$html_url,'">',info$name ,"</a>")
    info$blog <- paste0('<a href="',info$blog,'">',info$blog ,"</a>")
    info <- info[c(2:10)]
    info <- lapply(info, gsub, pattern = "list()", replacement = "", fixed = TRUE)
    info_list[[j]] <- info
    j <- j+1
  }
  
  user_info <- ldply(info_list, data.frame)
  colnames(user_info) <- c('Name' ,'Company', 'Blog', 'Location','Public Repositories',
                           'Followers', 'Following','html_url','Avatar_Url')
  user_info[,c(5,6,7)] <- sapply(user_info[,c(5,6,7)], FUN=function(x) prettyNum(x, big.mark=","))
  
  return(user_info)
}