class SourceProviderResource < JSONAPI::Resource
  attributes :name, :url, :address, :last_sync_at, :active

  filter :active, default: true
end
