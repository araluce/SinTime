namespace :setup do

  desc "Deploying..."
  task :production do
    on roles(:all) do
      execute "gem install bundler"
    end
  end
end