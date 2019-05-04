class AddActiveToSourceProvider < ActiveRecord::Migration[5.1]
  def change
    add_column :source_providers, :active, :boolean, default: true
  end
end
