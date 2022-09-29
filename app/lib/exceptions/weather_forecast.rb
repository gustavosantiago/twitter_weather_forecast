# frozen_string_literal: true

module Exceptions
  class WeatherForecast < StandardError
    def to_s
      I18n.t("weather_forecast.#{self.class.to_s.underscore}")
    end
  end

  class EmptyOpenWeatherKeyException < WeatherForecast; end
  class EmptyCityException < WeatherForecast; end
end

