# frozen_string_literal: true
module OpenWeatherClient
  class Handler
    attr_reader :api_key, :city, :ow_client, :language

    def initialize(api_key:, city:, language:)
      @api_key = api_key
      @city = city
      @language = language
    end

    def call
      empty_api_key_exception unless api_key.present?
      empty_city_exception unless city.present?

      binding.pry

      data = ow_client.current_weather(city: city)

      I18n.t("current_weather.#{language}",
        temp: data.main.temp,
        city: data.name,
        temp_min: data.main.temp_min,
        temp_max: data.main.temp_max,
        feels_like: data.main.feels_like,
        date_time: data.dt.in_time_zone('America/Sao_Paulo').strftime('em %d/%m/%Y às %H:%m')
      )
    end

    private

    def ow_client
      @ow_client ||= OpenWeather::Client.new(
        api_key: api_key, units: 'metric'
      )
    end

    def empty_api_key_exception
      raise Exceptions::EmptyOpenWeatherKeyException
    end

    def empty_city_exception
      raise Exceptions::EmptyCityException
    end
  end
end