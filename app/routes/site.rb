class Main
  get "/" do
    @redis = monk_settings(:redis)
    haml :home
  end
end
