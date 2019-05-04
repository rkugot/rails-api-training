module Api
  class SourceProvidersController < Api::BaseController
    def index
      render json: MyApi::SourceProvider.all
    end

    def show
      source_provider = MyApi::SourceProvider.find(params[:id])
      if source_provider.first['active']
        render json: source_provider
      else
        render json: { error: 'This Source Provider is not active' }
      end
    end
  end
end
