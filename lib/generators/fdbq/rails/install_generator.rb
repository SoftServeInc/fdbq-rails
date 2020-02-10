require 'rails/generators/migration'

module Fdbq
  module Rails
    module Generators
      class InstallGenerator < ::Rails::Generators::Base
        include ::Rails::Generators::Migration

        source_root File.expand_path("../../../templates", __FILE__)

        desc "This generator creates a plugin configuration files and a migration"

        class << self
          def next_migration_number(dirname)
            if ActiveRecord::Base.timestamped_migrations
              Time.now.utc.strftime("%Y%m%d%H%M%S")
            else
              "%.3d" % (current_migration_number(dirname) + 1)
            end
          end
        end

        def copy_config
          template "fdbq.yml", "config/fdbq.yml"
        end

        def copy_migration
          migration_template "create_fdbq_feedback.rb", "db/migrate/create_fdbq_feedback.rb"
        end

        def copy_initializer
          template "fdbq.rb", "config/initializers/fdbq.rb"
        end

        def copy_locales
          template "fdbq.en.yml", "config/locales/fdbq.en.yml"
        end
      end
    end
  end
end
