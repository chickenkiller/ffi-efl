#! /usr/bin/env ruby
# -*- coding: UTF-8 -*-
#
require 'efl/eina'
require 'efl/eina_list'
#
describe Efl::EinaList do
    #
    before(:all) {
        REinaList = Efl::EinaList::REinaList
        Efl::Eina.init.should == 1
    }
    after(:all) {
        Efl::Eina.shutdown.should == 0
    }
    #
    it "should append prepend and fetch" do
        l = REinaList.new
        d1 = ::FFI::MemoryPointer.from_string "D0"
        d2 = ::FFI::MemoryPointer.from_string "D1"
        d3 = ::FFI::MemoryPointer.from_string "D2"
        d4 = ::FFI::MemoryPointer.from_string "D3"
        l.append d3
        l.prepend d2
        l << d4
        l.unshift d1
        0.upto 3 do |i|
            l.nth(i).read_string.should == "D#{i}"
        end
        l.each { |p| p.read_string.empty?.should be_false }
        l.free
    end
    #
    it "should be able to convert into ruby Array from NULL pointer" do
        ary = Array.from_eina_list ::FFI::Pointer::NULL
        ary.empty?.should be_true
        ary.is_a?(Array).should be_true
    end
    #
    it "should be able to convert into ruby Array from empty REinaList" do
        ary = Array.from_eina_list REinaList.new
        ary.empty?.should be_true
        ary.is_a?(Array).should be_true
    end
    #
    it "should be able to convert into ruby Array from empty REinaList pointer" do
        ary = Array.from_eina_list REinaList.new.to_ptr
        ary.empty?.should be_true
        ary.is_a?(Array).should be_true
    end
    #
    it "should be able to convert into ruby Array from non empty REinaList" do
        l = REinaList.new
        d1 = ::FFI::MemoryPointer.from_string "D0"
        d2 = ::FFI::MemoryPointer.from_string "D1"
        d3 = ::FFI::MemoryPointer.from_string "D2"
        d4 = ::FFI::MemoryPointer.from_string "D3"
        l.append d3
        l.prepend d2
        l << d4
        l.unshift d1
        ary =  Array.from_eina_list l
        ary.length.should == 4
        0.upto 3 do |i|
            ary[i].read_string.should == "D#{i}"
        end
        l.free
    end
    #
    it "should be able to convert into ruby Array from non empty REinaList pointer" do
        l = REinaList.new
        d1 = ::FFI::MemoryPointer.from_string "D0"
        d2 = ::FFI::MemoryPointer.from_string "D1"
        d3 = ::FFI::MemoryPointer.from_string "D2"
        d4 = ::FFI::MemoryPointer.from_string "D3"
        l.append d3
        l.prepend d2
        l << d4
        l.unshift d1
        ary =  Array.from_eina_list l.to_ptr
        ary.length.should == 4
        0.upto 3 do |i|
            ary[i].read_string.should == "D#{i}"
        end
        l.free
    end
    #
    it "should be able to build from ruby Array" do
        a =  []
        a << ::FFI::MemoryPointer.from_string("D0")
        a << ::FFI::MemoryPointer.from_string("D1")
        a << ::FFI::MemoryPointer.from_string("D2")
        a << ::FFI::MemoryPointer.from_string("D3")
        l = REinaList.new a
        0.upto 3 do |i|
            l.nth(i).read_string.should == "D#{i}"
        end
        l.free
    end
    #
end
