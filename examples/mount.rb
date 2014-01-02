$LOAD_PATH.unshift File.join(File.dirname(__FILE__), "..", "lib")

require 'fuggery/rackspace/storage'

s = Fuggery::Rackspace::Storage.new ENV['RACKSPACE_USER'], ENV['RACKSPACE_KEY']
s.mount 'my_shiny_server', 'my_new_shiny_disk'
