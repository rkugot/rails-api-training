class CourseResultsController < JSONAPI::ResourceController
  before_action :initialize_serializer

  def index
    course_results = CourseResult.where(created_at: Date.today.all_day)
    result = course_results.map { |cr| CourseResultResource.new(cr, nil) }
    render json: @serializer.serialize_to_hash(result)
  end

  def history
    course_results = CourseResult.order(created_at: :desc).limit(10)
    result = course_results.map { |cr| CourseResultResource.new(cr, nil) }
    render json: @serializer.serialize_to_hash(result)
  end

  private

  def initialize_serializer
    @serializer = JSONAPI::ResourceSerializer.new(CourseResultResource)
  end
end
