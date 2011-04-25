#! /usr/bin/env ruby
# -*- coding: UTF-8 -*-
#
require 'efl/ecore/ecore_getopt-ffi'
#
module Efl
    module API
        #
        class EcoreGetoptValue < FFI::Union
            layout  :strp,          :pointer,
                    :boolp,         :eina_bool_p,
                    :shortp,        :short_p,
                    :intp,          :int_p,
                    :longp,         :long_p,
                    :ushortp,       :ushort_p,
                    :uintp,         :uint_p,
                    :ulongp,        :ulong_p,
                    :doublep,       :double_p,
                    :listp,         :eina_list_p,
                    :ptrp,          :void_p,
        end
        #
        class EcoreGetoptDescStoreDef < FFI::Union
            layout  :strv,          :pointer,
                    :boolv,         :uchar,
                    :shortv,        :short,
                    :intv,          :int,
                    :longv,         :long,
                    :ushortv,       :ushort,
                    :uintv,         :uint,
                    :ulongv,        :ulong,
                    :doublev,       :double,
        end
        #
        class EcoreGetoptDescStore < FFI::Struct
            layout  :type,          :ecore_getopt_type,                 # enum
                    :arg_req,       :ecore_getopt_desc_arg_requirement, # enum
                    :def,           EcoreGetoptDescStoreDef,
        end
        #
        callback :ecore_getopt_desc_cb, [:ecore_getopt_p, :ecore_getopt_desc_p, :string, :pointer, :ecore_getopt_value_p ], :eina_bool
        #
        class EcoreGetoptDescCallback < FFI::Struct
            layout  :func,          :ecore_getopt_desc_cb,
                    :data,          :pointer,
                    :arg_req,       :ecore_getopt_desc_arg_requirement, # enum
                    :def,           :pointer,
        end
        #
        class EcoreActionParam < FFI::Union
            layout  :store,         EcoreGetoptDescStore,
                    :store_const,   :pointer,
                    :choices,       :pointer,
                    :append_type,   :ecore_getopt_type,                 # enum
                    :callback,      EcoreGetoptDescCallback,
                    :dummy,         :pointer,
        end
        #
        class EcoreGetoptDesc < FFI::Struct
            layout  :shortname,     :char,
                    :longname,      :pointer,
                    :help,          :pointer,
                    :metavar,       :pointer,
                    :action,        :ecore_getopt_action,               # enum
                    :action_param,  EcoreActionParam,
        end
        #
        class EcoreGetopt < FFI::Struct
            layout  :prog,          :pointer,
                    :usage,         :pointer,
                    :version,       :pointer,
                    :copyright,     :pointer,
                    :license,       :pointer,
                    :description,   :pointer,
                    :strict,        :char
#                    :descs,         :pointer,   # NULL terminated  EcoreGetopt_Desc[]

            def desc_ptr idx
                EcoreGetoptDesc.new to_ptr+Efl::API::EcoreGetopt.size+(idx*Efl::API::EcoreGetoptDesc.size)
            end
        end
        #
    end
    #
    module EcoreGetopt
        class Parser
            def initialize desc
                @desc = desc
                @options = [
                    [ 0, FFI::Pointer::NULL, FFI::Pointer::NULL, FFI::Pointer::NULL, 0, {:dummy=>FFI::Pointer::NULL} ]
                ]
                @values = [
                    [ :ptrp, FFI::Pointer::NULL ]
                ]
            end
            def << o
                @options.insert -2, o
            end
            def value type, ptr
                @values.insert -2, [ type, ptr ]
            end
            def create
                @parser_p = Efl::API::EcoreGetopt.new FFI::MemoryPointer.new (Efl::API::EcoreGetopt.size+Efl::API::EcoreGetoptDesc.size*@options.length), 1
                [:prog,:usage,:version,:copyright,:license,:description].each do |sym|
                    @parser_p[sym] = ( @desc.has_key?(sym) ? FFI::MemoryPointer.from_string(@desc[sym]) : FFI::Pointer::NULL )
                end
                @parser_p[:strict] = @desc[:strict] if @desc.has_key? :strict
                @options.each_with_index do |o,i|
                    d = @parser_p.desc_ptr i
                    d[:shortname] = o[0].ord
                    d[:longname] = (o[1]==FFI::Pointer::NULL ? FFI::Pointer::NULL : FFI::MemoryPointer.from_string(o[1]))
                    d[:help] = (o[2]==FFI::Pointer::NULL ? FFI::Pointer::NULL : FFI::MemoryPointer.from_string(o[2]))
                    d[:metavar] = o[3]
                    d[:action] = o[4]
                    k, v = o[5]
                    case k
                    when :dummy
                        d[:action_param][:dummy] = v
                    when :callback
                        cb = d[:action_param][:callback]
                        cb[:func] = v[0]
                        cb[:data] = v[1]
                        cb[:arg_req] = v[2]
                        cb[:def] = v[3]
                    when :store
                        st = d[:action_param][:store]
                        st[:type] = v[0]
                        st[:arg_req] = v[1]
                        if not v[2].nil?
                            if v[2][0]==:strv
                                st[:def][:strv] = FFI::MemoryPointer.from_string v[2][1]
                            else
                                st[:def][v[2][0]] = v[2][1]
                            end
                        end
                    when :store_const
                        d[:action_param][:store_const] = v
                    when :choices
                        d[:action_param][:choices] = v
                    when :append
                        d[:action_param][:append_type] = v
                    else
                        d[:action_param][:dummy] = FFI::Pointer::NULL
                    end
                end
                @values_p = FFI::MemoryPointer.new Efl::API::EcoreGetoptValue, @values.length, false
                @values.each_with_index do |v,i|
                    Efl::API::EcoreGetoptValue.new(@values_p+(i*Efl::API::EcoreGetoptValue.size))[v[0]] = v[1]
                end
            end
            def parse argv
                ptr = FFI::MemoryPointer.new(:pointer, argv.length+1)
                argv.each_with_index do |s, i|
                    ptr[i].put_pointer 0, FFI::MemoryPointer.from_string(s)
                end
                ptr[argv.length].put_pointer 0, FFI::Pointer::NULL
                Efl::EcoreGetopt.parse @parser_p, @values_p, argv.length, ptr
            end
            def store_full short, long, help, meta, type, arg_req, def_val
                self << [ short, long, help, meta, :ecore_getopt_action_store, [:store, [type,arg_req, def_val] ] ]
            end
            def store short, long, help, type
                store_full short, long, help, FFI::Pointer::NULL, type, :ecore_getopt_desc_arg_requirement_yes, nil
            end
            def store_type type, short, long, help
                store short, long, help, ('ecore_getopt_type_'+type.to_s).to_sym
            end
            def store_metavar short, long, help, meta, type
                store_full short, long, help, meta, type, :ecore_getopt_desc_arg_requirement_yes, nil
            end
            def store_meta_type type, short, long, help, meta
                store_metavar short, long, help, meta, ('ecore_getopt_type_'+type.to_s).to_sym
            end
            def store_def short, long, help, type, def_val
                store_full short, long, help, FFI::Pointer::NULL, type, :ecore_getopt_desc_arg_requirement_optional, def_val
            end
            def store_def_type type, short, long, help, def_val
                store_def short, long, help, ('ecore_getopt_type_'+type.to_s).to_sym, [ (type.to_s+'v').to_sym, def_val ]
            end
            def store_full_type type, short, long, help, meta, arg_req, def_val
                store_full short, long, help, meta, ('ecore_getopt_type_'+type.to_s).to_sym, arg_req, [ (type.to_s+'v').to_sym, def_val ]
            end
            def store_const short, long, help, value
                self << [ short, long, help, FFI::Pointer::NULL, :ecore_getopt_action_store_const, [:store_const, value] ]
            end
            def store_true short, long, help
                self << [ short, long, help, FFI::Pointer::NULL, :ecore_getopt_action_store_true, [:dummy,FFI::MemoryPointer::NULL] ]
            end
            def store_false short, long, help
                self << [ short, long, help, FFI::Pointer::NULL, :ecore_getopt_action_store_false, [:dummy,FFI::MemoryPointer::NULL] ]
            end
            def choice short, long, help, choices
                ptr = FFI::MemoryPointer.new(:pointer, choices.length+1)
                choices.each_with_index do |s, i|
                    ptr[i].put_pointer 0, FFI::MemoryPointer.from_string(s)
                end
                ptr[choices.length].put_pointer 0, FFI::Pointer::NULL
                self << [ short, long, help, FFI::Pointer::NULL, :ecore_getopt_action_choice, [:choices,ptr] ]
            end
            def choice_metavar short, long, help, meta, choices
                ptr = FFI::MemoryPointer.new(:pointer, choices.length+1)
                choices.each_with_index do |s, i|
                    ptr[i].put_pointer 0, FFI::MemoryPointer.from_string(s)
                end
                ptr[choices.length].put_pointer 0, FFI::Pointer::NULL
                self << [ short, long, help, meta, :ecore_getopt_action_choice, [:choices,ptr] ]
            end
            def append short, long, help, sub_type
                self << [ short, long, help, FFI::Pointer::NULL, :ecore_getopt_action_append, [:append,sub_type] ]
            end
            def append_metavar short, long, help, meta, sub_type
                self << [ short, long, help, meta, :ecore_getopt_action_append, [:append,sub_type] ]
            end
            def count short, long, help
                self << [ short, long, help, FFI::Pointer::NULL, :ecore_getopt_action_count, [:dummy,FFI::Pointer::NULL] ]
            end
            def callback_full short, long, help, meta, cb, data, arg_req, def_val
                self << [ short, long, help, meta, :ecore_getopt_action_callback, [:callback, [cb, data, arg_req,def_val] ] ]
            end
            def callback_noargs short, long, help, cb, data
                callback_full short, long, help, FFI::Pointer::NULL, cb, data, :ecore_getopt_desc_arg_requirement_no, FFI::Pointer::NULL
            end
            def callback_args short, long, help, meta, cb, data
                callback_full short, long, help, meta, cb, data, :ecore_getopt_desc_arg_requirement_yes, FFI::Pointer::NULL
            end
            def help short, long
                self << [ short, long, 'show this message.', FFI::Pointer::NULL, :ecore_getopt_action_help, [:dummy,FFI::Pointer::NULL] ]
            end
            def version short, long
                self << [ short, long, 'show program version.', FFI::Pointer::NULL, :ecore_getopt_action_version, [:dummy,FFI::Pointer::NULL] ]
            end
            def copyright short, long
                self << [ short, long, 'show copyright.', FFI::Pointer::NULL, :ecore_getopt_action_copyright, [:dummy,FFI::Pointer::NULL] ]
            end
            def license short, long
                self << [ short, long, 'show license.', FFI::Pointer::NULL, :ecore_getopt_action_license, [:dummy,FFI::Pointer::NULL] ]
            end
#            def sentinel
#                self << [ 0, FFI::Pointer::NULL, FFI::Pointer::NULL, FFI::Pointer::NULL, 0, {:dummy=>FFI::Pointer::NULL} ]
#            end
            #
            def debug
                puts "#{self.class} : #{@parser_p.to_ptr}"
                [:prog,:usage,:version,:copyright,:license,:description].each do |sym|
                    puts "  #{sym.to_s} : #{@parser_p[sym]==FFI::Pointer::NULL ? 'NULL' : @parser_p[sym].read_string}"
                end
                puts "  strict : #{@parser_p[:strict]}"
                i=0
                while true
                    d = @parser_p.desc_ptr i
                    break if d[:shortname]==0 and d[:longname] == FFI::Pointer::NULL
                    puts "    desc #{d.to_ptr}"
                    puts "     short: #{d[:shortname].chr}" unless d[:shortname]==0
                    puts "     long:  #{d[:longname].read_string}" unless d[:longname]==FFI::Pointer::NULL
                    puts "     help:  #{d[:help].read_string}" unless d[:help]==FFI::Pointer::NULL
                    i+=1
                end
            end
        end
    end
    #
end
#
# EOF
