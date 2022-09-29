# frozen_string_literal: true

module Api
  module V1
    class WeatherForecastsController < ApplicationController
      def tweet
        render json: {
          data: { message: 'hello twitter' }
        }, status: :ok
      end

      private

      def tweet_params
        params.permit!(:open_weather_key, :city, :language)
      end
    end
  end
end

