Digipolitan fastlane-heroku
================

Heroku actions used to deploy on Heroku using fastlane

## Installation
To install fastlane, simply use gem:

```
[sudo] gem install fastlane
```

# Available Fastlane Lanes
All lanes available are described [here](fastlane/README.md)

# Available Fastlane actions

All these actions require Heroku-CLI installed on your machine, download [here](https://devcenter.heroku.com/articles/heroku-cli)

## [heroku_login](fastlane/actions/heroku_login.rb)

Log the given user on Heroku

```Ruby
user = heroku_login(
  email: "you@email.com",
  password: "your_password"
)
print user[:token]
```
This command log `you@email.com` on Heroku and display his token

## [heroku_app_create](fastlane/actions/heroku_app_create.rb)

Creates or retrieves a new app on Heroku, the user must be logged in

```Ruby
heroku_app_create(
  name: "my_heroku_app"
)
```
Create `my_heroku_app` on your *Personal team* on Heroku

```Ruby
heroku_app_create(
  name: "my_heroku_app",
  organization: "Digipolitan"
)
```
Create `my_heroku_app` on *Digipolitan team* on Heroku, required admin permission

## [heroku_app_deploy](fastlane/actions/heroku_app_deploy.rb)

Deploy an app on Heroku from a git repository, required admin permission

```Ruby
heroku_app_deploy(
  name: "my_heroku_app",
  source_git_url: "https://github.com/fastlane/boarding"
)
```
Deploy on Heroku using source from `https://github.com/fastlane/boarding`
