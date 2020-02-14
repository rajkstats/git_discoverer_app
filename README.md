# GitDiscoverer V2

- Add **Dev Trends** Page showing ds trends over time ( Use gganimate + highcharts for visualization)
- Popular **Deep Learning** and **Machine Learning** Projects Page
- Average time to close Issue/ Average time to Close Pull Requests - **Developer page**
- User specific tab - User details as of now plus - No of commits - Languages - Language wise commits - Recommending Repositories based on user profile
- Favorite Repos - [Refer Dynamic Shiny Modules](https://www.zstat.pl/2018/06/19/dynamic-modules-in-shiny---part-ii/)
- Welcome User method
- Landing Page

# Data (ToDo)

- write a bash script to pull hourly dumps of github logs and schedule it on airflow
- Activity for 1/1/2019 : wget http://data.gharchive.org/2019-01-01-{0..23}.json.gz
- Come up iwth Infra for the daily compute and cost of project
- Decide where to store this data (infrastructure / persistent database (sqlite))

# Done

- Added Cards for Trending Repos and Trending Developers
- Add Sort By Button: Stars and Forks
- Add a search bar which shows languages as you search (its no more data science specific)


# Resources

- [GHArchive](http://www.gharchive.org/)
- [Visualising Git commits](https://deanattali.com/blog/visualize-git-commits-time/)
