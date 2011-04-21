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
        Evas.object_smart_callback_add @ptr, "delete,request", method(:exit), FFI::MemoryPointer::NULL
    end
    def feed
        @bg = add 'bg'
        Evas.object_size_hint_weight_set @bg, 1.0, 1.0
        resize_object_add @bg
        Evas.object_show @bg
        @lb = add 'label'
        Elm.label_label_set @lb, "Hello World!"
        Evas.object_size_hint_weight_set @lb, 1.0, 1.0
        resize_object_add @lb
        Evas.object_show @lb
    end
    def exit *args
    	puts "Good bye!"
        Elm.exit();
    end
end
#
win = MyWin.new "App name", "Window Title" do |w|
    Evas.object_move w.ptr, 300, 300
    Evas.object_resize w.ptr, 200, 100
    Evas.object_show w.ptr
end

Elm.run
puts Elm.shutdown
#
# EOF

