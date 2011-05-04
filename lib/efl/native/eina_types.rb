#! /usr/bin/env ruby
# -*- coding: UTF-8 -*-
#
require 'efl/ffi'
#
module Efl
    #
    module Eina
        #
        def self.method_missing m, *args, &block
            sym = 'eina_'+m.to_s
            raise NameError.new "#{self.name}.#{sym} (#{m})" if not Efl::Eina::Native.respond_to? sym
            self.module_eval "def self.#{m} *args, &block; r=Efl::Eina::Native.#{sym}(*args); yield r if block_given?; r; end"
            self.send m, *args, &block
        end
        #
        module Native
            #
            extend Efl::FFIHelper
            #
            ffi_lib 'eina'
            #
            # ENUMS
            #
            # TYPEDEFS
            # typedef unsigned char Eina_Bool;
            typedef :bool, :eina_bool
            typedef :pointer, :eina_bool_p
            #
            # CALLBACKS
            # typedef int (*Eina_Compare_Cb) (const void *data1, const void *data2);
            callback :eina_compare_cb, [ :void_p, :void_p ], :int
            # typedef Eina_Bool (*Eina_Each_Cb) (const void *container, void *data, void *fdata);
            callback :eina_each_cb, [ :void_p, :void_p, :void_p ], :eina_bool
            # typedef void (*Eina_Free_Cb) (void *data);
            callback :eina_free_cb, [ :void_p ], :void
            #
            # FUNCTIONS
            fcts = [
            # EAPI extern const unsigned int eina_prime_table[];
            # FIXME
            ]
            #
            attach_fcts fcts
            #
        end
    end
end
#
# EOF
