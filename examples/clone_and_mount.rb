$LOAD_PATH.unshift File.join(File.dirname(__FILE__), "..", "lib")

require 'fuggery/rackspace/storage'

s = Fuggery::Rackspace::Storage.new ENV['RACKSPACE_USER'], ENV['RACKSPACE_KEY']

s.umount 'my_shiny_server', 'my_cloneable_disk', wait=true
snapshot = s.create_snapshot('my_cloneable_disk', wait=true)
s.create_volume('my_cloned_disk', snapshot, wait=true)
s.mount 'my_shiny_server', 'my_cloned_disk'
