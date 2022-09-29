# frozen_string_literal: true

module Twitter
  class CreateTweetService
    attr_reader :open_weather_key, :city, :language

    def initialize(open_weather_key:, city:, language: 'pt-br')
      @open_weather_key = open_weather_key
      @city = city
      @language = language
    end

    def call
      empty_open_weather_key_exception unless open_weather_key.present?
      empty_city_exception unless city.present?

      create_tweet
    end

    private

    def create_tweet
      I18n.t("tweet.#{language}", city: city)
    end

    def empty_open_weather_key_exception
      raise Exceptions::EmptyOpenWeatherKeyException
    end

    def empty_city_exception
      raise Exceptions::EmptyCityException
    end
  end
end

