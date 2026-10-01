# ruby script/runner 'script/slump/slump.rb'
puts 'start'

#require 'script/slump/random_name'
require 'script/slump/scenario'

#
#puts RandomName.girl_name + ' ' + RandomName.last_name
#puts RandomName.boy_name + ' ' + RandomName.last_name

puts
#Scenario.new(4).go
Scenario.new.go