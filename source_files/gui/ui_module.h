//------------------------------------------------------------------------
//  Custom Mod list
//------------------------------------------------------------------------
//
//  Oblige Level Maker
//
//  Copyright (C) 2006-2016 Andrew Apted
//
//  This program is free software; you can redistribute it and/or
//  modify it under the terms of the GNU General Public License
//  as published by the Free Software Foundation; either version 2
//  of the License, or (at your option) any later version.
//
//  This program is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.
//
//------------------------------------------------------------------------

#ifndef __UI_MODS_H__
#define __UI_MODS_H__

#include <map>
#include <string>

#include "FL/Fl_Check_Button.H"
#include "FL/Fl_Group.H"
#include "FL/Fl_Scrollbar.H"
#include "ui_rchoice.h"

class UI_Module : public Fl_Group {
    friend class UI_CustomMods;

    // NOTES:
    // -  module is "enabled" when mod_button->value() == 1
    // -  module is "shown" when visible() == true

   public:
   
    Fl_Box *heading;
    
    std::map<std::string, UI_RChoice *> choice_map;
    
    std::map<std::string, UI_RSlide *> choice_map_slider;
    
    std::map<std::string, UI_RButton *> choice_map_button;
    
    UI_CustomCheckBox *mod_button;
   
   private:
   
    std::string id_name;

    // only used while positioning the options (as they are added)
    int cur_opt_y;

   public:
    UI_Module(int X, int Y, int W, int H, const char *id, const char *label,
              const char *tip, int red, int green, int blue);
    virtual ~UI_Module();

    void AddOption(const char *option, const char *label, const char *tip,
                   const char* longtip, int gap);

	void AddSliderOption(const char *option, const char *label, const char *tip,
                          const char* longtip, int gap, double min, double max, double inc,
                          const char *units, const char *presets, const char *nan);
                         
    void AddButtonOption(const char *opt, const char *label, const char *tip,
                          const char *longtip, int gap);

    void AddOptionChoice(const char *option, const char *id, const char *label);
    
	void AddOptionSliderChoice(const char *option, double minimum, double maximum,
                                double increment);

    bool SetOption(const char *option, const char *value);
    
    bool SetSliderOption(const char *option, const char *value);
    
    bool SetButtonOption(const char *option, int value);

    bool Is_UI() const;

   public:
    int CalcHeight() const;

    void update_Enable();

    UI_RChoice *FindOpt(const char *opt);  // const;
    
    UI_RSlide *FindSliderOpt(const char *opt);  // const;
    
    UI_RButton *FindButtonOpt(const char *opt);  // const;

   protected:
   private:
    void resize(int X, int Y, int W, int H);

    static void callback_OptChange(Fl_Widget *w, void *data);
    static void callback_PresetCheck(Fl_Widget *w, void *data);
    static void callback_SliderPrevious(Fl_Widget *w, void *data);
    static void callback_SliderNext(Fl_Widget *w, void *data);
    static void callback_ShowHelp(Fl_Widget *w, void *data);
    static void callback_ManualEntry(Fl_Widget *w, void *data);
	static void callback_NanOptions(Fl_Widget *w, void *data);
};

class UI_CustomMods : public Fl_Group {
   
   public:
    Fl_Group *mod_pack;

    Fl_Scrollbar *sbar;
   
   private:
    Fl_Group *mod_pack_group;

    // area occupied by module list
    int mx, my, mw, mh;

    // number of pixels "lost" above the top of the module area
    int offset_y;

    // total height of all shown modules
    int total_h;

   public:
    UI_CustomMods(int X, int Y, int W, int H);
    virtual ~UI_CustomMods();

   public:
    void AddModule(const char *id, const char *label, const char *tip, int red, int green, int blue);

    // these return false if module is unknown
    bool ShowModule(const char *id, bool new_shown);
    bool EnableMod(const char *id, bool enable);

    bool AddOption(const char *module, const char *option, const char *label,
                   const char *tip, const char* longtip, int gap);
                   
	bool AddSliderOption(const char *module, const char *option, const char *label,
                   const char *tip, const char* longtip, int gap, double min, double max, 
                   double inc, const char *units, const char *presets, const char *nan);
                   
    bool AddButtonOption(const char *module, const char *option,
                         const char *label, const char *tip, const char* longtip, int gap);

    void AddOptionChoice(const char *module, const char *option, const char *id,
                         const char *label);

    bool SetOption(const char *module, const char *option, const char *value);
    
    bool SetSliderOption(const char *module, const char *option, const char *value);
    
	bool SetButtonOption(const char *module, const char *option, int value);

    void Locked(bool value);

    UI_Module *FindID(const char *id) const;

   private:
    void PositionAll(UI_Module *focus = NULL);

    void resize(int X, int Y, int W, int H);

    static void callback_Scroll(Fl_Widget *w, void *data);
    static void callback_ModEnable(Fl_Widget *w, void *data);
};

#endif /* __UI_MODS_H__ */

//--- editor settings ---
// vi:ts=4:sw=4:noexpandtab
