#-*- mode: ruby -*-

$LOAD_PATH.unshift File.join(File.dirname(__FILE__), "..", "lib")

require 'fc/rack/storage'
require 'fog'

#Fog.mock!       # The mocks for Fog::Rackspace are shit

RSUSER    = ENV['RACKSPACE_USER']
RSKEY     = ENV['RACKSPACE_KEY']

BASE_HOST = 'jspc_test'
BASE_DISK = 'jspc_test-db'
AN_DISK   = 'test_volume'
AN_DISK_N = 'test_volume-recreated'

FAKE_HOST = 'man_i_hope_this_never_gets_created'
FAKE_DISK = 'this_disk_has_bad_sectors'
FAKE_SNAP = 'blurry-polaroid'
