//------------------------------------------------------------------------
//  Level Architecture
//------------------------------------------------------------------------
//
//  Oblige Level Maker (C) 2006,2007 Andrew Apted
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

#ifndef __UI_LEVEL_H__
#define __UI_LEVEL_H__

class UI_Level : public Fl_Group
{
public: /// private:

  UI_RChoice *theme;

  UI_RChoice *size;
  UI_RChoice *detail;

  UI_RChoice *heights;
  UI_RChoice *light;


public:
  UI_Level(int x, int y, int w, int h, const char *label = NULL);
  virtual ~UI_Level();

public:

  void Defaults();

  const char *GetAllValues();
  // return a string containing all the values from this panel,
  // in a form suitable for the Config file.
  // The string should NOT be freed.

  bool ParseValue(const char *key, const char *value);
  // parse the name and store the value in the appropriate
  // widget.  Returns false if the key was unknown or the
  // value was invalid.

  void Locked(bool value);

private:

  void setup_Size();
  void setup_Detail();
  void setup_Heights();
  void setup_Light();

  static void callback_Size   (Fl_Widget *, void*);
  static void callback_Theme  (Fl_Widget *, void*);
  static void callback_Detail (Fl_Widget *, void*);
  static void callback_Heights(Fl_Widget *, void*);
  static void callback_Light  (Fl_Widget *, void*);

  static const char * size_syms[];
  static const char * detail_syms[];
  static const char * height_syms[];
  static const char * light_syms[];
};

#endif /* __UI_LEVEL_H__ */

//--- editor settings ---
// vi:ts=2:sw=2:expandtab
