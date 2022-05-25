
<!-- ABOUT THE PROJECT -->
# Viewing Party
## About This Project
*Viewing Party* is a rails web application in which users can explore movie options and create a viewing party event for themselves and include other users of the application. This repository is an extension of the *[Turing Viewing Party Lite Pair Project](https://backend.turing.edu/module3/projects/viewing_party_lite/index)* with additions of authentication, authorization, and session features. The Movie Database(TMDB) API endpoints are used to power movies searches and render various movie data to the user.
  
<p align="right">(<a href="#top">back to top</a>)</p>

## Navigating Production Site

<p alignt='center'>
<iframe width="560" height="315" src="https://www.youtube.com/embed/y1anydj-8lk" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</p>

1. Visit https://pure-earth-28237.herokuapp.com/
1. Register as a new user (can use dummy email) or log in as: `paco@email.com`, password: `paco`.
2. Emails of existing "users" that can be added as friends if registered as new user: `amy@email.com`, `jeff@email.com`, `paco@email.com`
3. To explore admin feature, log in as: `admin@email.com`, `password: admin`.

<p align="right">(<a href="#top">back to top</a>)</p>

## Features Implemented:

- [x] Pages
    - [x] Welcome page with links to Register/Login/Discover movies
    - [x] User Login page
    - [x] User registration page (*user authentication)
    - [x] User Dashboard with sections to add/view friends and view past/(and cancel/leave) upcoming viewing parties (*user authentication)
    - [x] Discover movie page(logged in or not) that allows movie searches by name or top 20
    - [x] Movie show page that displays movie title, runtime, genre, rating, summary, cast and review author and content.
    - [x] New Party page that allows user to start a viewing party (*user authentication, *custom validator for party duration)
    - [x] Admin dashboard that allows admin to view all users' email and creation date and view/delete any viewing parties (*admin authentication)
    - [x] Admin user page(via user email link on admin dashboard) that allows admin to view user's dashboard and delete upcoming parties for the user
- [x] Additional authentication/authorization
    - [x] Default login session is 1 week, once logged out, user is prompt to log in again before given access to dashboard related pages
    - [x] Default user only has access to their own dashboard related pages; they cannot view others' dashboard or access admin dashbord.
- [x] API Consumption
    - [x] Total of 5 API TMDB endpoints via API authentication consumed following facades, poros, services framework structure:
        - [x] Top20 movie search: 
          ```
          https://api.themoviedb.org/3/movie/top_rated
          ```
        - [x] Partial movie title search: 
          ```
          https://api.themoviedb.org/3/search/movie?&query=#{keyword}&page=#{page}
          ```
        - [x] Movie info search: 
          ```
          https://api.themoviedb.org/3/movie/#{movie_id}
          ```
        - [x] Movie cast search: 
          ```
          https://api.themoviedb.org/3/get_url("/movie/#{movie_id}
          ```
        - [x] Movie review search: 
          ```
          https://api.themoviedb.org/3/movie/#{movie_id}/reviews
          ```
API endpoints Reference: [The Movie Database](https://developers.themoviedb.org/3/getting-started/introduction)

<p align="right">(<a href="#top">back to top</a>)</p>

## Installation

1. Fork and/or Clone the repo 
  ```
  git clone git@github.com:kg-byte/viewing_party.git
  ```
2. Install gems and dependencies
  ```
   bundle install
  ```
3. Set up figaro to securely use API key
  ```
  bundle exec figaro install
  ```
4. To use the API services provided by TMDB, add the following line in the hidden `root/application.yml` file generated from step 3: 
  ```
   tmdb_api_key': '6a31677f95a3e6923d1ecd6e9b5fd07c
  ```
5. Setup and seed database
  ```
   rails db:create
   rails db:seed 
  ```
6. Run run test suit 
  ```
  bundle exec rspec
   ```

<p align="right">(<a href="#top">back to top</a>)</p>

## Built With

* [RoR Framework](https://rubyonrails.org/)
* [Bootstrap](https://getbootstrap.com)
* [Heroku Platform](https://dashboard.heroku.com/apps)
* [BCrypt](https://github.com/bcrypt-ruby/bcrypt-ruby)

<p align="right">(<a href="#top">back to top</a>)</p>

## Versions

- [Ruby 2.7.2](https://www.ruby-lang.org/en/news/2021/07/07/ruby-2-7-4-released/)
- [Rails 5.2.6](https://rubygems.org/gems/rails/versions/5.2.6)

<p align="right">(<a href="#top">back to top</a>)</p>

## Contributors
<p>
  <img src="https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white" />
</p>

[This Repository:](https://github.com/kg-byte/viewing_party)
- Author: [Kim Guo](https://www.linkedin.com/in/kim-guo-5331b4158/)


[Original Viewing Party Lite Repository:](https://github.com/AliciaWatt/viewing_party_lite)
- Co-Author: [Alicia Watt](https://www.linkedin.com/in/alicia-watt-3bb815225/)
- Co-Author: [Kim Guo](https://www.linkedin.com/in/kim-guo-5331b4158/)


<p>
  <img src="https://img.shields.io/badge/GitHub-100000?style=for-the-badge&logo=github&logoColor=white" />
</p>

[This Repository:](https://github.com/kg-byte/viewing_party)
- Author: [Kim Guo](https://github.com/kg-byte)


[Original Viewing Party Lite Repository:](https://github.com/AliciaWatt/viewing_party_lite)
- Co-Author: [Alicia Watt](https://github.com/AliciaWatt)
- Co-Author: [Kim Guo](https://github.com/kg-byte)

<p align="right">(<a href="#top">back to top</a>)</p>

## Acknowledgments

The soft search function is powered by the movie database API services:

* [The Movie Database](https://developers.themoviedb.org/3/getting-started/introduction)

<p align="right">(<a href="#top">back to top</a>)</p>


