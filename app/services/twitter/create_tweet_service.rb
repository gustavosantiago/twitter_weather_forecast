# frozen_string_literal: true

module Twitter
  class CreateTweetService
    attr_reader :api_key, :city, :language

    def initialize(api_key: '76885553ca7a137fe0ccbbeb63547a21', city:, language: 'pt-br')
      @api_key = api_key
      @city = city
      @language = language
    end

    def call
      create_tweet
    end

    private

    def create_tweet
      weather_result
    end

    def weather_result
      ::OpenWeatherClient::Handler.new(
        api_key: api_key,
        city: city,
        language: language
      ).call
    end
  end
end

