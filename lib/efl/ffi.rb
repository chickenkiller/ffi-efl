#! /usr/bin/env ruby
# -*- coding: UTF-8 -*-
#
require 'ffi'
#
module Efl
    #
    module FFIHelper
        #
        def attach_fcts fcts
            fcts.each do |func|
                begin
                    attach_function(*func)
                rescue Object => e
                    puts "Could not attach #{func} #{e.message}"
                end
            end
        end
        #
        def self.extended mod
            #
            mod.extend FFI::Library
            #
            mod.typedef :pointer, :char_p
            mod.typedef :pointer, :short_p
            mod.typedef :pointer, :int_p
            mod.typedef :pointer, :long_p
            mod.typedef :pointer, :float_p
            mod.typedef :pointer, :double_p
            mod.typedef :pointer, :uchar_p
            mod.typedef :pointer, :ushort_p
            mod.typedef :pointer, :uint_p
            mod.typedef :pointer, :ulong_p
            mod.typedef :pointer, :ufloat_p
            mod.typedef :pointer, :udouble_p
            mod.typedef :pointer, :void_p
            mod.typedef :pointer, :string_array
            mod.typedef :pointer, :string_array_p
            mod.typedef :uint_p,  :uintptr_t
            #
            mod.typedef :bool,    :eina_bool
            mod.typedef :pointer, :eina_bool_p
            mod.typedef :pointer, :eina_list_p
            mod.typedef :pointer, :eina_hash_p
            mod.typedef :pointer, :eina_iterator_p
            mod.typedef :pointer, :eina_accessor_p
            mod.typedef :pointer, :evas_p
            mod.typedef :pointer, :evas_object_p
            mod.typedef :pointer, :evas_object_pp
            mod.typedef :pointer, :ecore_getopt_p
            mod.typedef :pointer, :ecore_getopt_desc_p
            mod.typedef :pointer, :ecore_getopt_value_p
            #
            mod.callback :eina_compare_cb, [ :void_p, :void_p ], :int
            mod.callback :eina_each_cb, [ :void_p, :void_p, :void_p ], :eina_bool
            mod.callback :eina_free_cb, [ :void_p ], :void
        end
        #
    end
    #
    module ClassHelper
        def self.included kls
            kls.class_eval "def self.search_paths; @search_paths; end"
            kls.class_eval "def self.inherited sub; sub.class_eval 'def self.search_paths; superclass.search_paths; end'; end"
        end
        def to_ptr
            @ptr
        end
        def === o
            @ptr === o.to_ptr
        end
        def address
            @ptr.address
        end
        def method_missing m, *args, &block
            if m =~/^(.*)=$/
                m_s = $1+'_set'
                args_s = '*args[0]'
            elsif m =~/^(.*)\?$/
                m_s = $1+'_get'
                args_s = '*args'
            else
                m_s = m.to_s
                args_s = '*args'
            end
            self.class.search_paths.each do |mod,p|
                sym = p+m_s
                if mod.respond_to? sym
                    self.class.class_eval "def #{m} *args, &block; r=#{mod.name}.#{sym}(@ptr,#{args_s}); yield r if block_given?; r; end"
                    return self.send m, *args, &block
                end
            end
            raise NameError.new "unable to resolve #{m} into #{self.class.search_paths.inspect}"
        end
    end
end
#
# EOF
