#!/usr/bin/env ruby
#
# Do something clever

require 'fog'
require 'fuggery/rackspace/errors'

module Fuggery
  module Rackspace
    class Storage
      def initialize user, key
        @c = Fog::Compute.new({
          :provider            => 'Rackspace',
          :rackspace_api_key   => key,
          :rackspace_username  => user,
          :version             => :v2,
          :rackspace_auth_url  => Fog::Rackspace::UK_AUTH_ENDPOINT,
          :rackspace_region    => :lon
        })
        @bs = Fog::Rackspace::BlockStorage.new({
          :rackspace_api_key   => key,
          :rackspace_username  => user,
          :rackspace_auth_url  => Fog::Rackspace::UK_AUTH_ENDPOINT,
          :rackspace_region    => :lon
        })
      end

      def _get_server name
        @c.servers.each { |s| return s if s.name == name }
        raise Fuggery::Rackspace::NoSuchServer, "#{name} is not a valid server display_name"
      end
      
      def _get_volume name
        @bs.volumes.each { |v| return v if v.display_name == name }
        raise Fuggery::Rackspace::NoSuchVolume, "#{name} is not a valid volume display_name"
      end

      def _get_snapshot name
        @bs.snapshots.each { |s| return s if s.display_name == name }
        raise Fuggery::Rackspace::NoSuchSnapshot, "#{name} is not a valid snapshot display_name"
      end

      def _attachments name
        att = []
        _get_volume(name)['attachments'].each do |a|
          att < a['server_id']
        end
      end

      def is_attached? host_name, volume_name
        host   = _get_server host_name
        volume = _get_volume volume_name

        host.attachments.each do |a|
          if a.volume_id == volume.id
            return a
          end
        end
        return false
      end
      
      def mount host_name, volume_name
        host   = _get_server host_name
        volume = _get_volume volume_name

        host.attach_volume volume
      end

      def umount host_name, volume_name, wait=false
        if h = is_attached?(host_name, volume_name)
          h.detach
          if wait
            while  is_attached? host_name, volume_name
              sleep 1
            end
          end
        end
        raise Fuggery::Rackspace::NoSuchMount, "#{volume_name} is not mounted on #{host_name}"
      end

      def create_snapshot volume_name, wait=false
        volume = _get_volume volume_name
        name   = "#{volume_name}-#{Time.new.strftime "%Y%m%d%H%M"}"
        begin
          volume.create_snapshot :display_name => name
        rescue Fog::Rackspace::BlockStorage::ServiceError
          raise Fuggery::Rackspace::DoingStuff, "Already snapshotting something"
        end

        if wait
          until _get_snapshot(name).state == 'available'
            sleep 1
          end
        end
        return name
      end
      
      def create_volume name, snapshot_name, wait=false
        snapshot = _get_snapshot snapshot_name
        @bs.volumes.create( :size => 100, :display_name => name, :snapshot_id => snapshot.id )

        if wait
          until _get_volume(name).state == 'available'
            sleep 1
          end
        end
        return name
      end

    end
  end
end
