require 'rails_helper'

RSpec.describe User, type: :model do
  let!(:user) { create(:user) }
  context 'validations' do
    subject { create(:user) }
    it { is_expected.to validate_presence_of :first_name }
    it { should validate_presence_of(:last_name) }
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }
  end

  it 'should return full name' do
    expect(user.full_name).to eq "#{user.first_name} #{user.last_name}"
  end

  context 'before save' do
    before do
      @user = User.new(first_name: 'john',
                       last_name: 'doe',
                       email: 'Test@example.com')
    end

    it 'should call :downcase_email' do
      expect(@user).to receive(:downcase_email)
      @user.save
    end

    it 'should downcase email' do
      @user.save
      expect(@user.email).to eq 'test@example.com'
    end

    it 'should receive :capitalize_names' do
      expect(@user).to receive(:capitalize_names)
      @user.save
    end

    it 'should capitalize names' do
      @user.save
      expect(@user.first_name).to eq 'John'
      expect(@user.last_name).to eq 'Doe'
    end

    it 'should receive :generate_api_key' do
      expect(@user).to receive(:generate_api_key)
      @user.save
    end
  end

  context 'before validation' do
    context 'all names are blank' do
      before do
        @user = User.new(email: 'Test@example.com')
      end
      it 'should receive :generate_names' do
        expect(@user).to receive(:generate_names)
        @user.save
      end

      it 'should generate names' do
        @user.save
        expect(@user.first_name).not_to be_nil
        expect(@user.last_name).not_to be_nil
      end
    end

    context 'one of the name is blank' do
      it 'should raise error if first_name is blank' do
        @user = User.new(first_name: 'john', email: 'Test@example.com')
        expect(@user).not_to be_valid
        expect(@user.errors.messages[:last_name]).to eq ["can't be blank"]
      end

      it 'should raise error if last_name is blank' do
        @user = User.new(last_name: 'doe', email: 'Test@example.com')
        expect(@user).not_to be_valid
        expect(@user.errors.messages[:first_name]).to eq ["can't be blank"]
      end
    end
  end
end
