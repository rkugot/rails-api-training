class SourceProvidersController < JSONAPI::ResourceController
  def show
    render json: JSONAPI::ResourceSerializer.new(SourceProviderResource)
                                            .serialize_to_hash(
                                              SourceProviderResource.new(
                                                SourceProvider.find(
                                                  params[:id]
                                                ), nil
                                              )
                                            )
  end
end
