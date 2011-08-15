#! /usr/bin/env ruby
# -*- coding: UTF-8 -*-
#
require 'efl/eina'
#
describe "Efl::Eina #{Efl::Eina.version.full}" do
    before(:all) {
        @i = Efl::Eina.init
    }
    after(:all) {
        Efl::Eina.shutdown
    }
    #
    it "should init" do
        Efl::Eina.init.should == @i+1
        Efl::Eina.init.should == @i+2
        Efl::Eina.init.should == @i+3
    end
    #
    it "should be main thread" do
        Efl::Eina.main_loop_is.should be_true
        if RUBY_VERSION > "1.9.0"
            Thread.new do
                Efl::Eina.main_loop_is.should be_false
            end.join
        else
            puts "  no bother on 1.8 branch"
        end
    end
    #
    it "should shutdown" do
        Efl::Eina.shutdown.should == @i+2
        Efl::Eina.shutdown.should == @i+1
        Efl::Eina.shutdown.should == @i+0
    end
    #
end
