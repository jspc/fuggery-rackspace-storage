$LOAD_PATH.unshift File.join(File.dirname(__FILE__), ".", "lib")

require 'fc/rack/storage'

s = FC::Rack::Storage.new ENV['RACKSPACE_USER'], ENV['RACKSPACE_KEY']

#s.mount 'jspc_test', 'jspc_test-db'
#exit

s.umount 'jspc_test', 'jspc_test-db'

sleep 30

snapshot = s.create_snapshot('jspc_test-db', wait=true)
s.create_volume('new_bollocks', snapshot, wait=true)
s.mount 'jspc_test', 'new_bollocks'
