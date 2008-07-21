namespace :db do
  task :bootstrap => ['db:create', 'db:migrate']
  task :populate => :environment do 
    Channel.create(:name => '#rubyfringe', :nickname => 'the_then', :server => "irc.freenode.net", :port => '6667')
    Channel.create(:name => '#rails-contrib', :nickname => 'the_then', :server => "irc.freenode.net", :port => '6667')
  end
end