module DatabaseRepository
  module Generators
    class RepositoryGenerator < Rails::Generators::Base
      source_root File.expand_path('../templates', __FILE__)
      argument :repository_name, type: :string

      def create_repository_file
        template 'repository.rb', File.join('app', 'repositories', "#{repository_name.underscore}_repository.rb")
      end
    end
  end
end
