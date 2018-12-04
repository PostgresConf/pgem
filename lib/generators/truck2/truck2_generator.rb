class Truck2Generator < Rails::Generators::Base
  source_root File.expand_path('../templates', __FILE__)

  def scaffold_legacy
    # p 'working'
    empty_directory 'app/models/legacy/'
    copy_file "legacy_base.rb", "app/models/legacy/legacy_base.rb"

    @legacy_models = Dir.glob('./app/models/*.rb').collect { |model_path| File.basename(model_path).gsub('.rb', '') }
    @legacy_models.each do |model_name|
      model_path = "app/models/legacy/legacy_#{model_name.downcase}.rb"
      model_assigns =  { :model_name => model_name }
      # p model_assigns
        template 'legacy_model.erb', model_path, model_assigns
  end

  empty_directory 'lib/tasks'
    template 'legacy_task.erb', 'lib/tasks/legacy.rake', { :legacy_models => @legacy_models }

  snippet = <<EOS

# change this to point to your actual database
legacy:
  adapter: pg
  database: #{Rails.root.split.last}_legacy
  encoding: utf8
  username:
  password:
EOS
  append_file "config/database.yml", snippet

  snippet = 'Osem::Application.config.autoload_paths += %W( #{Rails.root}/app/models/legacy )'
  append_file "config/initializers/add_legacy_models.rb", snippet
  end

end
