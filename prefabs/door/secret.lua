--
-- Secret doors
--

PREFABS.Door_secret =
{
  file   = "door/secret.wad"
  map    = "MAP01"
  where  = "edge"

  key    = "secret"

  deep   = 16
  over   = 16

  x_fit  = "frame"

  prob   = 200

  -- pick some different objects for the hint, often none
  thing_34 =
  {
    nothing = 30
    barrel = 10
    candle = 10
    dead_player = 10
    gibs = 10
    gibbed_player = 5
    pool_brains = 5
  }
}


PREFABS.Door_secret_diag =
{
  file   = "door/secret.wad"
  map    = "MAP02"
  where  = "diagonal"
  
  key    = "secret"
}


PREFABS.Door_secret3 =
{
  template = "Door_secret"

  map    = "MAP03"

  prob   = 50
}


PREFABS.Door_secret4 =
{
  template = "Door_secret"

  map    = "MAP04"

  prob   = 100
}

