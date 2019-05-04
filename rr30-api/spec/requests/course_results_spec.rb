require 'rails_helper'

RSpec.describe 'CourseResults', type: :request do
  let!(:course_result1) { create(:course_result) }
  let!(:course_result2) { create(:course_result_day_ago) }
  let!(:course_result3) { create(:course_result_days_ago) }
  context 'GET course_results#index' do
    before do
      get courses_path
    end
    it 'should return json' do
      expect(response).to have_http_status(200)
      expect(response.content_type).to eq 'application/json'
    end

    it 'should return today courses' do
      res_attributes = JSON.parse(response.body)['data'].first['attributes']
      expect(res_attributes['created-at'])
        .to eq course_result1.created_at.strftime('%Y-%m-%dT%H:%M:%S.%LZ')
    end
  end

  context 'GET course_results#history' do
    before do
      get courses_history_path
    end
    it 'should return json' do
      expect(response).to have_http_status(200)
      expect(response.content_type).to eq 'application/json'
    end

    it 'should return courses history' do
      expect(JSON.parse(response.body)['data'].length).to eq 3
    end
  end
end
