require 'rails_helper'

RSpec.describe Twitter::CreateTweetService do
  subject (:tweet) do
    described_class.new(api_key: api_key, city: city, language: language)
  end

  let(:city) { 'Brazil' }
  let(:api_key) { 'abc@123' }
  let(:language) { 'pt-br' }
  let(:open_weather_double) { double(OpenWeather::Client, current_weather: open_weather_response) }
  let(:open_weather_response) do
    {
      "coord"=>{
        "lon"=>-38.5247, "lat"=>-3.7227
      },
      "main"=>{
        "temp"=>31.07,
        "feels_like"=>32.94,
        "temp_min"=>27.34,
        "temp_max"=>31.07,
        "pressure"=>1013,
        "humidity"=>51
      },
      "name"=>"Fortaleza"
    }
  end

  describe 'when user request the tweet' do
    before do
      allow(OpenWeather::Client).to receive(:new).and_return(open_weather_double)
    end

    ['pt-br', 'en', 'es'].each do |language|
      context "when requires in #{language}" do
        let(:language) { language }

        it "returns a tweet in language" do
          expect(tweet.call).to eq(I18n.t("tweet.#{language}", city: city))
        end
      end
    end
  end

  describe 'when api_key is null' do
    let(:api_key) { nil }

    it 'raises Exceptions::EmptyOpenWeatherKeyException error' do
      expect { subject.call }.to raise_error(Exceptions::EmptyOpenWeatherKeyException)
    end
  end

  describe 'when city is null' do
    let(:city) { nil }

    it 'raises Exceptions::EmptyCityException error' do
      expect { subject.call }.to raise_error(Exceptions::EmptyCityException)
    end
  end
end

