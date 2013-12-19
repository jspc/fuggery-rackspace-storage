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

  context 'when unmounting a disk' do
    it 'should throw NoSuchServer for non-existant host' do
      expect{ storage.umount(FAKE_HOST, FAKE_DISK) }.to raise_error FC::Rack::NoSuchServer
    end
    it 'should throw NoSuchVolume for non-existant volume' do
      expect{ storage.umount(BASE_HOST, FAKE_DISK) }.to raise_error FC::Rack::NoSuchVolume
    end
    it 'should throw NoSuchMount where a valid volume is not mounted on a valid host' do
      expect{ storage.umount(BASE_HOST, AN_DISK) }.to raise_error FC::Rack::NoSuchMount      
    end
    it 'should un-mount a valid pairing' do
      expect{ storage.umount(BASE_HOST, BASE_DISK) }.to be_true
    end
  end
end
