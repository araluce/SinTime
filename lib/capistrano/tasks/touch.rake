namespace :deploy do
  desc "Reinicia aplicacion"
  task :restart do
    on roles(:all) do
      execute "touch #{ current_path }/tmp/restart.txt"
    end
  end
end