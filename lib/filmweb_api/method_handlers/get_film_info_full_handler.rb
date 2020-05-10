require 'filmweb_api/services/make_filmweb_request'

class GetFilmInfoFullHandler
  REQUEST_ATTRIBUTES = [
    :movie_id
  ].freeze

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

  private_constant :RESPONSE_KEYS

  attr_reader :attributes, :movie_id

  def initialize(**attributes)
    @attributes = attributes
    @movie_id = attributes[:movie_id]
  end

  def call
    raise ArgumentError.new("You need to pass all required attributes for that method") unless all_required_attributes?
    Hash[RESPONSE_KEYS.zip(filmweb_response)]
  end

  private

  def all_required_attributes?
    REQUEST_ATTRIBUTES.all? { |sym| attributes.key?(sym) }
  end

  def filmweb_response
    @filmweb_response ||= MakeFilmwebRequest.new(method: "getFilmInfoFull", movie_id: movie_id).call
  end
end
