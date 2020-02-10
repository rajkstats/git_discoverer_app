get_stock_mavg_info <-
    function(data){
        
        n_short <- data %>% pull(mavg_short) %>% is.na() %>% sum() + 1
        n_long <- data %>% pull(mavg_long) %>% is.na() %>% sum() + 1
        
        data %>%
            tail(1) %>%
            mutate(mavg_warning_flag = mavg_short < mavg_long) %>%
            mutate(
                n_short = n_short,
                n_long  = n_long,
                pct_chg = (mavg_short - mavg_long)/ mavg_long
            )
    }
generate_favorite_card <-
    function(data){
        column(
            width = 3,
            info_card(
                repo_title = as.character(data$stock)
            )
        )
        
    }
generate_favorite_cards <-
    function(favorites){
        
        favorites %>%
            
            # Step 5
            tagList()
        
    }
