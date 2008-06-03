require 'rubygems'; require 'spec'; require 'lib/rugalytics'

begin
  require 'echoe'

  Echoe.new("rugalytics", Rugalytics::VERSION) do |m|
    m.author = ["Rob McKinnon"]
    m.email = ["rob ~@nospam@~ rubyforge.org"]
    m.description = File.readlines("README").first
    m.rubyforge_name = "rugalytics"
    m.rdoc_options << '--inline-source'
    m.rdoc_pattern = ["README", "CHANGELOG", "LICENSE"]
    m.dependencies = ["hpricot >=0.6", "activesupport >=2.0.2", "googlebase >=0.2.0", "morph >=0.1.5"]
  end

rescue LoadError
  puts "You need to install the echoe gem to perform meta operations on this gem"
end

desc "Open an irb session preloaded with this library"
task :console do
  sh "irb -rubygems -r ./lib/rugalytics.rb"
end