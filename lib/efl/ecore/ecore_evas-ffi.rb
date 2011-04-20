#! /usr/bin/env ruby
# -*- coding: UTF-8 -*-
#
require 'efl/ffi'
#
module Efl
    #
    module Ecore_evas
        def self.method_missing m, *args, &block
            return Efl::API.send 'ecore_evas_'+m.to_s, *args, &block
        end
    end
    #
    module API
        #
        #
        ffi_lib 'ecore'
        #
        # ENUMS
        # typedef enum _Ecore_Evas_Engine_Type {...} Ecore_Evas_Engine_Type;
        enum :ecore_evas_engine_type, [ :ecore_evas_engine_software_buffer, :ecore_evas_engine_software_xlib, :ecore_evas_engine_xrender_x11,
            :ecore_evas_engine_opengl_x11, :ecore_evas_engine_software_xcb, :ecore_evas_engine_xrender_xcb, :ecore_evas_engine_software_gdi,
            :ecore_evas_engine_software_ddraw, :ecore_evas_engine_direct3d, :ecore_evas_engine_opengl_glew, :ecore_evas_engine_cocoa,
            :ecore_evas_engine_software_sdl, :ecore_evas_engine_directfb, :ecore_evas_engine_software_fb, :ecore_evas_engine_software_8_x11,
            :ecore_evas_engine_software_16_x11, :ecore_evas_engine_software_16_ddraw, :ecore_evas_engine_software_16_wince, :ecore_evas_engine_opengl_sdl ]
        # typedef enum _Ecore_Evas_Avoid_Damage_Type {...} Ecore_Evas_Avoid_Damage_Type;
        enum :ecore_evas_avoid_damage_type, [ :ecore_evas_avoid_damage_none, 0, :ecore_evas_avoid_damage_expose, 1, :ecore_evas_avoid_damage_built_in,
            2 ]
        # typedef enum _Ecore_Evas_Object_Associate_Flags {...} Ecore_Evas_Object_Associate_Flags;
        enum :ecore_evas_object_associate_flags, [ :ecore_evas_object_associate_base, 0, :ecore_evas_object_associate_stack, 1,
            :ecore_evas_object_associate_layer, 1, :ecore_evas_object_associate_del, 1 ]
        #
        # TYPEDEFS
        # typedef unsigned int Ecore_X_Window;
        typedef :uint, :ecore_x_window
        # typedef struct _Ecore_DirectFB_Window Ecore_DirectFB_Window;
        typedef :pointer, :ecore_directfb_window
        typedef :pointer, :ecore_directfb_window_p
        # typedef struct _Ecore_Win32_Window Ecore_Win32_Window;
        typedef :pointer, :ecore_win32_window
        typedef :pointer, :ecore_win32_window_p
        # typedef struct _Ecore_WinCE_Window Ecore_WinCE_Window;
        typedef :pointer, :ecore_wince_window
        typedef :pointer, :ecore_wince_window_p
        # typedef struct _Ecore_Evas Ecore_Evas;
        typedef :pointer, :ecore_evas
        typedef :pointer, :ecore_evas_p
        #
        # CALLBACKS
        #
        # FUNCTIONS
        fcts = [
        # EAPI int ecore_evas_engine_type_supported_get(Ecore_Evas_Engine_Type engine);
        [ :ecore_evas_engine_type_supported_get, [ :ecore_evas_engine_type ], :int ],
        # EAPI int ecore_evas_init(void);
        [ :ecore_evas_init, [  ], :int ],
        # EAPI int ecore_evas_shutdown(void);
        [ :ecore_evas_shutdown, [  ], :int ],
        # EAPI void ecore_evas_app_comp_sync_set(Eina_Bool do_sync);
        [ :ecore_evas_app_comp_sync_set, [ :eina_bool ], :void ],
        # EAPI Eina_Bool ecore_evas_app_comp_sync_get(void);
        [ :ecore_evas_app_comp_sync_get, [  ], :eina_bool ],
        # EAPI Eina_List *ecore_evas_engines_get(void);
        [ :ecore_evas_engines_get, [  ], :eina_list_p ],
        # EAPI void ecore_evas_engines_free(Eina_List *engines);
        [ :ecore_evas_engines_free, [ :eina_list_p ], :void ],
        # EAPI Ecore_Evas *ecore_evas_new(const char *engine_name, int x, int y, int w, int h, const char *extra_options);
        [ :ecore_evas_new, [ :string, :int, :int, :int, :int, :string ], :ecore_evas_p ],
        # EAPI Ecore_Evas *ecore_evas_software_x11_new(const char *disp_name, Ecore_X_Window parent, int x, int y, int w, int h);
        [ :ecore_evas_software_x11_new, [ :string, :uint, :int, :int, :int, :int ], :ecore_evas_p ],
        # EAPI Ecore_X_Window ecore_evas_software_x11_window_get(const Ecore_Evas *ee);
        [ :ecore_evas_software_x11_window_get, [ :ecore_evas_p ], :uint ],
        # EAPI void ecore_evas_software_x11_direct_resize_set(Ecore_Evas *ee, Eina_Bool on);
        [ :ecore_evas_software_x11_direct_resize_set, [ :ecore_evas_p, :eina_bool ], :void ],
        # EAPI Eina_Bool ecore_evas_software_x11_direct_resize_get(const Ecore_Evas *ee);
        [ :ecore_evas_software_x11_direct_resize_get, [ :ecore_evas_p ], :eina_bool ],
        # EAPI void ecore_evas_software_x11_extra_event_window_add(Ecore_Evas *ee, Ecore_X_Window win);
        [ :ecore_evas_software_x11_extra_event_window_add, [ :ecore_evas_p, :uint ], :void ],
        # EAPI Ecore_Evas *ecore_evas_gl_x11_new(const char *disp_name, Ecore_X_Window parent, int x, int y, int w, int h);
        [ :ecore_evas_gl_x11_new, [ :string, :uint, :int, :int, :int, :int ], :ecore_evas_p ],
        # EAPI Ecore_Evas *ecore_evas_gl_x11_options_new(const char *disp_name, Ecore_X_Window parent, int x, int y, int w, int h, const int *opt);
        [ :ecore_evas_gl_x11_options_new, [ :string, :uint, :int, :int, :int, :int, :int_p ], :ecore_evas_p ],
        # EAPI Ecore_X_Window ecore_evas_gl_x11_window_get(const Ecore_Evas *ee);
        [ :ecore_evas_gl_x11_window_get, [ :ecore_evas_p ], :uint ],
        # EAPI void ecore_evas_gl_x11_direct_resize_set(Ecore_Evas *ee, Eina_Bool on);
        [ :ecore_evas_gl_x11_direct_resize_set, [ :ecore_evas_p, :eina_bool ], :void ],
        # EAPI Eina_Bool ecore_evas_gl_x11_direct_resize_get(const Ecore_Evas *ee);
        [ :ecore_evas_gl_x11_direct_resize_get, [ :ecore_evas_p ], :eina_bool ],
        # EAPI void ecore_evas_gl_x11_extra_event_window_add(Ecore_Evas *ee, Ecore_X_Window win);
        [ :ecore_evas_gl_x11_extra_event_window_add, [ :ecore_evas_p, :uint ], :void ],
        # EAPI void ecore_evas_gl_x11_pre_post_swap_callback_set(const Ecore_Evas *ee, void *data, void (*pre_cb) (void *data, Evas *e), void (*post_cb) (void *data, Evas *e));
        # FIXME
        # EAPI Ecore_Evas *ecore_evas_xrender_x11_new(const char *disp_name, Ecore_X_Window parent, int x, int y, int w, int h);
        [ :ecore_evas_xrender_x11_new, [ :string, :uint, :int, :int, :int, :int ], :ecore_evas_p ],
        # EAPI Ecore_X_Window ecore_evas_xrender_x11_window_get(const Ecore_Evas *ee);
        [ :ecore_evas_xrender_x11_window_get, [ :ecore_evas_p ], :uint ],
        # EAPI void ecore_evas_xrender_x11_direct_resize_set(Ecore_Evas *ee, Eina_Bool on);
        [ :ecore_evas_xrender_x11_direct_resize_set, [ :ecore_evas_p, :eina_bool ], :void ],
        # EAPI Eina_Bool ecore_evas_xrender_x11_direct_resize_get(const Ecore_Evas *ee);
        [ :ecore_evas_xrender_x11_direct_resize_get, [ :ecore_evas_p ], :eina_bool ],
        # EAPI void ecore_evas_xrender_x11_extra_event_window_add(Ecore_Evas *ee, Ecore_X_Window win);
        [ :ecore_evas_xrender_x11_extra_event_window_add, [ :ecore_evas_p, :uint ], :void ],
        # EAPI Ecore_Evas *ecore_evas_software_x11_8_new(const char *disp_name, Ecore_X_Window parent, int x, int y, int w, int h);
        [ :ecore_evas_software_x11_8_new, [ :string, :uint, :int, :int, :int, :int ], :ecore_evas_p ],
        # EAPI Ecore_X_Window ecore_evas_software_x11_8_window_get(const Ecore_Evas *ee);
        [ :ecore_evas_software_x11_8_window_get, [ :ecore_evas_p ], :uint ],
        # EAPI Ecore_X_Window ecore_evas_software_x11_8_subwindow_get(const Ecore_Evas *ee);
        [ :ecore_evas_software_x11_8_subwindow_get, [ :ecore_evas_p ], :uint ],
        # EAPI void ecore_evas_software_x11_8_direct_resize_set(Ecore_Evas *ee, Eina_Bool on);
        [ :ecore_evas_software_x11_8_direct_resize_set, [ :ecore_evas_p, :eina_bool ], :void ],
        # EAPI Eina_Bool ecore_evas_software_x11_8_direct_resize_get(const Ecore_Evas *ee);
        [ :ecore_evas_software_x11_8_direct_resize_get, [ :ecore_evas_p ], :eina_bool ],
        # EAPI void ecore_evas_software_x11_8_extra_event_window_add(Ecore_Evas *ee, Ecore_X_Window win);
        [ :ecore_evas_software_x11_8_extra_event_window_add, [ :ecore_evas_p, :uint ], :void ],
        # EAPI Ecore_Evas *ecore_evas_software_x11_16_new(const char *disp_name, Ecore_X_Window parent, int x, int y, int w, int h);
        [ :ecore_evas_software_x11_16_new, [ :string, :uint, :int, :int, :int, :int ], :ecore_evas_p ],
        # EAPI Ecore_X_Window ecore_evas_software_x11_16_window_get(const Ecore_Evas *ee);
        [ :ecore_evas_software_x11_16_window_get, [ :ecore_evas_p ], :uint ],
        # EAPI void ecore_evas_software_x11_16_direct_resize_set(Ecore_Evas *ee, Eina_Bool on);
        [ :ecore_evas_software_x11_16_direct_resize_set, [ :ecore_evas_p, :eina_bool ], :void ],
        # EAPI Eina_Bool ecore_evas_software_x11_16_direct_resize_get(const Ecore_Evas *ee);
        [ :ecore_evas_software_x11_16_direct_resize_get, [ :ecore_evas_p ], :eina_bool ],
        # EAPI void ecore_evas_software_x11_16_extra_event_window_add(Ecore_Evas *ee, Ecore_X_Window win);
        [ :ecore_evas_software_x11_16_extra_event_window_add, [ :ecore_evas_p, :uint ], :void ],
        # EAPI Ecore_Evas *ecore_evas_fb_new(const char *disp_name, int rotation, int w, int h);
        [ :ecore_evas_fb_new, [ :string, :int, :int, :int ], :ecore_evas_p ],
        # EAPI Ecore_Evas *ecore_evas_directfb_new(const char *disp_name, int windowed, int x, int y, int w, int h);
        [ :ecore_evas_directfb_new, [ :string, :int, :int, :int, :int, :int ], :ecore_evas_p ],
        # EAPI Ecore_DirectFB_Window *ecore_evas_directfb_window_get(const Ecore_Evas *ee);
        [ :ecore_evas_directfb_window_get, [ :ecore_evas_p ], :ecore_directfb_window_p ],
        # EAPI Ecore_Evas *ecore_evas_buffer_new(int w, int h);
        [ :ecore_evas_buffer_new, [ :int, :int ], :ecore_evas_p ],
        # EAPI Ecore_Evas *ecore_evas_buffer_allocfunc_new(int w, int h, void *(*alloc_func) (void *data, int size), void (*free_func) (void *data, void *pix), const void *data);
        # FIXME
        # EAPI const void *ecore_evas_buffer_pixels_get(Ecore_Evas *ee);
        [ :ecore_evas_buffer_pixels_get, [ :ecore_evas_p ], :void_p ],
        # EAPI Evas_Object *ecore_evas_object_image_new(Ecore_Evas *ee_target);
        [ :ecore_evas_object_image_new, [ :ecore_evas_p ], :evas_object_p ],
        # EAPI Ecore_Evas *ecore_evas_object_ecore_evas_get(Evas_Object *obj);
        [ :ecore_evas_object_ecore_evas_get, [ :evas_object_p ], :ecore_evas_p ],
        # EAPI Evas *ecore_evas_object_evas_get(Evas_Object *obj);
        [ :ecore_evas_object_evas_get, [ :evas_object_p ], :evas_p ],
        # EAPI Ecore_Evas *ecore_evas_software_gdi_new(Ecore_Win32_Window *parent, int x, int y, int width, int height);
        [ :ecore_evas_software_gdi_new, [ :ecore_win32_window_p, :int, :int, :int, :int ], :ecore_evas_p ],
        # EAPI Ecore_Evas *ecore_evas_software_ddraw_new(Ecore_Win32_Window *parent, int x, int y, int width, int height);
        [ :ecore_evas_software_ddraw_new, [ :ecore_win32_window_p, :int, :int, :int, :int ], :ecore_evas_p ],
        # EAPI Ecore_Evas *ecore_evas_software_16_ddraw_new(Ecore_Win32_Window *parent, int x, int y, int width, int height);
        [ :ecore_evas_software_16_ddraw_new, [ :ecore_win32_window_p, :int, :int, :int, :int ], :ecore_evas_p ],
        # EAPI Ecore_Evas *ecore_evas_direct3d_new(Ecore_Win32_Window *parent, int x, int y, int width, int height);
        [ :ecore_evas_direct3d_new, [ :ecore_win32_window_p, :int, :int, :int, :int ], :ecore_evas_p ],
        # EAPI Ecore_Evas *ecore_evas_gl_glew_new(Ecore_Win32_Window *parent, int x, int y, int width, int height);
        [ :ecore_evas_gl_glew_new, [ :ecore_win32_window_p, :int, :int, :int, :int ], :ecore_evas_p ],
        # EAPI Ecore_Win32_Window *ecore_evas_win32_window_get(const Ecore_Evas *ee);
        [ :ecore_evas_win32_window_get, [ :ecore_evas_p ], :ecore_win32_window_p ],
        # EAPI Ecore_Evas *ecore_evas_sdl_new(const char* name, int w, int h, int fullscreen, int hwsurface, int noframe, int alpha);
        [ :ecore_evas_sdl_new, [ :string, :int, :int, :int, :int, :int, :int ], :ecore_evas_p ],
        # EAPI Ecore_Evas *ecore_evas_sdl16_new(const char* name, int w, int h, int fullscreen, int hwsurface, int noframe, int alpha);
        [ :ecore_evas_sdl16_new, [ :string, :int, :int, :int, :int, :int, :int ], :ecore_evas_p ],
        # EAPI Ecore_Evas *ecore_evas_gl_sdl_new(const char* name, int w, int h, int fullscreen, int noframe);
        [ :ecore_evas_gl_sdl_new, [ :string, :int, :int, :int, :int ], :ecore_evas_p ],
        # EAPI Ecore_Evas *ecore_evas_software_wince_new(Ecore_WinCE_Window *parent, int x, int y, int width, int height);
        [ :ecore_evas_software_wince_new, [ :ecore_wince_window_p, :int, :int, :int, :int ], :ecore_evas_p ],
        # EAPI Ecore_Evas *ecore_evas_software_wince_fb_new(Ecore_WinCE_Window *parent, int x, int y, int width, int height);
        [ :ecore_evas_software_wince_fb_new, [ :ecore_wince_window_p, :int, :int, :int, :int ], :ecore_evas_p ],
        # EAPI Ecore_Evas *ecore_evas_software_wince_gapi_new(Ecore_WinCE_Window *parent, int x, int y, int width, int height);
        [ :ecore_evas_software_wince_gapi_new, [ :ecore_wince_window_p, :int, :int, :int, :int ], :ecore_evas_p ],
        # EAPI Ecore_Evas *ecore_evas_software_wince_ddraw_new(Ecore_WinCE_Window *parent, int x, int y, int width, int height);
        [ :ecore_evas_software_wince_ddraw_new, [ :ecore_wince_window_p, :int, :int, :int, :int ], :ecore_evas_p ],
        # EAPI Ecore_Evas *ecore_evas_software_wince_gdi_new(Ecore_WinCE_Window *parent, int x, int y, int width, int height);
        [ :ecore_evas_software_wince_gdi_new, [ :ecore_wince_window_p, :int, :int, :int, :int ], :ecore_evas_p ],
        # EAPI Ecore_WinCE_Window *ecore_evas_software_wince_window_get(const Ecore_Evas *ee);
        [ :ecore_evas_software_wince_window_get, [ :ecore_evas_p ], :ecore_wince_window_p ],
        # EAPI Ecore_Evas *ecore_evas_cocoa_new(const char* name, int w, int h);
        [ :ecore_evas_cocoa_new, [ :string, :int, :int ], :ecore_evas_p ],
        # EAPI const char *ecore_evas_engine_name_get(const Ecore_Evas *ee);
        [ :ecore_evas_engine_name_get, [ :ecore_evas_p ], :string ],
        # EAPI Ecore_Evas *ecore_evas_ecore_evas_get(const Evas *e);
        [ :ecore_evas_ecore_evas_get, [ :evas_p ], :ecore_evas_p ],
        # EAPI void ecore_evas_free(Ecore_Evas *ee);
        [ :ecore_evas_free, [ :ecore_evas_p ], :void ],
        # EAPI void *ecore_evas_data_get(const Ecore_Evas *ee, const char *key);
        [ :ecore_evas_data_get, [ :ecore_evas_p, :string ], :void_p ],
        # EAPI void ecore_evas_data_set(Ecore_Evas *ee, const char *key, const void *data);
        [ :ecore_evas_data_set, [ :ecore_evas_p, :string, :void_p ], :void ],
        # EAPI void ecore_evas_callback_resize_set(Ecore_Evas *ee, void (*func) (Ecore_Evas *ee));
        # FIXME
        # EAPI void ecore_evas_callback_move_set(Ecore_Evas *ee, void (*func) (Ecore_Evas *ee));
        # FIXME
        # EAPI void ecore_evas_callback_show_set(Ecore_Evas *ee, void (*func) (Ecore_Evas *ee));
        # FIXME
        # EAPI void ecore_evas_callback_hide_set(Ecore_Evas *ee, void (*func) (Ecore_Evas *ee));
        # FIXME
        # EAPI void ecore_evas_callback_delete_request_set(Ecore_Evas *ee, void (*func) (Ecore_Evas *ee));
        # FIXME
        # EAPI void ecore_evas_callback_destroy_set(Ecore_Evas *ee, void (*func) (Ecore_Evas *ee));
        # FIXME
        # EAPI void ecore_evas_callback_focus_in_set(Ecore_Evas *ee, void (*func) (Ecore_Evas *ee));
        # FIXME
        # EAPI void ecore_evas_callback_focus_out_set(Ecore_Evas *ee, void (*func) (Ecore_Evas *ee));
        # FIXME
        # EAPI void ecore_evas_callback_sticky_set(Ecore_Evas *ee, void (*func) (Ecore_Evas *ee));
        # FIXME
        # EAPI void ecore_evas_callback_unsticky_set(Ecore_Evas *ee, void (*func) (Ecore_Evas *ee));
        # FIXME
        # EAPI void ecore_evas_callback_mouse_in_set(Ecore_Evas *ee, void (*func) (Ecore_Evas *ee));
        # FIXME
        # EAPI void ecore_evas_callback_mouse_out_set(Ecore_Evas *ee, void (*func) (Ecore_Evas *ee));
        # FIXME
        # EAPI void ecore_evas_callback_pre_render_set(Ecore_Evas *ee, void (*func) (Ecore_Evas *ee));
        # FIXME
        # EAPI void ecore_evas_callback_post_render_set(Ecore_Evas *ee, void (*func) (Ecore_Evas *ee));
        # FIXME
        # EAPI void ecore_evas_callback_pre_free_set(Ecore_Evas *ee, void (*func) (Ecore_Evas *ee));
        # FIXME
        # EAPI Evas *ecore_evas_get(const Ecore_Evas *ee);
        [ :ecore_evas_get, [ :ecore_evas_p ], :evas_p ],
        # EAPI void ecore_evas_move(Ecore_Evas *ee, int x, int y);
        [ :ecore_evas_move, [ :ecore_evas_p, :int, :int ], :void ],
        # EAPI void ecore_evas_managed_move(Ecore_Evas *ee, int x, int y);
        [ :ecore_evas_managed_move, [ :ecore_evas_p, :int, :int ], :void ],
        # EAPI void ecore_evas_resize(Ecore_Evas *ee, int w, int h);
        [ :ecore_evas_resize, [ :ecore_evas_p, :int, :int ], :void ],
        # EAPI void ecore_evas_move_resize(Ecore_Evas *ee, int x, int y, int w, int h);
        [ :ecore_evas_move_resize, [ :ecore_evas_p, :int, :int, :int, :int ], :void ],
        # EAPI void ecore_evas_geometry_get(const Ecore_Evas *ee, int *x, int *y, int *w, int *h);
        [ :ecore_evas_geometry_get, [ :ecore_evas_p, :int_p, :int_p, :int_p, :int_p ], :void ],
        # EAPI void ecore_evas_rotation_set(Ecore_Evas *ee, int rot);
        [ :ecore_evas_rotation_set, [ :ecore_evas_p, :int ], :void ],
        # EAPI void ecore_evas_rotation_with_resize_set(Ecore_Evas *ee, int rot);
        [ :ecore_evas_rotation_with_resize_set, [ :ecore_evas_p, :int ], :void ],
        # EAPI int ecore_evas_rotation_get(const Ecore_Evas *ee);
        [ :ecore_evas_rotation_get, [ :ecore_evas_p ], :int ],
        # EAPI void ecore_evas_shaped_set(Ecore_Evas *ee, Eina_Bool shaped);
        [ :ecore_evas_shaped_set, [ :ecore_evas_p, :eina_bool ], :void ],
        # EAPI Eina_Bool ecore_evas_shaped_get(const Ecore_Evas *ee);
        [ :ecore_evas_shaped_get, [ :ecore_evas_p ], :eina_bool ],
        # EAPI void ecore_evas_alpha_set(Ecore_Evas *ee, Eina_Bool alpha);
        [ :ecore_evas_alpha_set, [ :ecore_evas_p, :eina_bool ], :void ],
        # EAPI Eina_Bool ecore_evas_alpha_get(const Ecore_Evas *ee);
        [ :ecore_evas_alpha_get, [ :ecore_evas_p ], :eina_bool ],
        # EAPI void ecore_evas_transparent_set(Ecore_Evas *ee, Eina_Bool transparent);
        [ :ecore_evas_transparent_set, [ :ecore_evas_p, :eina_bool ], :void ],
        # EAPI Eina_Bool ecore_evas_transparent_get(const Ecore_Evas *ee);
        [ :ecore_evas_transparent_get, [ :ecore_evas_p ], :eina_bool ],
        # EAPI void ecore_evas_show(Ecore_Evas *ee);
        [ :ecore_evas_show, [ :ecore_evas_p ], :void ],
        # EAPI void ecore_evas_hide(Ecore_Evas *ee);
        [ :ecore_evas_hide, [ :ecore_evas_p ], :void ],
        # EAPI int ecore_evas_visibility_get(const Ecore_Evas *ee);
        [ :ecore_evas_visibility_get, [ :ecore_evas_p ], :int ],
        # EAPI void ecore_evas_raise(Ecore_Evas *ee);
        [ :ecore_evas_raise, [ :ecore_evas_p ], :void ],
        # EAPI void ecore_evas_lower(Ecore_Evas *ee);
        [ :ecore_evas_lower, [ :ecore_evas_p ], :void ],
        # EAPI void ecore_evas_activate(Ecore_Evas *ee);
        [ :ecore_evas_activate, [ :ecore_evas_p ], :void ],
        # EAPI void ecore_evas_title_set(Ecore_Evas *ee, const char *t);
        [ :ecore_evas_title_set, [ :ecore_evas_p, :string ], :void ],
        # EAPI const char *ecore_evas_title_get(const Ecore_Evas *ee);
        [ :ecore_evas_title_get, [ :ecore_evas_p ], :string ],
        # EAPI void ecore_evas_name_class_set(Ecore_Evas *ee, const char *n, const char *c);
        [ :ecore_evas_name_class_set, [ :ecore_evas_p, :string, :string ], :void ],
        # EAPI void ecore_evas_name_class_get(const Ecore_Evas *ee, const char **n, const char **c);
        [ :ecore_evas_name_class_get, [ :ecore_evas_p, :string_array, :string_array ], :void ],
        # EAPI void ecore_evas_size_min_set(Ecore_Evas *ee, int w, int h);
        [ :ecore_evas_size_min_set, [ :ecore_evas_p, :int, :int ], :void ],
        # EAPI void ecore_evas_size_min_get(const Ecore_Evas *ee, int *w, int *h);
        [ :ecore_evas_size_min_get, [ :ecore_evas_p, :int_p, :int_p ], :void ],
        # EAPI void ecore_evas_size_max_set(Ecore_Evas *ee, int w, int h);
        [ :ecore_evas_size_max_set, [ :ecore_evas_p, :int, :int ], :void ],
        # EAPI void ecore_evas_size_max_get(const Ecore_Evas *ee, int *w, int *h);
        [ :ecore_evas_size_max_get, [ :ecore_evas_p, :int_p, :int_p ], :void ],
        # EAPI void ecore_evas_size_base_set(Ecore_Evas *ee, int w, int h);
        [ :ecore_evas_size_base_set, [ :ecore_evas_p, :int, :int ], :void ],
        # EAPI void ecore_evas_size_base_get(const Ecore_Evas *ee, int *w, int *h);
        [ :ecore_evas_size_base_get, [ :ecore_evas_p, :int_p, :int_p ], :void ],
        # EAPI void ecore_evas_size_step_set(Ecore_Evas *ee, int w, int h);
        [ :ecore_evas_size_step_set, [ :ecore_evas_p, :int, :int ], :void ],
        # EAPI void ecore_evas_size_step_get(const Ecore_Evas *ee, int *w, int *h);
        [ :ecore_evas_size_step_get, [ :ecore_evas_p, :int_p, :int_p ], :void ],
        # EAPI void ecore_evas_cursor_set(Ecore_Evas *ee, const char *file, int layer, int hot_x, int hot_y);
        [ :ecore_evas_cursor_set, [ :ecore_evas_p, :string, :int, :int, :int ], :void ],
        # EAPI void ecore_evas_object_cursor_set(Ecore_Evas *ee, Evas_Object *obj, int layer, int hot_x, int hot_y);
        [ :ecore_evas_object_cursor_set, [ :ecore_evas_p, :evas_object_p, :int, :int, :int ], :void ],
        # EAPI void ecore_evas_cursor_get(const Ecore_Evas *ee, Evas_Object **obj, int *layer, int *hot_x, int *hot_y);
        [ :ecore_evas_cursor_get, [ :ecore_evas_p, :evas_object_pp, :int_p, :int_p, :int_p ], :void ],
        # EAPI void ecore_evas_layer_set(Ecore_Evas *ee, int layer);
        [ :ecore_evas_layer_set, [ :ecore_evas_p, :int ], :void ],
        # EAPI int ecore_evas_layer_get(const Ecore_Evas *ee);
        [ :ecore_evas_layer_get, [ :ecore_evas_p ], :int ],
        # EAPI void ecore_evas_focus_set(Ecore_Evas *ee, Eina_Bool on);
        [ :ecore_evas_focus_set, [ :ecore_evas_p, :eina_bool ], :void ],
        # EAPI Eina_Bool ecore_evas_focus_get(const Ecore_Evas *ee);
        [ :ecore_evas_focus_get, [ :ecore_evas_p ], :eina_bool ],
        # EAPI void ecore_evas_iconified_set(Ecore_Evas *ee, Eina_Bool on);
        [ :ecore_evas_iconified_set, [ :ecore_evas_p, :eina_bool ], :void ],
        # EAPI Eina_Bool ecore_evas_iconified_get(const Ecore_Evas *ee);
        [ :ecore_evas_iconified_get, [ :ecore_evas_p ], :eina_bool ],
        # EAPI void ecore_evas_borderless_set(Ecore_Evas *ee, Eina_Bool on);
        [ :ecore_evas_borderless_set, [ :ecore_evas_p, :eina_bool ], :void ],
        # EAPI Eina_Bool ecore_evas_borderless_get(const Ecore_Evas *ee);
        [ :ecore_evas_borderless_get, [ :ecore_evas_p ], :eina_bool ],
        # EAPI void ecore_evas_override_set(Ecore_Evas *ee, Eina_Bool on);
        [ :ecore_evas_override_set, [ :ecore_evas_p, :eina_bool ], :void ],
        # EAPI Eina_Bool ecore_evas_override_get(const Ecore_Evas *ee);
        [ :ecore_evas_override_get, [ :ecore_evas_p ], :eina_bool ],
        # EAPI void ecore_evas_maximized_set(Ecore_Evas *ee, Eina_Bool on);
        [ :ecore_evas_maximized_set, [ :ecore_evas_p, :eina_bool ], :void ],
        # EAPI Eina_Bool ecore_evas_maximized_get(const Ecore_Evas *ee);
        [ :ecore_evas_maximized_get, [ :ecore_evas_p ], :eina_bool ],
        # EAPI void ecore_evas_fullscreen_set(Ecore_Evas *ee, Eina_Bool on);
        [ :ecore_evas_fullscreen_set, [ :ecore_evas_p, :eina_bool ], :void ],
        # EAPI Eina_Bool ecore_evas_fullscreen_get(const Ecore_Evas *ee);
        [ :ecore_evas_fullscreen_get, [ :ecore_evas_p ], :eina_bool ],
        # EAPI void ecore_evas_avoid_damage_set(Ecore_Evas *ee, Ecore_Evas_Avoid_Damage_Type on);
        [ :ecore_evas_avoid_damage_set, [ :ecore_evas_p, :ecore_evas_avoid_damage_type ], :void ],
        # EAPI Ecore_Evas_Avoid_Damage_Type ecore_evas_avoid_damage_get(const Ecore_Evas *ee);
        [ :ecore_evas_avoid_damage_get, [ :ecore_evas_p ], :ecore_evas_avoid_damage_type ],
        # EAPI void ecore_evas_withdrawn_set(Ecore_Evas *ee, Eina_Bool withdrawn);
        [ :ecore_evas_withdrawn_set, [ :ecore_evas_p, :eina_bool ], :void ],
        # EAPI Eina_Bool ecore_evas_withdrawn_get(const Ecore_Evas *ee);
        [ :ecore_evas_withdrawn_get, [ :ecore_evas_p ], :eina_bool ],
        # EAPI void ecore_evas_sticky_set(Ecore_Evas *ee, Eina_Bool sticky);
        [ :ecore_evas_sticky_set, [ :ecore_evas_p, :eina_bool ], :void ],
        # EAPI Eina_Bool ecore_evas_sticky_get(const Ecore_Evas *ee);
        [ :ecore_evas_sticky_get, [ :ecore_evas_p ], :eina_bool ],
        # EAPI void ecore_evas_ignore_events_set(Ecore_Evas *ee, Eina_Bool ignore);
        [ :ecore_evas_ignore_events_set, [ :ecore_evas_p, :eina_bool ], :void ],
        # EAPI Eina_Bool ecore_evas_ignore_events_get(const Ecore_Evas *ee);
        [ :ecore_evas_ignore_events_get, [ :ecore_evas_p ], :eina_bool ],
        # EAPI void ecore_evas_manual_render_set(Ecore_Evas *ee, Eina_Bool manual_render);
        [ :ecore_evas_manual_render_set, [ :ecore_evas_p, :eina_bool ], :void ],
        # EAPI Eina_Bool ecore_evas_manual_render_get(const Ecore_Evas *ee);
        [ :ecore_evas_manual_render_get, [ :ecore_evas_p ], :eina_bool ],
        # EAPI void ecore_evas_manual_render(Ecore_Evas *ee);
        [ :ecore_evas_manual_render, [ :ecore_evas_p ], :void ],
        # EAPI void ecore_evas_comp_sync_set(Ecore_Evas *ee, Eina_Bool do_sync);
        [ :ecore_evas_comp_sync_set, [ :ecore_evas_p, :eina_bool ], :void ],
        # EAPI Eina_Bool ecore_evas_comp_sync_get(const Ecore_Evas *ee);
        [ :ecore_evas_comp_sync_get, [ :ecore_evas_p ], :eina_bool ],
        # EAPI Ecore_Window ecore_evas_window_get(const Ecore_Evas *ee);
        [ :ecore_evas_window_get, [ :ecore_evas_p ], :uintptr_t ],
        # EAPI Eina_Bool ecore_evas_object_associate(Ecore_Evas *ee, Evas_Object *obj, Ecore_Evas_Object_Associate_Flags flags);
        [ :ecore_evas_object_associate, [ :ecore_evas_p, :evas_object_p, :ecore_evas_object_associate_flags ], :eina_bool ],
        # EAPI Eina_Bool ecore_evas_object_dissociate(Ecore_Evas *ee, Evas_Object *obj);
        [ :ecore_evas_object_dissociate, [ :ecore_evas_p, :evas_object_p ], :eina_bool ],
        # EAPI Evas_Object *ecore_evas_object_associate_get(const Ecore_Evas *ee);
        [ :ecore_evas_object_associate_get, [ :ecore_evas_p ], :evas_object_p ],
        # EAPI unsigned char ecore_getopt_callback_ecore_evas_list_engines(const Ecore_Getopt *parser, const Ecore_Getopt_Desc *desc, const char *str, void *data, Ecore_Getopt_Value *storage);
        [ :ecore_getopt_callback_ecore_evas_list_engines, [ :ecore_getopt_p, :ecore_getopt_desc_p, :string, :void_p, :ecore_getopt_value_p ], :uchar
            ],
        # EAPI Eina_List *ecore_evas_ecore_evas_list_get(void);
        [ :ecore_evas_ecore_evas_list_get, [  ], :eina_list_p ],
        # EAPI void ecore_evas_x11_leader_set(Ecore_Evas *ee, Ecore_X_Window win);
        [ :ecore_evas_x11_leader_set, [ :ecore_evas_p, :uint ], :void ],
        # EAPI Ecore_X_Window ecore_evas_x11_leader_get(Ecore_Evas *ee);
        [ :ecore_evas_x11_leader_get, [ :ecore_evas_p ], :uint ],
        # EAPI void ecore_evas_x11_leader_default_set(Ecore_Evas *ee);
        [ :ecore_evas_x11_leader_default_set, [ :ecore_evas_p ], :void ],
        # EAPI void ecore_evas_x11_shape_input_rectangle_set(Ecore_Evas *ee, int x, int y, int w, int h);
        [ :ecore_evas_x11_shape_input_rectangle_set, [ :ecore_evas_p, :int, :int, :int, :int ], :void ],
        # EAPI void ecore_evas_x11_shape_input_rectangle_add(Ecore_Evas *ee, int x, int y, int w, int h);
        [ :ecore_evas_x11_shape_input_rectangle_add, [ :ecore_evas_p, :int, :int, :int, :int ], :void ],
        # EAPI void ecore_evas_x11_shape_input_rectangle_subtract(Ecore_Evas *ee, int x, int y, int w, int h);
        [ :ecore_evas_x11_shape_input_rectangle_subtract, [ :ecore_evas_p, :int, :int, :int, :int ], :void ],
        # EAPI void ecore_evas_x11_shape_input_empty(Ecore_Evas *ee);
        [ :ecore_evas_x11_shape_input_empty, [ :ecore_evas_p ], :void ],
        # EAPI void ecore_evas_x11_shape_input_reset(Ecore_Evas *ee);
        [ :ecore_evas_x11_shape_input_reset, [ :ecore_evas_p ], :void ],
        # EAPI void ecore_evas_x11_shape_input_apply(Ecore_Evas *ee);
        [ :ecore_evas_x11_shape_input_apply, [ :ecore_evas_p ], :void ],
        ]
        #
        attach_fcts fcts
    end
end
#
# EOF
