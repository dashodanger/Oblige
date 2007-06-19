----------------------------------------------------------------
-- GAME DEF : Heretic
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

HC_THINGS =
{
  --- special stuff ---
  player1 = { id=1, kind="other", r=16,h=56 },
  player2 = { id=2, kind="other", r=16,h=56 },
  player3 = { id=3, kind="other", r=16,h=56 },
  player4 = { id=4, kind="other", r=16,h=56 },

  dm_player     = { id=11, kind="other", r=16,h=56 },
  teleport_spot = { id=14, kind="other", r=16,h=56 },

  --- monsters ---
  gargoyle    = { id=66, kind="monster", r=16,h=36 },
  fire_garg   = { id=5,  kind="monster", r=16,h=36 },
  golem       = { id=68, kind="monster", r=22,h=64 },
  golem_inv   = { id=69, kind="monster", r=22,h=64 },

  nitro       = { id=45, kind="monster", r=22,h=64 },
  nitro_inv   = { id=46, kind="monster", r=22,h=64 },
  warrior     = { id=64, kind="monster", r=24,h=80 },
  warrior_inv = { id=65, kind="monster", r=24,h=80 },

  disciple   = { id=15, kind="monster", r=16,h=72 },
  sabreclaw  = { id=90, kind="monster", r=20,h=64 },
  weredragon = { id=70, kind="monster", r=34,h=80 },
  ophidian   = { id=92, kind="monster", r=22,h=72 },

  ironlich   = { id=6,  kind="monster", r=40,h=72 },
  maulotaur  = { id=9,  kind="monster", r=28,h=104 },
  d_sparil   = { id=7,  kind="monster", r=28,h=104 },

  --- pickups ---
  k_yellow   = { id=80, kind="pickup", r=20,h=16, pass=true },
  k_green    = { id=73, kind="pickup", r=20,h=16, pass=true },
  k_blue     = { id=79, kind="pickup", r=20,h=16, pass=true },

  gauntlets  = { id=2005, kind="pickup", r=20,h=16, pass=true },
  crossbow   = { id=2001, kind="pickup", r=20,h=16, pass=true },
  claw       = { id=53,   kind="pickup", r=20,h=16, pass=true },
  hellstaff  = { id=2004, kind="pickup", r=20,h=16, pass=true },
  phoenix    = { id=2003, kind="pickup", r=20,h=16, pass=true },
  firemace   = { id=2002, kind="pickup", r=20,h=16, pass=true },

  crystal    = { id=10, kind="pickup", r=20,h=16, pass=true },
  geode      = { id=12, kind="pickup", r=20,h=16, pass=true },
  arrows     = { id=18, kind="pickup", r=20,h=16, pass=true },
  quiver     = { id=19, kind="pickup", r=20,h=16, pass=true },
  claw_orb1  = { id=54, kind="pickup", r=20,h=16, pass=true },
  claw_orb2  = { id=55, kind="pickup", r=20,h=16, pass=true },
  runes1     = { id=20, kind="pickup", r=20,h=16, pass=true },
  runes2     = { id=21, kind="pickup", r=20,h=16, pass=true },
  flame_orb1 = { id=22, kind="pickup", r=20,h=16, pass=true },
  flame_orb2 = { id=23, kind="pickup", r=20,h=16, pass=true },
  mace_orbs  = { id=13, kind="pickup", r=20,h=16, pass=true },
  mace_pile  = { id=16, kind="pickup", r=20,h=16, pass=true },

  h_vial  = { id=81, kind="pickup", r=20,h=16, pass=true },
  h_flask = { id=82, kind="pickup", r=20,h=16, pass=true },
  h_urn   = { id=32, kind="pickup", r=20,h=16, pass=true },
  shield1 = { id=85, kind="pickup", r=20,h=16, pass=true },
  shield2 = { id=31, kind="pickup", r=20,h=16, pass=true },

  bag     = { id=8,  kind="pickup", r=20,h=16, pass=true },
  wings   = { id=23, kind="pickup", r=20,h=16, pass=true },
  ovum    = { id=30, kind="pickup", r=20,h=16, pass=true },
  torch   = { id=33, kind="pickup", r=20,h=16, pass=true },
  bomb    = { id=34, kind="pickup", r=20,h=16, pass=true },
  map     = { id=35, kind="pickup", r=20,h=16, pass=true },
  chaos   = { id=36, kind="pickup", r=20,h=16, pass=true },
  shadow  = { id=75, kind="pickup", r=20,h=16, pass=true },
  ring    = { id=84, kind="pickup", r=20,h=16, pass=true },
  tome    = { id=86, kind="pickup", r=20,h=16, pass=true },

  --- scenery ---
  wall_torch    = { id=50, kind="scenery", r=10,h=64, light=255, pass=true, add_mode="extend" },
  serpent_torch = { id=27, kind="scenery", r=12,h=54, light=255 },
  fire_brazier  = { id=76, kind="scenery", r=16,h=44, light=255 },
  chandelier    = { id=28, kind="scenery", r=31,h=60, light=255, pass=true, ceil=true, add_mode="island" },

  barrel  = { id=44,   kind="scenery", r=12,h=32 },
  pod     = { id=2035, kind="scenery", r=16,h=54 },

  blue_statue   = { id=94, kind="scenery", r=16,h=54 },
  green_statue  = { id=95, kind="scenery", r=16,h=54 },
  yellow_statue = { id=96, kind="scenery", r=16,h=54 },

  moss1   = { id=48, kind="scenery", r=16,h=24, ceil=true, pass=true },
  moss2   = { id=49, kind="scenery", r=16,h=28, ceil=true, pass=true },
  volcano = { id=87, kind="scenery", r=12,h=32 },
  
  small_pillar = { id=29, kind="scenery", r=16,h=36 },
  brown_pillar = { id=47, kind="scenery", r=16,h=128 },
  glitter_red  = { id=74, kind="scenery", r=20,h=16, pass=true },
  glitter_blue = { id=52, kind="scenery", r=20,h=16, pass=true },

  stal_small_F = { id=37, kind="scenery", r=12,h=36 },
  stal_small_C = { id=39, kind="scenery", r=16,h=36, ceil=true },
  stal_big_F   = { id=38, kind="scenery", r=12,h=72 },
  stal_big_C   = { id=40, kind="scenery", r=16,h=72, ceil=true },

  hang_skull_1 = { id=17, kind="scenery", r=20,h=64, ceil=true, pass=true },
  hang_skull_2 = { id=24, kind="scenery", r=20,h=64, ceil=true, pass=true },
  hang_skull_3 = { id=25, kind="scenery", r=20,h=64, ceil=true, pass=true },
  hang_skull_4 = { id=26, kind="scenery", r=20,h=64, ceil=true, pass=true },
  hang_corpse  = { id=51, kind="scenery", r=12,h=104,ceil=true },

  --- ambient sounds ---
  amb_scream = { id=1200, kind="other", r=20,h=16, pass=true },
  amb_squish = { id=1201, kind="other", r=20,h=16, pass=true },
  amb_drip   = { id=1202, kind="other", r=20,h=16, pass=true },
  amb_feet   = { id=1203, kind="other", r=20,h=16, pass=true },
  amb_heart  = { id=1204, kind="other", r=20,h=16, pass=true },
  amb_bells  = { id=1205, kind="other", r=20,h=16, pass=true },
  amb_growl  = { id=1206, kind="other", r=20,h=16, pass=true },
  amb_magic  = { id=1207, kind="other", r=20,h=16, pass=true },
  amb_laugh  = { id=1208, kind="other", r=20,h=16, pass=true },
  amb_run    = { id=1209, kind="other", r=20,h=16, pass=true },

  env_water  = { id=41, kind="other", r=20,h=16, pass=true },
  env_wind   = { id=42, kind="other", r=20,h=16, pass=true },
}

HC_LINE_TYPES =  -- NOTE: only includes differences to DOOM
{
  A1_scroll_right = { kind=99 },
  W1_secret_exit  = { kind=105 }, -- FIXME: correct?

  P1_green_door = { kind=33 },
  PR_green_door = { kind=28 },
}

HC_SECTOR_TYPES =
{
  secret   = { kind=9 },
  friction = { kind=15 },

  random_off = { kind=1 },
  blink_fast = { kind=2 },
  blink_slow = { kind=3 },
  glow       = { kind=8 },

  damage_5  = { kind=7 },
  damage_10 = { kind=5 },
  damage_20 = { kind=16 },
}


----------------------------------------------------------------

HC_COMBOS =
{
  ---- INDOOR ------------

  GOLD =
  {
    mat_pri = 6,

    wall = "SANDSQ2",
    void = "SNDBLCKS",
    pillar = "SNDCHNKS",

    floor = "FLOOR06",
    ceil = "FLOOR11",

    scenery = "wall_torch",

    theme_probs = { CITY=20 },
  },

  BLOCK =
  {
    mat_pri = 7,

    wall = "GRSTNPB",
    void = "GRSTNPBW",
    pillar = "WOODWL",

    floor = "FLOOR03",
    ceil = "FLOOR03",

    scenery = "barrel",

    theme_probs = { CITY=20 },
  },

  MOSSY =
  {
    mat_pri = 2,

    wall = "MOSSRCK1",
    void = "MOSSRCK1",
    pillar = "SKULLSB1", -- SPINE1
    
    floor = "FLOOR00",
    ceil  = "FLOOR04",

    scenery = "chandelier",

    theme_probs = { CITY=20 },
  },

  WOOD =
  {
    mat_pri = 2,

    wall = "WOODWL",
    void = "CTYSTUC3",

    floor = "FLOOR10",
    ceil  = "FLOOR12",

    scenery = "hang_skull_1",

    theme_probs = { CITY=20 },
  },

  HUT =
  {
    mat_pri = 1,
    
    wall = "CTYSTUC3",
    void = "CTYSTUC4",
    
    floor = "FLOOR10",
    ceil  = "FLOOR11",

    scenery = "barrel",

    theme_probs = { CITY=20 },
  },


  ---- OUTDOOR ------------

  STONY =
  {
    outdoor = true,
    mat_pri = 3,

    wall = "GRSTNPB",
    void = "GRSTNPBV",

    floor = "FLOOR00",
    ceil =  "FLOOR00",

    scenery = "serpent_torch",
  },

  MUDDY =
  {
    outdoor = true,
    mat_pri = 3,

    wall = "CSTLRCK",
    void = "SQPEB1",
    pillar = "SPINE1",

    floor = "FLOOR17",
    ceil  = "FLOOR17",

    scenery = "fire_brazier",

    theme_probs = { CITY=20 },
  },
  
  WATERY =
  {
    outdoor = true,
    mat_pri = 1,

    wall = "SNDBLCKS",
    void = "CTYSTCI4",

    floor = "FLTWAWA1",
    ceil  = "FLOOR27",

    theme_probs = { CITY=20 },
  },

  SANDY =
  {
    outdoor = true,
    mat_pri = 2,
    
    wall = "CTYSTUC2",
    void = "CTYSTUC3",
    pillar = "SPINE2",

    floor = "FLOOR27",
    ceil  = "FLOOR27",

    scenery = "small_pillar",

    theme_probs = { CITY=20 },
  },
  
}

HC_EXITS =
{
  METAL =
  {
    mat_pri = 9,

    wall = "METL2",
    void = "SKULLSB1",

    floor = "FLOOR03",
    ceil  = "FLOOR19",

    switch =
    {
      prefab="SWITCH_NICHE_TINY_DEEP",
      add_mode="wall",
      skin =
      {
        switch_w="SW2OFF", wall="METL2",
--      switch_f="FLOOR28",

        switch_h=32, x_offset=16, y_offset=48,
        kind=11, tag=0,
      }
    },
  },
}

HC_HALLWAYS =
{
  -- FIXME !!! hallway themes
}


---- BASE MATERIALS ------------

HC_MATS =
{
  METAL =
  {
    mat_pri = 5,

    wall  = "METL2",
    void  = "METL1",
    floor = "FLOOR28",
    ceil  = "FLOOR28",
  },

  STEP =
  {
    wall  = "SNDPLAIN",
    floor = "FLOOR27",
  },

  LIFT =
  {
    wall = "DOORSTON",
    floor = "FLOOR08"
  },

  TRACK =
  {
    wall  = "METL2",
    floor = "FLOOR28",
  },

  DOOR_FRAME =
  {
    wall  = nil,  -- this means: use plain wall
    floor = "FLOOR04",
    ceil  = "FLOOR04",
  },
}

--- PEDESTALS --------------

HC_PEDESTALS =
{
  PLAYER =
  {
    wall  = "CTYSTCI4", void = "CTYSTCI4",
    floor = "FLOOR11",   ceil = "FLOOR11",
    h = 8,
  },

  QUEST = -- FIXME
  {
    wall  = "CTYSTCI4", void = "CTYSTCI4",
    floor = "FLOOR11",   ceil = "FLOOR11",
    h = 8,
  },

  WEAPON = -- FIXME
  {
    wall  = "CTYSTCI4", void = "CTYSTCI4",
    floor = "FLOOR11",  ceil = "FLOOR11",
    h = 8,
  },
}

---- OVERHANGS ------------

HC_OVERHANGS =
{
  WOOD =
  {
    ceil = "FLOOR10",
    upper = "CTYSTUC3",
    thin = "WOODWL",
  },
}

---- MISC STUFF ------------

HC_LIQUIDS =
{
  water = { floor="FLTFLWW1" },
  -- FIXME
}

HC_SWITCHES =
{
  sw_demon =
  {
    switch =
    {
      prefab = "SWITCH_NICHE_TINY",
      add_mode = "island",
      skin =
      {
        wall="CHAINSD",
        switch_w="SW1OFF", switch_h=32,
        x_offset=16, y_offset=48, kind=103,
      }
    },

    door =
    {
      w=128, h=128,
      prefab = "DOOR",
      skin =
      {
        door_w="DMNMSK", door_c="FLOOR10",
        track_w="METL2",
        door_h=128,
        door_kind=0, tag=0,
      }
    },
  },

  sw_celtic =
  {
    switch =
    {
      prefab="SWITCH_NICHE_TINY",
      add_mode = "island",
      skin =
      {
        wall="CELTIC",
        switch_w="SW1OFF", switch_h=32,
        x_offset=16, y_offset=48, kind=103,
      }
    },

    door =
    {
      w=128, h=128,
      prefab = "DOOR",
      skin =
      {
        door_w="CELTIC", door_c="FLAT522",
        track_w="METL2",
        door_h=128,
        door_kind=0, tag=0,
      }
    },
  },

  sw_green =
  {
    switch =
    {
      prefab = "SWITCH_NICHE_TINY",
      add_mode = "island",
      skin =
      {
        wall="GRNBLOK1",
        switch_w="SW1OFF", switch_h=32,
        x_offset=16, y_offset=48, kind=103,
      }
    },

    door =
    {
      w=128, h=128,
      prefab = "DOOR",
      skin =
      {
        door_w="GRNBLOK4", door_c="FLOOR18",
        track_w="METL2",
        door_h=128,
        door_kind=0, tag=0,
      }
    },
  },
}

HC_DOORS =
{
  d_demon = { prefab="DOOR", w=128, h=128,

               skin =
               {
                 door_w="DMNMSK", door_c="FLOOR10",
                 track_w="METL2",
                 door_h=128,

---              lite_w="LITE5", step_w="STEP1",
---              frame_f="FLAT1", frame_c="TLITE6_6",
               }
             },
  
  d_wood   = { wall="DOORWOOD", w=64,  h=128, ceil="FLOOR10" },
  
--  d_stone  = { wall="DOORSTON", w=64,  h=128 },
}

HC_KEY_DOORS =
{
  k_blue =
  {
    w=128, h=128,

    prefab = "DOOR", -- DOOR_LOCKED

    skin =
    {
      door_w="DOORSTON", door_c="FLOOR28",
      track_w="METL2",
      frame_f="FLOOR04",
      door_h=128, 
      door_kind=32, tag=0,  -- kind_rep=26
    },

    thing = "blue_statue",
  },

  k_green =
  {
    w=128, h=128,

    prefab = "DOOR", -- DOOR_LOCKED

    skin =
    {
      door_w="DOORSTON", door_c="FLOOR28",
      track_w="METL2",
      frame_f="FLOOR04",
      door_h=128, 
      door_kind=33, tag=0, -- kind_rep=28,
    },

    thing = "green_statue",
  },

  k_yellow =
  {
    w=128, h=128,

    prefab = "DOOR", -- DOOR_LOCKED

    skin =
    {
      door_w="DOORSTON", door_c="FLOOR28",
      track_w="METL2",
      frame_f="FLOOR04",
      door_h=128, 
      door_kind=34, tag=0, -- kind_rep=27,
    },

    thing = "yellow_statue",
  },
}

HC_LIFTS =
{
  slow = { kind=62,  walk=88 },
}

HC_DOOR_PREFABS =
{
  d_wood =
  {
    w=128, h=128, prefab="DOOR",

    skin =
    {
      door_w="DOORWOOD", door_c="FLOOR10",
      track_w="METL2",
      door_h=128,
      door_kind=1, tag=0,
    },

    theme_probs = { CITY=20 },
  },
}

HC_MISC_PREFABS =
{
  exit_DOOR =
  {
    w=64, h=96, prefab = "DOOR_NARROW",

    skin =
    {
      door_w="DOOREXIT",
      door_h=96,
      door_kind=1, tag=0,
    },
  },

  secret_DOOR =
  {
    w=128, h=128, prefab = "DOOR",

    skin =
    {
      track_w="METL2",
      door_h=128, door_kind=31, tag=0
    },
  },
}

HC_RAILS =
{
  r_1 = { wall="WDGAT64", w=128, h=64  },
  r_2 = { wall="WDGAT64", w=128, h=128 },  -- FIXME!!
}

HC_IMAGES =
{
  { wall = "GRSKULL2", w=128, h=128, glow=true },
  { wall = "GRSKULL1", w=64,  h=64,  floor="FLOOR27" }
}

HC_LIGHTS =
{
  round = { floor="FLOOR26",  side="ORNGRAY" },
}

HC_WALL_LIGHTS =
{
  redwall = { wall="REDWALL", w=32 },
}

HC_PICS =
{
  skull3 = { wall="GRSKULL3", w=128, h=128 },
  glass1 = { wall="STNGLS1",  w=128, h=128 },
}

---- QUEST STUFF ----------------

HC_QUESTS =
{
  key =
  {
    k_blue=30, k_green=45, k_yellow=60
  },

  switch =
  {
    sw_demon=60, sw_green=45, sw_celtic=30,
  },

  weapon =
  {
    claw=60, hellstaff=40,
    phoenix=40, firemace=20
  },

  item =
  {
    shadow=60, bag=50, wings=40, ovum=30,
    bomb=25, tome=20, chaos=15,
  },
}

HC_ROOMS =
{
  PLAIN =
  {
  },

  HALLWAY =
  {
    room_heights = { [96]=50, [128]=50 },
    door_probs   = { out_diff=75, combo_diff=50, normal=5 },
    window_probs = { out_diff=1, combo_diff=1, normal=1 },
    space_range  = { 20, 65 },
  },
 
  SCENIC =
  {
  },

  -- TODO: check in-game level names for ideas
}

HC_THEMES =
{
  CITY =
  {
    room_probs=
    {
      PLAIN=50,
    },
  },
}

HC_QUEST_LEN_PROBS =
{
  ----------  2   3   4   5   6   7   8  9  10  -------

  key    = {  0, 25, 50, 90, 65, 30, 10, 2 },
  exit   = {  0, 25, 50, 90, 65, 30, 10, 2 },

  switch = {  0, 50, 90, 50, 25, 5, 1 },

  weapon = { 25, 90, 50, 10, 2 },
  item   = { 15, 70, 70, 15, 2 },
}


------------------------------------------------------------

HC_MONSTERS =
{
  -- FIXME: dm and fp values are CRAP!
  gargoyle    = { prob=30, hp=20,  dm= 7, fp=1.0, cage_fallback=10, float=true, melee=true },
  fire_garg   = { prob=20, hp=80,  dm=21, fp=2.0, float=true },
  golem       = { prob=80, hp=80,  dm= 7, fp=1.3, melee=true },
  golem_inv   = { prob=20, hp=80,  dm= 7, fp=1.5, melee=true },

  nitro       = { prob=70, hp=100, dm=21, fp=2.5, },
  nitro_inv   = { prob=10, hp=100, dm=21, fp=2.7, },
  warrior     = { prob=70, hp=200, dm=15, fp=2.5, },
  warrior_inv = { prob=20, hp=200, dm=15, fp=2.7, },

  disciple    = { prob=25, hp=180, dm=30, fp=3.0, float=true },
  sabreclaw   = { prob=25, hp=150, dm=30, fp=2.3, melee=true },
  weredragon  = { prob=20, hp=220, dm=50, fp=3.0, },
  ophidian    = { prob=20, hp=280, dm=50, fp=3.0, },

  pod = { prob=5, hp=45, dm=2, fp=1.0, melee=true, passive=true },
}

HC_BOSSES =
{
  ironlich    = { prob= 4, hp=700,  dm=99, fp=3.0, float=true },
  maulotaur   = { prob= 1, hp=3000, dm=99, fp=3.0, },
  d_sparil    = { prob= 1, hp=2000, dm=99, fp=3.0, },
}

HC_WEAPONS =
{
  -- FIXME: all these stats are CRAP!
  staff      = { fp=0, melee=true, rate=3.0, dm=10, freq= 2, held=true },
  gauntlets  = { fp=1, melee=true, rate=6.0, dm=50, freq= 8 },

  wand       = { fp=1, ammo="crystal",           per=1, rate=1.1, dm=10, freq=15, held=true },
  crossbow   = { fp=2, ammo="arrow",     give=4, per=1, rate=1.1, dm=30, freq=90 },
  claw       = { fp=2, ammo="claw_orb",  give=4, per=1, rate=1.1, dm=50, freq=50 },

  hellstaff  = { fp=3, ammo="runes",     give=4, per=1, rate=1.1, dm=60, freq=50 },
  phoenix    = { fp=3, ammo="flame_orb", give=4, per=1, rate=1.1, dm=70, freq=50 },
  firemace   = { fp=4, ammo="mace_orb",  give=4, per=1, rate=1.1, dm=90, freq=25 },
}

HC_PICKUPS =
{
  -- FIXME: the ammo 'give' numbers are CRAP!
  crystal = { stat="crystal", give=5,  },
  geode   = { stat="crystal", give=20, },
  arrows  = { stat="arrow",   give=5,  },
  quiver  = { stat="arrow",   give=20, },

  claw_orb1 = { stat="claw_orb", give=5,  },
  claw_orb2 = { stat="claw_orb", give=20, },
  runes1    = { stat="runes",    give=5,  },
  runes2    = { stat="runes",    give=20, },

  flame_orb1 = { stat="flame_orb", give=5,  },
  flame_orb2 = { stat="flame_orb", give=20, },
  mace_orbs  = { stat="mace_orb",  give=5,  },
  mace_pile  = { stat="mace_orb",  give=20, },

  h_vial  = { stat="health", give=10,  prob=70 },
  h_flask = { stat="health", give=25,  prob=25 },
  h_urn   = { stat="health", give=100, prob=5, clu_max=1 },

  shield1 = { stat="armor", give=100, prob=70 },
  shield2 = { stat="armor", give=200, prob=10 },
}

HC_NICENESS =
{
  w1 = { weapon="crossbow",  quest=1, prob=70, always=true  },

  w3 = { weapon="gauntlets", quest=1, prob=33, always=false },
  w4 = { weapon="gauntlets", quest=3, prob=50, always=false },

  a1 = { pickup="shield1", prob=2.0 },
  a2 = { pickup="shield2", prob=0.7 },

  p1 = { pickup="torch",   prob=2.0 },
}

HC_DEATHMATCH =
{
  weapons =
  {
    gauntlets=10, crossbow=60,
    claw=30, hellstaff=30, phoenix=30
  },

  health =
  { 
    h_vial=70, h_flask=25, h_urn=5
  },

  ammo =
  { 
    crystal=10, geode=20,
    arrows=20, quiver=60,
    claw_orb1=10, claw_orb2=40,
    runes1=10, runes2=30,
    flame_orb1=10, flame_orb2=30,
  },

  items =
  {
    shield1=70, shield2=10,
    bag=10, torch=10,
    wings=50, ovum=50,
    bomb=30, chaos=30,
    shadow=50, tome=30,
  },

  cluster = {}
}

HC_INITIAL_MODEL =
{
  cleric =
  {
    health=100, armor=0,
    crystal=30, arrow=0, runes=0,
    claw_orb=0, flame_orb=0, mace_orb=0,
    staff=true, wand=true,
  }
}


------------------------------------------------------------

HC_EPISODE_THEMES =
{
  { CITY=5 },
  { CITY=5 },
  { CITY=5 },

  { CITY=5 },
  { CITY=5 },
}

HC_SECRET_EXITS =
{
  E1M6 = true,
  E2M4 = true,
  E3M4 = true,

  E4M4 = true,
  E5M3 = true,
}

HC_EPISODE_BOSSES =
{
  "ironlich",
  "maulotaur",
  "d_sparil",

  "ironlich",
  "maulotaur",
}

HC_SKY_INFO =
{
  { color="gray",  light=176 },
  { color="red",   light=192 },
  { color="blue",  light=176 },

  { color="gray",  light=176 },
  { color="blue",  light=176 },
}

function heretic_get_levels(episode)

  local level_list = {}

  local theme_probs = HC_EPISODE_THEMES[episode]
  if SETTINGS.length ~= "full" then
    theme_probs = HC_EPISODE_THEMES[rand_irange(1,5)]
  end

  for map = 1,9 do
    local Level =
    {
      name = string.format("E%dM%d", episode, map),

      episode   = episode,
      ep_along  = map,
      ep_length = 9,

      theme_probs = theme_probs,
      sky_info = HC_SKY_INFO[episode],

      boss_kind   = (map == 8) and HC_EPISODE_BOSSES[episode],
      secret_kind = (map == 9) and "plain",
    }

    if HC_SECRET_EXITS[Level.name] then
      Level.secret_exit = true
    end

    std_decide_quests(Level, HC_QUESTS, HC_QUEST_LEN_PROBS)

    table.insert(level_list, Level)
  end

  return level_list
end

------------------------------------------------------------

GAME_FACTORIES["heretic"] = function()

  return
  {
    doom_format = true,

    plan_size = 10,
    cell_size = 9,
    cell_min_size = 6,

    caps = { heights=true, sky=true, 
             fragments=true, move_frag=true, rails=true,
             closets=true,   depots=true,
             switches=true,  liquids=true,
             teleporters=true,
             prefer_stairs=true,
           },

    SKY_TEX    = "F_SKY1",
    ERROR_TEX  = "DRIPWALL",
    ERROR_FLAT = "FLOOR09",

    episodes   = 5,
    level_func = heretic_get_levels,

    classes  = { "cleric" },

    things     = HC_THINGS,
    monsters   = HC_MONSTERS,
    bosses     = HC_BOSSES,
    weapons    = HC_WEAPONS,

    pickups = HC_PICKUPS,
    pickup_stats = { "health", "crystal", "arrow", "claw_orb",
                     "runes", "flame_orb", "mace_orb" },
    niceness = HC_NICENESS,

    initial_model = HC_INITIAL_MODEL,

    quests  = HC_QUESTS,

    dm = HC_DEATHMATCH,

    combos    = HC_COMBOS,
    exits     = HC_EXITS,
    hallways  = HC_HALLWAYS,

    rooms     = HC_ROOMS,
    themes    = HC_THEMES,

    hangs     = HC_OVERHANGS,
    pedestals = HC_PEDESTALS,
    mats      = HC_MATS,
    rails     = HC_RAILS,

    liquids   = HC_LIQUIDS,
    switches  = HC_SWITCHES,
    doors     = HC_DOORS,
    key_doors = HC_KEY_DOORS,
    lifts     = HC_LIFTS,

    pics      = HC_PICS,
    images    = HC_IMAGES,
    lights    = HC_LIGHTS,
    wall_lights = HC_WALL_LIGHTS,

    door_fabs   = HC_DOOR_PREFABS,
    misc_fabs   = HC_MISC_PREFABS,

    toughness_factor = 0.75,

    depot_info  = { teleport_kind=97 },

    room_heights = { [96]=5, [128]=25, [192]=70, [256]=70, [320]=12 },
    space_range  = { 20, 90 },
    
    diff_probs = { [0]=20, [16]=40, [32]=80, [64]=30, [96]=5 },
    bump_probs = { [0]=30, [16]=30, [32]=20, [64]=5 },
    
    door_probs   = { out_diff=75, combo_diff=50, normal=15 },
    window_probs = { out_diff=80, combo_diff=50, normal=30 },
  }
end

