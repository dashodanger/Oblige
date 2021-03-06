CHEX3.MATERIALS =
{
  -- special materials --
  _ERROR = { t="COMPSPAN", f="CEIL5_1" },
  _SKY   = { t="COMPSPAN", f="F_SKY1" },

  -- materials for generic prefab set --
  _METAL   = { t="METL2",   f="FLOOR30" }, -- Self explanatory
  
  _WOOD    = { t="WOODWL", f="FLOOR10"}, -- Yep, it's wood
  _WOOD2  = { t="DRIPWALL", f="FLOOR27" },  
  
  _SBARS = { t="GATMETL3", f="FLOOR30" }, -- Short bars, i.e. railings
  _SBARS2 = { t="GATMETL2", f="FLOOR30" },
  _MBARS = { t="GATMETL4", f="FLOOR30" }, -- Medium bars, i.e. barred windows
  _TBARS = { t="GATMETL5", f="FLOOR30" }, -- Tall bars, i.e. cage/jail bars
  
  _CRATE   = { t="DOORWOOD",  f="FLAT507" }, -- Crate/box
  _CRATE2  = { t="CTYSTCI4", f="FLOOR10" },

  _GRYWALL = { t="ORNGRAY",  f="FLAT521" }, -- Gray standalone partition/cover  MAYBE DITCH THIS
  
  _WATER   = { t="WATRWAL1", f="FLTWAWA1" }, -- "Standing water", sorta
  _WTRFALL = { t="WATRWAL1", f="FLTFLWW1" }, -- "Flowing water", sorta
  
  _STONE   = { t="SQPEB1", f="FLAT504" }, -- It rocks lOLOLol
  _STONE2 = { t="SNDCHNKS", f="FLAT522" },
  
  _DOOR  = { t="DOORWOOD", f="FLAT507" }, -- Open says me
  _DOOR2 = { t="DOORSTON", f="FLOOR08"},
  _DORRAIL = { t="METL2", f="FLOOR28"}, -- Inner door slider thingys
  
  _NPIC    = { t="CELTIC", f="FLOOR06"}, -- Narrow (non-tiling) pic box insert, 64 pixels wide
  _NPIC2    = { t="MOSAIC5", f="FLAT502"},
  _NPIC3    = { t="SAINT1", f="FLAT523"},
  
  _MPIC    = { t="CELTIC", f="FLOOR06"}, -- Medium (or tiling) pic box insert, 128 pixels wide
  _MPIC2    = { t="DMNMSK", f="FLAT521"},
  _MPIC3    = { t="GRSKULL3", f="FLAT521"},
  _MPIC4    = { t="SKULLSB2", f="FLOOR30"},
  _MPIC5    = { t="STNGLS1", f="FLOOR30"},
  _MPIC6    = { t="STNGLS2", f="FLOOR30"},
  _MPIC7    = { t="STNGLS3", f="FLOOR30"},
  
  _WPIC    = { t="CHAINMAN", f="FLAT520"}, -- Wide (or tiling) pic box insert, 256 pixels wide
  _WPIC2    = { t="HORSES1", f="FLAT502"},
  _WPIC3    = { t="CELTIC", f="FLOOR06"},
  
  _REDSTON = { t="REDWALL", f="FLOOR09"}, -- Red stone
  _BLUSTON = { t="BLUEFRAG", f="FLAT502"}, -- Blue stone
  
  _KEYTRM1 = { t="SPINE1", f="FLOOR25" }, -- Trim for locked door, Key 1
  _KEYTRM2 = { t="GRNBLOK1", f="FLOOR19" }, -- Trim for locked door, Key 2
  _KEYTRM3 = { t="BLUEFRAG", f="FLOOR16" }, -- Trim for locked door, Key 3
  
  _EXITDOR = { t="DOOREXIT", f="FLAT520" }, -- Exit door
  _EXITSW  = { t="SW2OFF", f="FLOOR28" }, -- Exit switch
  
  _SWITCH  = { t="SW1OFF", f="FLOOR28" }, -- Wall/general purpose swtich
  _SWITCH2  = { t="SW2OFF", f="FLOOR28" },
  
  _TELE = { t="CHAINSD", f="FLTTELE1" }, -- Teleporter

  -- general purpose --

  METAL  = { t="COMPBLUE", f="STEP1" },
  CAVE   = { t="SKSNAKE2", f="CEIL3_1" },
  VENT   = { t="ASHWALL",  f="FLOOR0_3" },
  WHITE  = { t="SW2SATYR", f="FLAT5_6" },
  DIRT   = { f="FLOOR0_1", t="TEKWALL5" },


  -- walls --

  LIFT = { t="SKSNAKE1", f="STEP1" },

  BLUE_WALL    = { t="SP_DUDE2", f="FLOOR0_2" },
  BLUE_OBSDECK = { t="SLADSKUL", f="FLOOR0_2" },
  BLUE_SLIMED  = { t="SKINMET1", f="FLOOR0_2" },

  GRAY_PIPES   = { t="STONE",    f="FLAT5_6" },
  GRAY_PANELS  = { t="STONE3",   f="FLAT5_6" },
  GRAY_LITE    = { t="LITESTON", f="FLAT5_6" },
  GRAY_STRIPE  = { t="GRAY7",    f="FLAT5_6" },

  ORANGE_TILE   = { t="STARG3",   f="FLAT2" },
  ORANGE_LAB    = { t="COMPUTE3", f="FLAT2" },
  ORANGE_SLIMED = { t="SKINMET2", f="FLAT2" },
  ORANGE_CUPBD  = { t="DOOR3",    f="FLAT2" },
  ORANGE_CABNET = { t="CEMENT4",  f="FLAT2" },
  ORANGE_LOCKER = { t="CEMENT6",  f="FLAT2" },

  ORANGE_MATH   = { t="CEMPOIS",  f="FLAT2" },
  ORANGE_BOOKS  = { t="BRNSMALL", f="FLAT2" },
  ORANGE_DIAG   = { t="BRNSMALR", f="FLAT2" },
  ORANGE_MAP    = { t="BROWN96",  f="FLAT2" },

  STEEL1      = { t="CEMENT1",  f="CEIL3_2" },
  STEEL2      = { t="CEMENT5",  f="CEIL3_2" },
  STEEL_LITE  = { t="LITE96",   f="CEIL3_2" },
  STEEL_GRATE = { t="REDWALL1", f="CEIL3_2" },

  STARPORT  = { t="CEMENT2", f="FLAT5_6" },

  TAN1      = { t="TEKWALL5", f="FLAT1" },
  TAN2      = { t="BROWN1",   f="FLAT1" },
  TAN_LITE  = { t="LITE2",    f="FLAT1" },
  TAN_GRATE = { t="BRNSMAL1", f="FLAT1" },
  TAN_VINE  = { t="BROVINE",  f="FLAT1" },

  COMPUTE_1 = { t="COMP2",    f="FLAT5_6" },
  COMPUTE_2 = { t="COMPUTE2", f="FLAT5_6" },
  COMP_BOX  = { t="COMPWERD", f="FLAT5_6" },
  COMP_SPAN = { t="COMPSPAN", f="FLAT5_6" },

  CUPBOARD = { t="BRNBIGC",  f="FLAT1" },

  CAVE_GLOW    = { t="BLODRIP2", f="CEIL3_1" },
  CAVE_LITE    = { t="SKULWAL3", f="CEIL3_1" },
  CAVE_CRACK   = { t="STARTAN2", f="CEIL3_1" },
  CAVE_SUPPORT = { t="PIPE6",    f="CEIL3_2" },

  PIC_PLANET  = { t="SKINCUT",  f="CEIL4_1" },
  PIC_DIPLOMA = { t="EXITDOOR", f="CEIL4_1" },
  PIC_PHOTO1  = { t="TEKWALL4", f="CEIL4_1" },
  PIC_PHOTO2  = { t="SLADWALL", f="CEIL4_1" },

  TELE_CHAMBER = { t="SLADRIP1", f="FLAT5_6" },

  MET_SLADS = { t="SP_DUDE4", f="STEP1" },

  STEP_ORANGE = { t="STEP1",    f="FLAT2" },
  STEP_GRAY   = { t="STEP2",    f="FLAT5_6" },
  STEP_WHITE  = { t="SW2SATYR", f="FLAT5_6" },
  STEP_CAVE   = { t="SKSNAKE2", f="CEIL3_1" },


  -- floors --

  CEIL_LITE = { f="CEIL3_5",  t="SW2SATYR" },

  VERYDARK_BLUE = { f="CEIL4_1",  t="SP_DUDE2" },
  ANOTHER_BLUE  = { f="FLOOR1_1", t="SP_DUDE2" },
  BLUE_CARPET   = { f="FLAT14",   t="SP_DUDE2" },

  CAVE_POOL = { f="FLAT19", t="SKSNAKE2" },

  TELE_GATE = { f="GATE1", t="SP_DUDE4" },

  DARK_GRAY = { f="CEIL5_1", t="TEKWALL5" },
  RED_FLOOR = { f="FLAT1",   t="SP_DUDE6" },

  -- NOTE: these two floor logos don't exist as flats in Chex 3,
  --       but they _do_ exist as single textures.
  IGC_LOGO_TL = { f="DEM1_1", t="SP_DUDE2" },
  IGC_LOGO_TR = { f="DEM1_2", t="SP_DUDE2" },
  IGC_LOGO_BL = { f="DEM1_3", t="SP_DUDE2" },
  IGC_LOGO_BR = { f="DEM1_4", t="SP_DUDE2" },

  CAFE_LOGO_TL = { f="FLAT3", t="COMPSPAN" },
  CAFE_LOGO_TR = { f="FLAT4", t="COMPSPAN" },
  CAFE_LOGO_BL = { f="FLAT8", t="COMPSPAN" },
  CAFE_LOGO_BR = { f="FLAT9", t="COMPSPAN" },


  -- doors --

  TRACK = { t="COMPSTA1", f="STEP1" },

  DOOR_GRATE = { t="BIGDOOR1", f="FLAT5_6" },
  DOOR_ALUM  = { t="DOOR1",    f="FLAT5_6" },
  DOOR_METER = { t="DOORBLU2", f="FLAT5_6" },

  DOOR_BLUE   = { t="BRNBIGR",  f="FLAT5_6" },
  DOOR_RED    = { t="BRNBIGL",  f="FLAT5_6" },
  DOOR_YELLOW = { t="BRNSMAL2", f="FLAT5_6" },

  DOOR_LAB   = { t="BIGDOOR4", f="FLAT5_6" },
  DOOR_ARBOR = { t="BIGDOOR5", f="FLAT2" },
  DOOR_HYDRO = { t="BIGDOOR6", f="FLAT2" },

  WDOOR_HANGER1 = { t="STARTAN3", f="FLAT1" },
  WDOOR_HANGER2 = { t="SKINFACE", f="FLAT1" },

  WDOOR_ARBOR = { t="SKINSCAB", f="CEIL5_1" },
  WDOOR_MINES = { t="SKINSYMB", f="FLAT5_6" },
  WDOOR_FRIDGE = { t="SKINTEK1", f="FLAT5_6" },

  LITE_RED    = { t="DOORRED", f="CEIL4_1" },
  LITE_BLUE   = { t="DOORBLU", f="CEIL4_1" },
  LITE_YELLOW = { t="DOORYEL", f="CEIL4_1" },


  -- switches --

  SW_METAL   = { t="SW2BLUE",  f="STEP1" },
  SW_CAVE    = { t="SW1BRCOM", f="CEIL3_2" },
  SW_BROWN2  = { t="SW1BRN2",  f="FLAT1" },
  SW_TAN     = { t="SW1METAL", f="FLAT1"  },

  SW_GRAY    = { t="SW1COMM",  f="FLAT5_6" },
  SW_COMPUTE = { t="SW1COMP",  f="FLAT5_6"  },
  SW_PIPEY   = { t="SW1STON1", f="FLAT5_6"  },


  -- rails --

  VINE1  = { t="MIDVINE1", rail_h=128 },
  VINE2  = { t="MIDVINE2", rail_h=128 },


  -- liquids --

  WATER  = { t="GSTFONT1", f="FWATER1", sane=1 },
  SLIME1 = { t="FIREMAG1", f="NUKAGE1", sane=1 },
  SLIME2 = { t="FIREMAG1", f="LAVA1",   sane=1 },


---===========>>


  -- Chex 1 compatibility --

  BLUE_SFALL  = { t="BLODGR1",  f="CEIL4_1" },

  CAVE_SLIMY1 = { t="PIPE4",    f="CEIL3_1" },
  CAVE_SLIMY2 = { t="MARBLE2",  f="CEIL3_1" },
  CAVE_SLIMY3 = { t="STARGR1",  f="CEIL3_1" },
  CAVE_EDGER  = { t="NUKEDGE1", f="CEIL3_1" },
  CAVE_SPLAT  = { t="NUKEPOIS", f="CEIL3_1" },

  COMPUTE_3   = { t="COMPTALL", f="FLAT5_6" },

  PIC_SLIMED  = { t="SLADPOIS", f="CEIL4_1" },
  PIC_STORAGE = { t="MARBFAC3", f="FLAT2" },

  SW_STEEL    = { t="SW2WOOD", f="CEIL3_2" },  -- Note: different size!

  HYDROPON_1 = { t="HYDROPO1", f="FLAT1" },
  HYDROPON_2 = { t="HYDROPO2", f="FLAT1" },
  HYDROPON_3 = { t="HYDROPO3", f="FLAT1" },



  CRUD_LITE = { f="STOOREST", t="COMPSPAN" },

  -- better tops on these
  CRATE1   = { t="CRATE1",   f="CRATOP2" },
  CRATE2   = { t="CRATE2",   f="CRATOP1" },
  CRATEMIX = { t="CRATELIT", f="CRATOP1" },
  CRATWIDE = { t="CRATWIDE", f="CRATOP1" },

  ---- these two textures are not present in Chex 3
  -- GRAY_FLOWER1 = { t="STONE3", f="FLAT5_6" }
  -- GRAY_FLOWER2 = { t="STONE3", f="FLAT5_6" }


  -- Chex 2 compatibility --

  HEDGE  = { t="HEDGE",  f="HEDGEF" },
  BEIGE  = { t="MUSEUM", f="BROWN" },

  GREEN_BRICK  = { t="SEWER1",   f="ENDFLAT2" },
  GREEN_BORDER = { t="SEWER2",   f="ENDFLAT2" },
  GREEN_SIGN   = { t="SEWER4",   f="ENDFLAT2" },
  GREEN_GRATE  = { t="WORMHOL3", f="ENDFLAT2" },

  MARB_GREEN  = { t="BROWN144", f="CEIL5_1" }, -- no good flat!
  MARB_RED    = { t="PLUSH", f="CFLAT2" },  -- texture not present in Chex 3

  RED_CURTAIN = { t="THEAWALL", f="CFLAT2" },

  MOVIE_PRAM    = { t="MOVIE2A", f="CEIL5_1" },
  MOVIE_MOUSE   = { t="MOVIE1A", f="CEIL5_1" },
  MOVIE_CHARLES = { t="MOVIE3A", f="CEIL5_1" },

  PIC_EAT_EM = { t="CHEXAD1", f="CEIL5_1" },
  PIC_LUV_EM = { t="CHEXAD2", f="CEIL5_1" },
  PIC_HUNGRY = { t="HUNGRY",  f="FLAT1" },

  PIC_MONA    = { t="MONA",     f="CEIL5_1" },
  PIC_VENUS   = { t="VENUSHS",  f="CEIL5_1" },
  PIC_VINCENT = { t="VINCENT",  f="CEIL5_1" },
  PIC_SCREAM  = { t="MUNCH",    f="CEIL5_1" },
  PIC_NUN     = { t="SW1STRTN", f="CEIL5_1" },
  PIC_BORING  = { t="ART2",     f="CEIL5_1" },

  SIGN_ENTER    = { t="CHEXCITY", f="CEIL5_1" },  -- Note: now has windows on top
  SIGN_WELCOME1 = { t="SPDOOR",   f="CEIL5_1" },
  SIGN_WELCOME2 = { t="SPACPORT", f="CEIL5_1" }, -- Note: now has windows on top
  SIGN_GALACTIC = { t="NUKE24",   f="CEIL5_1" },

  SIGN_DINER    = { t="DINESIGN", f="CEIL5_1" },  -- Note: now has windows on top
  SIGN_MUSEUM   = { t="MUSEUM2",  f="CEIL5_1" },
  SIGN_SEWER    = { t="SEWER3",   f="ENDFLAT2" },
  SIGN_CINEMA   = { t="CINEMA",   f="CEIL5_1" },

  BLUE_POSTER1 = { t="POSTER1", f="FLOOR1_1" },
  BLUE_POSTER2 = { t="POSTER2", f="FLOOR1_1" },
  BLUE_POSTER3 = { t="POSTER3", f="FLOOR1_1" },
  BLUE_CUPBD   = { t="CARPET_A", f="FLOOR1_1" },  -- texture not present

  TAN_THEATRE1 = { t="THEATRE1", f="FLOOR1_1" }, --\
  TAN_THEATRE2 = { t="THEATRE2", f="FLOOR1_1" },  -- Note: on blue walls now
  TAN_THEATRE3 = { t="THEATRE3", f="FLOOR1_1" },  --/
  TAN_MENU     = { t="FOODMENU", f="FLAT2" },

  BENCH_CANDY   = { t="CANDY",   f="CEIL5_1" },
  BENCH_POPCORN = { t="POPCORN", f="CEIL5_1" },

  GRAY_FLOOR = { f="CJFCOMM3", t="COMPSPAN" },

  BROWN_TILE = { f="MUFLOOR2", t="COMPSPAN" },
  WHITE_TILE = { f="CEIL3_2",  t="SW2SATYR" }, -- flat not present
  GREEN_TILE = { f="SLUGBRIK", t="SEWER1" },
  RED_TILE   = { f="CJFLOD06", t="STONE3" },  -- flat not present, grrr!


  --- new Chex 1 / 2 stuff ---

  PLUSH = { t="PLUSH", f="CFLAT2" },

  CINEMA_FLASHY = { t="ROCKRED1", f="CEIL5_1" },

  CAVE_ROCKY = { t="BAZOIK", f="CEIL3_1" },

  GREEN_PIPE1 = { t="SEWER_A", f="ENDFLAT2" },
  GREEN_PIPE2 = { t="SEWER_B", f="ENDFLAT2" },

  PIC_PAINTING  = { t="ART1",  f="CEIL5_1" },

  BLUE_SLOPE_DN = { t="STONPOIS", f="FLAT5_6" },  -- NB: 256 units tall
  BLUE_SLOPE_UP = { t="SUPPORT2", f="FLAT5_6" },  -- 

  TAN_STORAGE  = { t="STORAGE",  f="FLAT1" },
  STEEL_GRATE2 = { t="WORMHOL1", f="CEIL3_2" },

  STARPORT_METER  = { t="GSTONE2", f="FLAT5_6" },

  WDOOR_HYDRO1 = { t="CJHYDRO1", f="FLAT5_6" },


  ---- TOTALLY NEW STUFF ----

  -- walls --

  CHEX_METRO = { t="PLAT2", f="FLOOR1_1" },

  PIPE_TALL = { t="PIPE2", f="FLAT2" },

  GRAY_BRICKS  = { t="BROWNHUG", f="FLAT5_6" },
  BRICK_WALL   = { t="SP_DUDE1", f="BROWN" },
  BRICK_W_ARCH = { t="ICKDOOR1", f="BROWN" },
  BRICK_W_COL  = { t="WOOD1",    f="BROWN" },

  ANIM_TRAJECT = { t="FIREBLU1", f="CEIL5_1" },
  ANIM_FLOURO  = { t="FIREWALB", f="LABFLAT" },
  ANIM_PLASMA  = { t="FIRELAV3", f="FLOOR0_3" },

  SHIP_WINDOW1 = { t="ICKWALL3", f="XX" },
  SHIP_WINDOW2 = { t="ICKWALL4", f="XX" },

  CJBLUDR0 = { t="CJBLUDR0", f="XX" },
  CJCELR01 = { t="CJCELR01", f="XX" },
  CJCLIF01 = { t="CJCLIF01", f="XX" },
  CJCLIF02 = { t="CJCLIF02", f="XX" },
  CJCRAT01 = { t="CJCRAT01", f="XX" },
  CJCRAT02 = { t="CJCRAT02", f="XX" },
  CJCRAT03 = { t="CJCRAT03", f="XX" },
  CJCRAT04 = { t="CJCRAT04", f="XX" },
  CJCRAT05 = { t="CJCRAT05", f="XX" },

  CJCOMM01 = { t="CJCOMM01", f="XX" },
  CJCOMM02 = { t="CJCOMM02", f="XX" },
  CJCOMM03 = { t="CJCOMM03", f="XX" },
  CJCOMM04 = { t="CJCOMM04", f="XX" },
  CJCOMM05 = { t="CJCOMM05", f="XX" },
  CJCOMM06 = { t="CJCOMM06", f="XX" },
  CJCOMM07 = { t="CJCOMM07", f="XX" },
  CJCOMM08 = { t="CJCOMM08", f="XX" },
  CJCOMM09 = { t="CJCOMM09", f="XX" },
  CJCOMM10 = { t="CJCOMM10", f="XX" },

  CJCOMM11 = { t="CJCOMM11", f="XX" },
  CJCOMM12 = { t="CJCOMM12", f="XX" },
  CJCOMM13 = { t="CJCOMM13", f="XX" },
  CJCOMM14 = { t="CJCOMM14", f="XX" },
  CJCOMM15 = { t="CJCOMM15", f="XX" },
  CJCOMM16 = { t="CJCOMM16", f="XX" },
  CJCOMM17 = { t="CJCOMM17", f="XX" },
  CJCOMM18 = { t="CJCOMM18", f="XX" },
  CJCOMM19 = { t="CJCOMM19", f="XX" },
  CJCOMM20 = { t="CJCOMM20", f="XX" },
  CJCOMM21 = { t="CJCOMM21", f="XX" },
  CJCOMM22 = { t="CJCOMM22", f="XX" },
  CJCOMM23 = { t="CJCOMM23", f="XX" },

  CJDOOR01 = { t="CJDOOR01", f="XX" },
  CJDOOR02 = { t="CJDOOR02", f="XX" },
  CJDOOR03 = { t="CJDOOR03", f="XX" },
  CJDOOR04 = { t="CJDOOR04", f="XX" },
  CJFLDR01 = { t="CJFLDR01", f="XX" },
  CJFLDR02 = { t="CJFLDR02", f="XX" },
  CJFLDR03 = { t="CJFLDR03", f="XX" },
  CJFLDR04 = { t="CJFLDR04", f="XX" },
  CJFLDR05 = { t="CJFLDR05", f="XX" },

  CJLODG01 = { t="CJLODG01", f="XX" },
  CJLODG02 = { t="CJLODG02", f="XX" },
  CJLODG03 = { t="CJLODG03", f="XX" },
  CJLODG04 = { t="CJLODG04", f="XX" },
  CJLODG05 = { t="CJLODG05", f="XX" },
  CJLODG06 = { t="CJLODG06", f="XX" },
  CJLODG07 = { t="CJLODG07", f="XX" },
  CJLODG08 = { t="CJLODG08", f="XX" },
  CJLODG09 = { t="CJLODG09", f="XX" },
  CJLODG10 = { t="CJLODG10", f="XX" },
  CJLODG11 = { t="CJLODG11", f="XX" },
  CJLODG12 = { t="CJLODG12", f="XX" },
  CJLODG13 = { t="CJLODG13", f="XX" },
  CJLODG14 = { t="CJLODG14", f="XX" },
  CJLODG15 = { t="CJLODG15", f="XX" },
  CJLODG16 = { t="CJLODG16", f="XX" },
  CJLODG17 = { t="CJLODG17", f="XX" },

  CJMETE01 = { t="CJMETE01", f="XX" },
  CJMINE01 = { t="CJMINE01", f="CJFMINE1" },
  CJMINE02 = { t="CJMINE02", f="CJFMINE1" },
  CJREDDR0 = { t="CJREDDR0", f="XX" },
  CJSHIP01 = { t="CJSHIP01", f="XX" },
  CJSHIP02 = { t="CJSHIP02", f="XX" },
  CJSHIP03 = { t="CJSHIP03", f="XX" },
  CJSHIP04 = { t="CJSHIP04", f="XX" },
  CJSHIP05 = { t="CJSHIP05", f="XX" },

  CJSPLAT1 = { t="CJSPLAT1", f="XX" },
  CJSW1_1  = { t="CJSW1_1",  f="XX" },
  CJSW1_2  = { t="CJSW1_2",  f="XX" },
  CJTRAI01 = { t="CJTRAI01", f="XX" },
  CJTRAI02 = { t="CJTRAI02", f="XX" },
  CJTRAI03 = { t="CJTRAI03", f="XX" },
  CJTRAI04 = { t="CJTRAI04", f="XX" },
  CJYELDR0 = { t="CJYELDR0", f="XX" },

  CJVILL01 = { t="CJVILL01", f="XX" },
  CJVILL02 = { t="CJVILL02", f="XX" },
  CJVILL03 = { t="CJVILL03", f="XX" },
  CJVILL04 = { t="CJVILL04", f="XX" },
  CJVILL05 = { t="CJVILL05", f="XX" },
  CJVILL06 = { t="CJVILL06", f="XX" },
  CJVILL07 = { t="CJVILL07", f="XX" },
  CJVILL09 = { t="CJVILL09", f="XX" },
  CJVILL10 = { t="CJVILL10", f="XX" },
  CJVILL11 = { t="CJVILL11", f="XX" },

  CJCOMM24 = { t="CJCOMM24", f="XX" },
  CJCITY01 = { t="CJCITY01", f="XX" },
  CJLOGO1  = { t="CJLOGO1",  f="XX" },
  CJLOGO2  = { t="CJLOGO2",  f="XX" },
  CJSHIPBG = { t="CJSHIPBG", f="XX" },

  -- floors --

  BOOTHF1 = { f="BOOTHF1", t="XX" },
  BOOTHF2 = { f="BOOTHF2", t="XX" },
  BOOTHF3 = { f="BOOTHF3", t="XX" },
  BOOTHF4 = { f="BOOTHF4", t="XX" },

  CJFCOMM1 = { f="CJFCOMM1", t="XX" },
  CJFCOMM2 = { f="CJFCOMM2", t="XX" },
  CJFCOMM3 = { f="CJFCOMM3", t="XX" },
  CJFCOMM4 = { f="CJFCOMM4", t="XX" },
  CJFCOMM5 = { f="CJFCOMM5", t="XX" },
  CJFCOMM6 = { f="CJFCOMM6", t="XX" },
  CJFCOMM7 = { f="CJFCOMM7", t="XX" },

  CJFCRA01 = { f="CJFCRA01", t="XX" },
  CJFCRA02 = { f="CJFCRA02", t="XX" },
  CJFCRA03 = { f="CJFCRA03", t="XX" },
  CJFFLEM1 = { f="CJFFLEM1", t="XX" },
  CJFFLEM2 = { f="CJFFLEM2", t="XX" },
  CJFFLEM3 = { f="CJFFLEM3", t="XX" },
  CJFGRAS1 = { f="CJFGRAS1", t="XX" },

  CJFLOD01 = { f="CJFLOD01", t="XX" },
  CJFLOD02 = { f="CJFLOD02", t="XX" },
  CJFLOD03 = { f="CJFLOD03", t="XX" },
  CJFLOD04 = { f="CJFLOD04", t="XX" },
  CJFLOD05 = { f="CJFLOD05", t="XX" },
  CJFLOD06 = { f="CJFLOD06", t="XX" },
  CJFLOD07 = { f="CJFLOD07", t="XX" },
  CJFLOD08 = { f="CJFLOD08", t="XX" },
  CJFMINE1 = { f="CJFMINE1", t="XX" },
  CJFSHIP1 = { f="CJFSHIP1", t="XX" },
  CJFSHIP2 = { f="CJFSHIP2", t="XX" },
  CJFSHIP3 = { f="CJFSHIP3", t="XX" },

  CJFTRA01 = { f="CJFTRA01", t="XX" },
  CJFTRA02 = { f="CJFTRA02", t="XX" },
  CJFTRA03 = { f="CJFTRA03", t="XX" },
  CJFTRA04 = { f="CJFTRA04", t="XX" },
  CJFVIL01 = { f="CJFVIL01", t="XX" },
  CJFVIL02 = { f="CJFVIL02", t="XX" },
  CJFVIL03 = { f="CJFVIL03", t="XX" },
  CJFVIL04 = { f="CJFVIL04", t="XX" },
  CJFVIL05 = { f="CJFVIL05", t="XX" },
  CJFVIL06 = { f="CJFVIL06", t="XX" },

  MARS_GROUND = { f="ENDFLAT3", t="XX" },

  SIMPLE_TILE = { f="FLAT1_1", t="XX" },
  WOOD_CRATOP = { f="FLAT5_7", t="XX" },
  YELLOWISH   = { f="FLAT5_8", t="XX" },

  FLOURO_LITE = { f="LABFLAT", t="XX" },

  STEEL32 = { f="STEEL32", t="XX" },
  STEEL64 = { f="STEEL64", t="XX" },


  -- rails --

  VILL_BARS   = { t="CJVILL08", rail_h=128, line_flags=1 },
  TI_GRATE    = { t="TI_GRATE", rail_h=64  },
  BRIDGE_RAIL = { t="LITEMET",  rail_h=128 },

  CAVE_COLUMN = { t="SKSPINE1", rail_h=128 },
  ORANGE_HOLE = { t="STARG1",   rail_h=128 },


  -- other --

  O_BOLT   = { t="SP_ROCK1", f="O_BOLT",   sane=1 },
  O_PILL   = { t="SP_ROCK2", f="O_PILL",   sane=1 },
  O_RELIEF = { t="MIDBRN1",  f="O_RELIEF", sane=1 },
  O_CARVE  = { t="NUKESLAD", f="O_CARVE",  sane=1 },
  O_NEON   = { t="TEKWALL2", f="CEIL4_1",  sane=1 },

}
