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
      create_tweet
    end

    private

    def create_tweet
      I18n.t("tweet.#{language}", city: city)
    end
  end
end

