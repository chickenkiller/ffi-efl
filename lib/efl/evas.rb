#! /usr/bin/env ruby
# -*- coding: UTF-8 -*-
#
require 'efl/evas/evas-ffi'
#
module Efl
    module Evas
        #
        class Evas
            include Efl::Helper
            @func_prefixes = [ 'evas_' ].freeze
            def initialize o=nil
                @ptr = (
                    case o
                    when NilClass
                        FFI::AutoPointer.new Efl::API.evas_new, method(:free)
                    when self.class
                        o.ptr
                    when FFI::AutoPointer
                        o
                    when FFI::Pointer
                        FFI::AutoPointer.new o, method(:free)
                    else
                        raise ArgumentError.new "#{ptr.class} valid argument"
                    end
                )
                yield self if block_given?
            end
            def free
                Efl::API.evas_free @ptr
                @ptr=nil
            end
            def === o
                @ptr === o.ptr
            end
            def output_size_get
                x = FFI::MemoryPointer.new :int
                y = FFI::MemoryPointer.new :int
                Efl::API.evas_output_size_get @ptr, x, y
                [ x.read_int, y.read_int ]
            end
            def output_viewport_get
                x = FFI::MemoryPointer.new :int
                y = FFI::MemoryPointer.new :int
                w = FFI::MemoryPointer.new :int
                h = FFI::MemoryPointer.new :int
                Efl::API.evas_output_viewport_get @ptr, x, y, w, h
                [ x.read_int, y.read_int, w.read_int, h.read_int ]
            end
            def pointer_output_xy_get
                x = FFI::MemoryPointer.new :int
                y = FFI::MemoryPointer.new :int
                Efl::API.evas_pointer_output_xy_get @ptr, x, y
                [ x.read_int, y.read_int ]
            end
            def pointer_canvas_xy_get
                x = FFI::MemoryPointer.new :int
                y = FFI::MemoryPointer.new :int
                Efl::API.evas_pointer_canvas_xy_get @ptr, x, y
                [ x.read_int, y.read_int ]
            end
        end
        #
        class EvasObject
            include Efl::Helper
            @func_prefixes = [ 'evas_object_', 'evas_' ].freeze
            def initialize o=nil
                @ptr = (
                    case o
                    when NilClass
                        FFI::AutoPointer.new Efl::API.evas_new, method(:free)
                    when self.class
                        o.ptr
                    when FFI::AutoPointer
                        o
                    when FFI::Pointer
                        FFI::AutoPointer.new o, method(:free)
                    else
                        raise ArgumentError.new "#{ptr.class} valid argument"
                    end
                )
                yield self if block_given?
            end
            def free
                Efl::API.evas_object_del @ptr
                @ptr=nil
            end
            def geometry_get
                x = FFI::MemoryPointer.new :int
                y = FFI::MemoryPointer.new :int
                w = FFI::MemoryPointer.new :int
                h = FFI::MemoryPointer.new :int
                Efl::API.evas_object_geometry_get @evas, x, y, w, h
                [ x.read_int, y.read_int, w.read_int, h.read_int ]
            end
            def color_get
                r = FFI::MemoryPointer.new :int
                g = FFI::MemoryPointer.new :int
                b = FFI::MemoryPointer.new :int
                a = FFI::MemoryPointer.new :int
                Efl::API.evas_object_color_get @evas, r, g, b, a
                [ r.read_int, g.read_int, b.read_int, a.read_int ]
            end
        end
    end
end
#
# EOF
