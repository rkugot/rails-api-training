module MyApi
  # this is an "abstract" base class that
  class Base < JsonApiClient::Resource
    # set the api base url in an abstract base class
    self.site = 'http://localhost:3030/'
  end

  class User < Base
    self.site = 'http://localhost:3040/'
  end

  class SourceProvider < Base
    def self.table_name
      'source-providers'
    end
  end

  class CourseResult < Base
    def self.table_name
      'courses'
    end
  end

  class CourseResultHistory < Base
    def self.table_name
      'courses/history'
    end
  end
end
