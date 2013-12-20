# -*- coding: utf-8 -*-
# -*- mode: ruby -*-

require 'spec_helper'

describe FC::Rack::Storage do
  subject(:storage){ FC::Rack::Storage.new RSUSER, RSKEY }

  context 'when instatiated' do
    it { should be_true }
    it { should respond_to :umount }
    it { should respond_to :mount }
    it { should respond_to :create_snapshot }
    it { should respond_to :create_volume }
  end

  context 'when trying to un-mount a disk' do
    it 'should throw NoSuchServer for non-existent host' do
      expect{ storage.umount(FAKE_HOST, FAKE_DISK) }.to raise_error FC::Rack::NoSuchServer
    end
    it 'should throw NoSuchVolume for non-existent volume' do
      expect{ storage.umount(BASE_HOST, FAKE_DISK) }.to raise_error FC::Rack::NoSuchVolume
    end
    it 'should throw NoSuchMount where a valid volume is not mounted on a valid host' do
      expect{ storage.umount(BASE_HOST, AN_DISK) }.to raise_error FC::Rack::NoSuchMount      
    end
    it 'should un-mount a valid pairing' do
      expect( storage.umount(BASE_HOST, BASE_DISK) ).to be_true
    end
  end

  context 'when trying to create a snapshot' do
    it 'should throw NoSuchVolume for non-existent volume' do
      expect{ storage.create_snapshot(FAKE_DISK) }.to raise_error FC::Rack::NoSuchVolume
    end

    it 'should create a snapshot from a valid volume' do
      expect( storage.create_snapshot(BASE_DISK) ).to be_true
    end
  end

  context 'when trying to create a volume' do
    it 'should throw NoSuchSnapshot for non-existent snapshot' do
      expect{ storage.create_volume(AN_DISK_N, FAKE_SNAP) }.to raise_error FC::Rack::NoSuchSnapshot
    end

    it 'should create a volume from a valid snapshot' do
      s = storage.create_snapshot(BASE_DISK)
      expect( storage.create_volume(AN_DISK_N, s.display_name) ).to be_true
    end
  end
end
