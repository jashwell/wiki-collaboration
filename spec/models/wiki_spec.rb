require 'rails_helper'

RSpec.describe Wiki, type: :model do
  context 'ActiveRecord validations' do
    it 'validates the presence of a user' do
      is_expected.to validate_presence_of :user
    end
  end

end
