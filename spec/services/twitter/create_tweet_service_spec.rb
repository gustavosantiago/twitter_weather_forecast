require 'rails_helper'

RSpec.describe Twitter::CreateTweetService do
  subject (:tweet) do
    described_class.new(open_weather_key: open_weather_key, city: city, language: language)
  end

  let(:city) { 'Brazil' }
  let(:open_weather_key) { 'abc@123' }
  let(:language) { 'pt-br' }

  describe 'when user request the tweet' do
    ['pt-br', 'en', 'es'].each do |language|
      context "when requires in #{language}" do
        let(:language) { language }

        it "returns a tweet in language" do
          expect(tweet.call).to eq(I18n.t("tweet.#{language}", city: city))
        end
      end
    end
  end

  describe 'when open_weather_key is null' do
    let(:open_weather_key) { nil }

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

