require 'rails_helper'

RSpec.describe SourceProvider, type: :model do
  context 'validations' do
    it { should validate_presence_of(:name) }
    it { should_not allow_values('', ' ').for(:name) }
    it { should validate_presence_of(:url) }
    it { should_not allow_values('', ' ').for(:url) }
    it { should validate_presence_of(:address) }
    it { should_not allow_values('', ' ').for(:address) }
  end
end
