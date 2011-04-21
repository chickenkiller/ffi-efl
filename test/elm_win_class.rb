#! /usr/bin/env ruby
# -*- coding: UTF-8 -*-
#
require 'efl/elementary'
#
include Efl
#
puts Elm.init

class MyWin < Elm::ElmWin
    def initialize name, title
        super FFI::MemoryPointer::NULL, name
        win_title_set title
        feed
        Efl::Evas.object_smart_callback_add @ptr, "delete,request", method(:exit), FFI::MemoryPointer::NULL
    end
    def feed
        @bg = add 'bg'
        Efl::Evas.object_size_hint_weight_set @bg, 1.0, 1.0
        resize_object_add @bg
        Efl::Evas.object_show @bg
        @lb = add 'label'
        Efl::Elm.label_label_set @lb, "Hello World!"
        Efl::Evas.object_size_hint_weight_set @lb, 1.0, 1.0
        resize_object_add @lb
        Efl::Evas.object_show @lb
    end
    def exit *args
    	puts "Good bye!"
        Efl::Elm.exit();
    end
end
#
win = MyWin.new "App name", "Window Title" do |w|
    Efl::Evas.object_move w.ptr, 300, 300
    Efl::Evas.object_resize w.ptr, 200, 100
    Efl::Evas.object_show w.ptr
end

Elm.run
puts Elm.shutdown
#
# EOF

