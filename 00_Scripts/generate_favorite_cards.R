generate_favorite_card <-
    function(data){
        column(
            width = 3,
            info_card(
                repo_title = as.character(current_user_favorites)
            )
        )
        
    }
generate_favorite_cards <-
    function(favorites){
        
        favorites %>%
            
            # Step 5
            tagList()
        
    }
