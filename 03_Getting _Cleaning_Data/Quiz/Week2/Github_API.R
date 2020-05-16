library(httr)
library(httpuv)
library(jsonlite)

# Can be github, linkedin etc depending on application
oauth_endpoints("github")

# Change based on your appname, key, and secret 
myapp <- oauth_app(appname = "Rajaram Github",
                   key = "77861ba6b35d54651e73",
                   secret = "a6e7c31e1e9000766302966cfad097933c50baac")

# Get OAuth credentials
github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)

# Use API
gtoken <- config(token = github_token)
req <- GET("https://api.github.com/users/jtleek/repos", gtoken)

# Take action on http error
stop_for_status(req)

# Extract content from a request
json1 = content(req)

# Convert to a data.frame
git_DF = fromJSON(toJSON(json1))

# Retrive from DF
git_DF[git_DF$full_name =="jtleek/datasharing","created_at"]
