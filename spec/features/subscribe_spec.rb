require 'rails_helper'

  feature 'Subscribe button', js: true do

    scenario 'unsubscribe from a question' do
      visit question_path

      check('#subscribe-checkbox')

      sleep(1)

      expect(question.notification_settings.last.send_emails).to eq(false)


    end
  end
