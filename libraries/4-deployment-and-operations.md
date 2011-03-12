!SLIDE 

# Deployment & Operations #

!SLIDE

# Capistrano #

!SLIDE smaller

    @@@ruby
    set :domain, "example.com"
    set :application, "www.example.com"
    set :deploy_to, "/var/www/#{domain}/#{application}/public"
    set :repository, "git@github.com:username/example.git"
    set :scm, :git
    set :user, "username"

    server "example.com", :app, :web, :db, :primary => true

    after "deploy:symlink", "deploy:copy_config"

!SLIDE

# Chef #

!SLIDE smaller

    @@@ruby
    package "nginx"

    directory node[:nginx][:log_dir] do
      mode 0755
      owner node[:nginx][:user]
      action :create
    end

    %w{nxensite nxdissite}.each do |nxscript|
      template "/usr/sbin/#{nxscript}" do
        source "#{nxscript}.erb"
        mode 0755
        owner "root"
        group "root"
      end
    end

!SLIDE

# Fog #
