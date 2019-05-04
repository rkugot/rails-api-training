namespace :course_results do
  desc 'Fetch course results from nbrb'
  task fetch: :environment do
    source_provider = SourceProvider.find_by(name: 'nbrb')
    source_provider.update(last_sync_at: Time.now)
    conn = Faraday.new(source_provider.url)
    course_results = {}
    %w[usd eur rub].each do |currency|
      course_results[currency] = JSON.parse(conn.get("#{currency}?ParamMode=2")
                                     .body)['Cur_OfficialRate']
    end
    CourseResult.create(
      usd: course_results['usd'],
      eur: course_results['eur'],
      rur: course_results['rub']
    )
  end
end
