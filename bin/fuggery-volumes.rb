#!/usr/bin/env ruby
#
# Try and do some of our fuggery volume crack

$LOAD_PATH.unshift File.join(File.dirname(__FILE__), "..", "lib")

require 'fuggery/rackspace/storage'
require 'optparse'

user = ENV['RACKSPACE_USER']
key  = ENV['RACKSPACE_KEY']

verbose = false

OptionParser.new do |opts|
  opts.banner = "Usage: #{$0} [options] operation(s)"
  opts.on("-u", "--user USERNAME", "rackspace username")                    { |u| user = u }
  opts.on("-k", "--key KEY", "rackspace API key")                           { |k| key  = k }
  opts.on("-h", "--host HOSTNAME", "target hostname")                       { |h| host = h }
  opts.on("-d", "--disk DISKNAME", "disk to operate on")                    { |d| disk = d }
  opts.on("-n", "--new DISKNAME", "new volume name")                        { |n| new  = n }
  opts.on("-s", "--snapshot SNAPSHOT", "snapshot name")                     { |s| snap = s }
end.parse!

if ARGV.length == 0
  raise ArgumentError, "Missing at least one operation 
You can use any of: 
\t umount 
\t mount 
\t create_volume 
\t snapshot"
end

s = Fuggery::Rackspace::Storage.new user, key

ARGV.each do |operation|
  case operation
    when 'umount'
    s.umount host, disk, wait=true
    when 'mount'
    s.mount host, disk
    when 'create_volume'
    s.create_volume new, snap, wait=true
    when 'snapshot'
    s.create_snapshot disk, wait=true
    else
    warn "Operation: #{operation} is invalid"
  end
end
