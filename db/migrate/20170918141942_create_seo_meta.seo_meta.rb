# This migration comes from seo_meta (originally 20110329222114)
if Gem.loaded_specs["activerecord"].version >= Gem::Version.new('5.0')
  class CreateSeoMeta < ActiveRecord::Migration[4.2]; end
else
  class CreateSeoMeta < ActiveRecord::Migration; end
end

CreateSeoMeta.class_eval do
  def self.up
    create_table :seo_meta do |t|
      t.integer :seo_meta_id
      t.string :seo_meta_type

      t.string :browser_title
      t.string :meta_keywords
      t.text :meta_description

      t.timestamps :null => false
    end

    add_index :seo_meta, :id
    add_index :seo_meta, [:seo_meta_id, :seo_meta_type], :name => :id_type_index_on_seo_meta
  end

  def self.down
    drop_table :seo_meta
  end

end
