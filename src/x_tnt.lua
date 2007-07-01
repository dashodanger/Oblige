----------------------------------------------------------------
-- GAME DEF : TNT Evilution (Final DOOM)
----------------------------------------------------------------
--
--  Oblige Level Maker (C) 2006,2007 Andrew Apted
--
--  This program is free software; you can redistribute it and/or
--  modify it under the terms of the GNU General Public License
--  as published by the Free Software Foundation; either version 2
--  of the License, or (at your option) any later version.
--
--  This program is distributed in the hope that it will be useful,
--  but WITHOUT ANY WARRANTY; without even the implied warranty of
--  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
--  GNU General Public License for more details.
--
----------------------------------------------------------------

TN_RAILS =
{
  r_3 = { wall="TYIRONSM", w=64,  h=72  },
  r_4 = { wall="TYIRONLG", w=128, h=128 },
}

TN_CRATES =
{
  WOOD_L6 =
  {
    wall = "CRLWDL6", h=64, floor = "FLOOR4_1",
  },
  
  WOOD_L6C =
  {
    wall = "CRLWDL6C", h=64, floor = "FLAT5_5",
  },
  
  WOOD_H =
  {
    wall = "CRWDH64", h=128, floor = "FLAT5_2",
  },

  WOOD_LA =
  {
    wall = "CRWDL64A", h=128, floor = "FLOOR7_1",
  },

  WOOD_BH =
  {
    wall = "CRBLWDH6", h=128, floor = "FLAT5_5",
  },

}

TN_WALL_LIGHTS =
{
  br_grn = { wall="LITEGRN1", w=32 },
  br_red = { wall="LITERED1", w=32 },
  br_yel = { wall="LITEYEL1", w=32 },
}

TN_DOORS =
{
--[[ !!!! FIXME
  d_metal = { wall="METALDR", w=128, h=128 },
--]]
}

TN_PICS =
{
  egypt1 = { wall="BIGWALL",  w=128, h=128 },
  egypt2 = { wall="LONGWALL", w=128, h=128 },
  egypt3 = { wall="MURAL1",   w=128, h=128 },
  egypt4 = { wall="MURAL2",   w=128, h=128 },

  tnt1   = { wall="TNTDOOR",  w=128, h=128 },
  disast = { wall="DISASTER", w=128, h=128 },
  gr_men = { wall="GRNMEN",   w=128, h=128 },
  lt_yel = { wall="LITEYEL3", w=128, h=128, glow=true },
}

TN_COMBOS =
{
  URBAN_EGYPT =
  {
    theme_probs = { URBAN=9999 }, --!!!
    mat_pri = 8,

    wall  = "BIGWALL",
    floor = "FLOOR0_2",
    ceil  = "FLOOR0_2", -- "FLAT1_2",
    step  = "BRICK2",

    sc_fabs = { pillar_rnd_DRSIDE1=50, pillar_rnd_DRSIDE2=50, other=3 },

    wall_fabs = { wall_pic_MURAL1=50, wall_pic_MURAL2=50, other=3 },
  },

  URBAN_STONEW1 =
  {
    theme_probs = { URBAN=1 }, --!!!
    mat_pri = 5,

    wall  = "STONEW1",
    floor = "RROCK11",
    ceil  = "FLAT10",
    step  = "STEP6",
  },
}

TN_SCENERY_PREFABS =
{
  --!!!! FIXME: crates

  pillar_rnd_DRSIDE1 =
  {
    prefab = "PILLAR_ROUND_SMALL",
    add_mode = "island",
    environment = "indoor",
    skin = { wall="DRSIDE1" },
  },

  pillar_rnd_DRSIDE2 =
  {
    prefab = "PILLAR_ROUND_SMALL",
    add_mode = "island",
    environment = "indoor",
    skin = { wall="DRSIDE2" },
  },

}

TN_WALL_PREFABS =
{
  wall_pic_DISASTER =
  {
    prefab = "WALL_PIC",
    min_height = 160,
    skin = { pic_w="DISASTER", pic_h=128 },
    prob = 10,
  },

  wall_pic_MURAL1 =
  {
    prefab = "WALL_PIC_SHALLOW",
    min_height = 160,
    skin = { pic_w="MURAL1", pic_h=128 },
    prob = 0.5,
  },

  wall_pic_MURAL2 =
  {
    prefab = "WALL_PIC_SHALLOW",
    min_height = 160,
    skin = { pic_w="MURAL2", pic_h=128 },
    prob = 0.5,
  },

  --!!!! FIXME: lights (yel/red -> TECH, grn -> INDY)
}

TN_SKY_INFO =
{
  { color="brown",  light=192 },
  { color="black",  light=160 },
  { color="red",    light=192 },
}

----------------------------------------------------------------

GAME_FACTORIES["tnt"] = function()

  local T = GAME_FACTORIES.doom2()

  T.rails   = copy_and_merge(T.rails,  TN_RAILS)

---##  T.crates  = copy_and_merge(T.crates, TN_CRATES)
---##  T.doors   = copy_and_merge(T.doors,  TN_DOORS)
---##  T.pics    = copy_and_merge(T.pics,   TN_PICS)
---##  T.wall_lights = copy_and_merge(T.wall_lights, TN_WALL_LIGHTS)

  T.combos = copy_and_merge(T.combos, TN_COMBOS)

  T.sc_fabs   = copy_and_merge(T.sc_fabs,   TN_SCENERY_PREFABS)
  T.wall_fabs = copy_and_merge(T.wall_fabs, TN_WALL_PREFABS)

  T.sky_info = TN_SKY_INFO

  return T
end
