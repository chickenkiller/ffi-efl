#! /usr/bin/env ruby
# -*- coding: UTF-8 -*-
#
require 'efl/eet/eet-ffi'
#
module Efl
    module Eet
        #
        class << self
            #
            def open path, mode=FILE_MODE_READ, &blk
                if blk
                    f = Efl::API.eet_open path, mode
                    raise Exception.new "Unable to open file #{path}" if f.nil?
                    yield EetFile.new f
                    Efl::API.eet_close f
                else
                    f = Efl::API.eet_open path, mode
                    return EetFile.new f unless f.nil?
                end
            end
        end
        #
        class EetFile
            #
            def initialize ptr
                @ptr=ptr
            end
            private :initialize
            #
            def close
                Efl::API.eet_close @ptr
                @ptr=nil
            end
            #
            def mode_get
                Efl::API.eet_mode_get @ptr
            end
            #
            def write key, data, compress=false
                Efl::API.eet_write @ptr, key, FFI::MemoryPointer.from_string(data), data.bytesize, ( compress ? 1 : 0 )
            end
            #
            def read key
                ptr = FFI::MemoryPointer.new(:int)
                data = Efl::API.eet_read @ptr, key, ptr
                s = ptr.read_int
                ptr.free
                return nil if s==0
                ( data.null? ? nil : data.read_string[0..s-1] )
            end
            #
        end
        #
    end
end
#
# EOF
