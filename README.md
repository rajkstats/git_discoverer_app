# GitDiscoverer V2

- Add **Dev Trends** Page showing ds trends over time ( Use gganimate + highcharts for visualization)
- Popular **Deep Learning** and **Machine Learning** Projects Page - Done
- Info pop-up for Developer Stats
  - Average time to close Issue/ Average time to Close Pull Requests - **Developer page**
  - Comments , Commits, Stars, Forks, Pull Requests, Opened, PR Merged, Total Gists
  - User specific tab - User details as of now plus - No of commits - Languages - Language wise commits - Recommending             Repositories based on user profile
- Favorite Repos - [Refer Dynamic Shiny Modules](https://www.zstat.pl/2018/06/19/dynamic-modules-in-shiny---part-ii/)
- Welcome User method
- Landing Page
- Add repo [tags](https://developer.github.com/v3/git/tags/) on top of each card
- [Recommending Github Repositories](https://towardsdatascience.com/recommending-github-repositories-with-google-bigquery-and-the-implicit-library-e6cce666c77)
- User Report Card
  - Month Wise commits (Current Year)
  - Commits in Each Year
  - Repo wise Commits
- Add **pop up boxes** for info 
- Popular Gists By Developer
- Listing organisation all repositories including private ones
- Trending Docker Images by Language (R/Python)
- Predicting Topic Tags for a Repository

# Data (ToDo)

- write a bash script to pull hourly dumps of github logs and schedule it on airflow
- Activity for 1/1/2019 : wget http://data.gharchive.org/2019-01-01-{0..23}.json.gz
- Come up iwth Infra for the daily compute and cost of project
- Decide where to store this data (infrastructure / persistent database (sqlite))
- Explore [DataCache](https://github.com/jbryer/DataCache) for caching results in Shiny

# Done

- Added Cards for Trending Repos and Trending Developers
- Add Sort By Button: Stars and Forks
- Add a search bar which shows languages as you search (its no more data science specific)

# Shiny Widgets
- [Tell me Story](https://github.com/hadley/mastering-shiny/blob/master/neiss/narrative.R)

# Shiny Themes
- [DreamR](https://dreamrs.github.io/fresh/)
- [waiteR for Loading Screens](https://shiny.john-coene.com/waiter/)
- [seveR for Disconnected Screens](https://github.com/JohnCoene/sever)
- [argonDash](https://rinterface.com/shiny/argonDash/)

# Resources

- [GHArchive](http://www.gharchive.org/)
- [Visualising Git commits](https://deanattali.com/blog/visualize-git-commits-time/)
- [Trending Deep Learning Repos](https://www.kdnuggets.com/2019/02/trending-top-deep-learning-github-repositories.html)
- [Github Analyses](https://mytinyshinys.shinyapps.io/githubAnalyses/)
- [Visualize your Github Repository](https://www.boldbi.com/blog/analyze-and-visualize-your-github-repository-statistics-data)
- [Github Analytics](https://keen.io/docs/integrations/github/)
- [Github Dashboard](http://shinyapps.dreamrs.fr/github-dashboard/)
- [Github Analysis - Python](https://towardsdatascience.com/github-user-insights-using-github-api-data-collection-and-analysis-5b7dca1ab214)

