module DatabaseRepository
  class Engine < ::Rails::Engine
    config.eager_load_paths += %W(#{config.root}/app/repositories)
  end
end
