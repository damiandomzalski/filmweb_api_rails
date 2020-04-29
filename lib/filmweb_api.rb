require 'digest/md5'
require 'json'
require 'rest-client'
require 'csv'
require 'rails'
require 'active_support'
require 'active_support/core_ext'
require 'filmweb_api/method_handlers/get_film_info_full_handler'
# require 'pry'

class FilmwebApi
  HEADERS = {
    content_type: 'application/json',
    accept: 'application/json',
    user_agent: 'Mozilla/5.0 (iPhone; CPU iPhone OS 11_0 like Mac OS X) AppleWebKit/604.1.38 (KHTML, like Gecko) Version/11.0 Mobile/15A372 Safari/604.1'
  }.freeze
  API_VERSION = "1.0".freeze
  API_URL = "https://ssl.filmweb.pl/api?".freeze
  API_KEY = "qjcGhW2JnvGT9dfCt3uT_jozR3s".freeze
  APP_PLATFORM = "android".freeze

  private_constant :HEADERS, :API_VERSION, :API_KEY, :API_URL, :APP_PLATFORM

  attr_reader :method, :movie_id

  def initialize(method:, movie_id:)
    @method = method
    @movie_id = movie_id
  end

  def get
    raise ArgumentError.new("Method and movie_id needs to be passed") unless method.present? && movie_id.present?
    movie_details
  end

  private

  def request_params
    {
      version: API_VERSION,
      appId: APP_PLATFORM,
      methods: "#{method} [#{movie_id}]\\n",
      signature: generate_signature
    }
  end

  def movie_details
    @movie_details = Hash[GetFilmInfoFullHandler::RESPONSE_KEYS.zip(cleaned_body)]
  end

  def cleaned_body
    @cleaned_body = brackets_data_from_response.parse_csv
  end

  def brackets_data_from_response
    raise ActionController::RoutingError, 'Not Found' unless api_response_body[/\[.*?\]/].present?
    api_response_body[/\[.*?\]/].tr('[]', '')
  end

  def generate_signature
    action_request = method + " [#{movie_id}]"  + "\\n" + APP_PLATFORM + API_KEY
    API_VERSION + "," + Digest::MD5.hexdigest(action_request)
  end

  def api_response_body
    @api_response_body ||= RestClient.get(API_URL, params: request_params, headers: HEADERS).body
  end
end

### Available Filmweb methods
# getFilmInfoFull
