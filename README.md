# filmweb_api_gem
[In progress] Filmweb.pl unofficial API client

## Currently available methods:
```
getFilmInfoFull
```

## Install
Since this gem is not published yet, you need to clone this repository to your local machine and add following code to your `Gemfile`
`gem 'filmweb_api', path: '~/path/to/filmweb_api_gem'`

simply run 

`bundle install`

and add this line to file in which you want to use FilmwebApi
`require 'filmweb_api'` 

## Usage
Once you've installed gem, you are able to use FilmwebApi class. To send a request to Filmweb.pl create an instance of FilmwebApi with `method:` and `movie_id:` params
```
FilmwebApi.new(method: <filmweb_api_method>, movie_id: <movie_id>).get
```
The response is a hash of full movie info, it contains: 

```
class GetFilmInfoFullHandler
  RESPONSE_KEYS = [
    :title,
    :originalTitle,
    :avgRate,
    :votesCount,
    :genres,
    :year,
    :duration,
    :commentsCount,
    :forumUrl,
    :hasReview,
    :hasDescription,
    :imagePath,
    :video,
    :premiereWorld,
    :premiereCountry,
    :filmType,
    :seasonsCount,
    :episodesCount,
    :countriesString,
    :desciption
  ].freeze
end
```

## Example
```
 > FilmwebApi.new(method: "getFilmInfoFull", movie_id: 107404).get
 => {:title=>"Piraci z Karaibów: Skrzynia umarlaka", :originalTitle=>"Pirates of the Caribbean: Dead Man's Chest", :avgRate=>"7.7566957", :votesCount=>"406224", :genres=>"Fantasy,Przygodowy", :year=>"2006", :duration=>"150", :commentsCount=>"0", :forumUrl=>"https://www.filmweb.pl/film/Piraci+z+Karaib%C3%B3w%3A+Skrzynia+umarlaka-2006-107404/discussion", :hasReview=>"1", :hasDescription=>"1", :imagePath=>"/74/04/107404/7518098.2.jpg", :video=>"null", :premiereWorld=>"2006-06-24", :premiereCountry=>"2006-07-21", :filmType=>"0", :seasonsCount=>"0", :episodesCount=>"0", :countriesString=>"USA", :desciption=>"Jack Sparrow musi spłacić dług zaciągnięty wobec kapitana Latającego Holendra. Uniknie śmierci, gdy znajdzie i zniszczy serce Davy'ego Jonesa ukryte w Skrzyni Umarlaka."}
 
 > FilmwebApi.new(method: "getFilmInfoFull", movie_id: 107404).get[:title]
 => "Piraci z Karaibów: Skrzynia umarlaka"
 ```
