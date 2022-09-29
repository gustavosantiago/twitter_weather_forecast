require 'rails_helper'

RSpec.describe Twitter::CreateTweetService do
  subject (:tweet) do
    described_class.new(open_weather_key: 'abc@123', city: city, language: language)
  end

  let(:city) { 'Brazil' }

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
end

