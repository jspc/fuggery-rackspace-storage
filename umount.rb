$LOAD_PATH.unshift File.join(File.dirname(__FILE__), ".", "lib")

require 'fc/rack/storage'

s = FC::Rack::Storage.new ENV['RACKSPACE_USER'], ENV['RACKSPACE_KEY']

#s.umount 'jspc_test', 'jspc_test-db'
snapshot = s.create_snapshot('jspc_test-db')

puts 'done'
