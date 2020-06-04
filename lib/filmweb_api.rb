require 'csv'
require 'active_support/all'
require 'filmweb_api/method_handlers/get_film_info_full_handler'

class FilmwebApi
  attr_reader :method, :attributes

  def initialize(method:, **attributes)
    @method = method
    @attributes = attributes
  end

  def get
    raise ArgumentError.new("Passed method not supported") unless method_defined?
    raise ArgumentError.new("You need to pass all required attributes for that method") unless correct_attributes_for_method?
    method_handler.new(attributes.slice(*method_handler::REQUEST_ATTRIBUTES)).call
  end

  private

  def method_defined?
    defined?(method_handler) == "method"
  end

  def correct_attributes_for_method?
    method_handler::REQUEST_ATTRIBUTES.all? { |sym| attributes.key?(sym) }
  end

  def method_handler
    "#{method.slice(0,1).capitalize + method.slice(1..-1)}Handler".constantize
  end
end
