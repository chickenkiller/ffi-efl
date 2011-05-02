#! /usr/bin/env ruby
# -*- coding: UTF-8 -*-
#
require 'efl/eina_hash'
#
describe Efl::EinaHash do
    #
    before(:all) {
        REinaHash = Efl::EinaHash::REinaHash
        Efl::Eina.init.should eql 1
        @d0 = FFI::MemoryPointer.from_string "D0"
        @d1 = FFI::MemoryPointer.from_string "D1"
        @d2 = FFI::MemoryPointer.from_string "D2"
        @d3 = FFI::MemoryPointer.from_string "D3"
    }
    after(:all) {
        Efl::Eina.shutdown.should eql 0
    }
    #
    it "should append prepend and fetch" do
        h = REinaHash.new
        h.add 'k2', @d2
        h.add 'k1', @d1
        h['k3']=@d3
        h['k0']=@d0
        h['k0'].read_string.should eql "D0"
        h['k1'].read_string.should eql "D1"
        h['k2'].read_string.should eql "D2"
        h['k3'].read_string.should eql "D3"
        cpt=0
        h.each { |k,v|
            cpt+=1
            v.read_string.empty?.should be_false
        }
        cpt.should eql 4
    end
    #
    it "should be able to convert into ruby Hash from NULL pointer" do
        h = Hash.from_eina_hash FFI::Pointer::NULL
        h.empty?.should be_true
        h.is_a?(Hash).should be_true
    end
    #
    it "should be able to convert into ruby Hash from empty REinaHash" do
        h = Hash.from_eina_hash REinaHash.new
        h.empty?.should be_true
        h.is_a?(Hash).should be_true
    end
    #
    it "should be able to convert into ruby Hash from empty REinaHash pointer" do
        h = Hash.from_eina_hash REinaHash.new.to_ptr
        h.empty?.should be_true
        h.is_a?(Hash).should be_true
    end
    #
    it "should be able to convert into ruby Hash from non empty REinaHash" do
        h = REinaHash.new
        d0 = FFI::MemoryPointer.from_string "D0"
        d1 = FFI::MemoryPointer.from_string "D1"
        d2 = FFI::MemoryPointer.from_string "D2"
        d3 = FFI::MemoryPointer.from_string "D3"
        h.add 'k2', d2
        h.add 'k1', d1
        h['k3']=d3
        h["k0"]=d0
        h["k0"].read_string.should eql "D0"
        h['k1'].read_string.should eql "D1"
        h['k2'].read_string.should eql "D2"
        h['k3'].read_string.should eql "D3"
        cpt=0
        h.each { |k,v|
            cpt+=1
            v.read_string.empty?.should be_false
            true
        }
        cpt.should eql 4
        rh =  Hash.from_eina_hash h
        rh.length.should eql 4
        rh2 = {}
        rh.each { |k,v|
            rh2[k.read_string]=v.read_string
            true
        }
        rh2['k0'].should eql 'D0'
        rh2['k1'].should eql 'D1'
        rh2['k2'].should eql 'D2'
        rh2['k3'].should eql 'D3'
    end
    #
    it "should be able to convert into ruby Hash from non empty REinaHash pointer" do
        h = REinaHash.new
        d0 = FFI::MemoryPointer.from_string "D0"
        d1 = FFI::MemoryPointer.from_string "D1"
        d2 = FFI::MemoryPointer.from_string "D2"
        d3 = FFI::MemoryPointer.from_string "D3"
        h.add 'k2', d2
        h.add 'k1', d1
        h['k3']=d3
        h['k0']=d0
        h['k0'].read_string.should eql "D0"
        h['k1'].read_string.should eql "D1"
        h['k2'].read_string.should eql "D2"
        h['k3'].read_string.should eql "D3"
        rh =  Hash.from_eina_hash h.to_ptr
        rh.length.should eql 4
    end
    #
    it "should be able to convert into ruby Hash from non empty REinaHash pointer, with key from string" do
        h = REinaHash.new
        d0 = FFI::MemoryPointer.from_string "D0"
        d1 = FFI::MemoryPointer.from_string "D1"
        d2 = FFI::MemoryPointer.from_string "D2"
        d3 = FFI::MemoryPointer.from_string "D3"
        h.add 'k2', d2
        h.add 'k1', d1
        h['k3']=d3
        h['k0']=d0
        h['k0'].read_string.should eql "D0"
        h['k1'].read_string.should eql "D1"
        h['k2'].read_string.should eql "D2"
        h['k3'].read_string.should eql "D3"
        rh =  h.to_h_conv
        rh.length.should eql 4
        rh['k0'].read_string.should eql "D0"
        rh['k1'].read_string.should eql "D1"
        rh['k2'].read_string.should eql "D2"
        rh['k3'].read_string.should eql "D3"
    end
    #
    it "should be able to convert into ruby Hash from non empty REinaHash pointer, with key from string block" do
        h = REinaHash.new
        d0 = FFI::MemoryPointer.from_string "D0"
        d1 = FFI::MemoryPointer.from_string "D1"
        d2 = FFI::MemoryPointer.from_string "D2"
        d3 = FFI::MemoryPointer.from_string "D3"
        h.add 'k2', d2
        h.add 'k1', d1
        h['k3']=d3
        h['k0']=d0
        h['k0'].read_string.should eql "D0"
        h['k1'].read_string.should eql "D1"
        h['k2'].read_string.should eql "D2"
        h['k3'].read_string.should eql "D3"
        cpt=0
        rh =  h.to_h_conv { |k| cpt+=1; k.read_string }
        cpt.should eql 4
        rh.length.should eql 4
        rh['k0'].read_string.should eql "D0"
        rh['k1'].read_string.should eql "D1"
        rh['k2'].read_string.should eql "D2"
        rh['k3'].read_string.should eql "D3"
    end
    #
    it "should be able to build from ruby Hash" do
        rh = {}
        k0 = FFI::MemoryPointer.from_string "0"
        k1 = FFI::MemoryPointer.from_string "1"
        k2 = FFI::MemoryPointer.from_string "2"
        k3 = FFI::MemoryPointer.from_string "3"
        d0 = FFI::MemoryPointer.from_string "D0"
        d1 = FFI::MemoryPointer.from_string "D1"
        d2 = FFI::MemoryPointer.from_string "D2"
        d3 = FFI::MemoryPointer.from_string "D3"
        rh[k0]=d0
        rh[k1]=d1
        rh[k2]=d2
        rh[k3]=d3
        h = REinaHash.new rh
        h[k0].read_string.should eql "D0"
        h[k1].read_string.should eql "D1"
        h[k2].read_string.should eql "D2"
        h[k3].read_string.should eql "D3"
    end
    #
    it "alternate constructor should work" do
        cstr_cnt = 0
        h = REinaHash.new { cstr_cnt+=1; Efl::EinaHash.eina_hash_string_superfast_new FFI::Pointer::NULL }
        cstr_cnt.should eql 1
    end
end
