namespace :moldiboard do
  desc "Creates a default dashboard with two default widgets for immediate enjoyment"
  task :install => :environment do
    Moldiboard::Utils.create_default_install!
  end
end
