----------------------------------------------------------------
-- GROWER
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

require 'defs'

-- FIXME: temp stuff for util module
con = { }
function con.ticker() end
function con.abort() return false end
function con.rand_seed(value) math.randomseed(value) end
function con.random() return math.random() end


require 'util'


-- [[
require 'gd'

RENDER_NUM = 1

function debug_render_seeds(SEEDS)

  local im = gd.createTrueColor(500, 500);

  local black = im:colorAllocate(0, 0, 0);
  local white = im:colorAllocate(255, 255, 255);

  local red    = im:colorAllocate(255, 0, 0);
  local blue   = im:colorAllocate(0, 0, 255);
  local purple = im:colorAllocate(255, 0, 255);

  im:filledRectangle(0, 0, 500, 500, black);

  im:png(string.format("seeds%d.png", RENDER_NUM))

  for x = 1,SEEDS.w do for y = 1,SEEDS.h do
    local S = SEEDS[x][y]
    if S then
      -- FIXME....
    end
  end end

  RENDER_NUM = RENDER_NUM + 1
end
--]]


function grow_all(SEEDS)

  local DIR

  local function get_width(S)
    return S.x2 - S.x1 + 1
  end
    
  local function get_height(S)
    return S.y2 - S.y1 + 1
  end

  local function same_room(S1, S2)
    return S1.room == S2.room
  end

  local function valid_seed(sx, sy)
    return sx >= 1 and sx <= SEEDS.w and sy >= 1 and sy <= SEEDS.h
  end

  local function get_seed_safe(sx, sy)
    return valid_seed(sx, sy) and SEEDS[sx][sy]
  end

  local function seed_new_size(S)
    
    local x1,y1 = S.x1, S.y1
    local x2,y2 = S.x2, S.y2

    if S.grow then
          if DIR==2 then y1 = y1-1
      elseif DIR==8 then y2 = y2+1
      elseif DIR==4 then x1 = x1-1
      elseif DIR==6 then x2 = x2+1
      end
    end

    if S.shrink then
          if DIR==2 then y2 = y2-1
      elseif DIR==8 then y1 = y1+1
      elseif DIR==4 then x2 = x2-1
      elseif DIR==6 then x1 = x1+1
      end
    end

    return x1,y1, x2,y2
  end
  
  local function growth_overlap(G, T)

    local x1,y1, x2,y2 = G.x1, G.y1, G.x2, G.y2

    -- coordinates for just the "new growth"
        if DIR == 6 then x2 = x2 + 1 ; x1 = x2
    elseif DIR == 4 then x1 = x1 - 1 ; x2 = x1
    elseif DIR == 8 then y2 = y2 + 1 ; y1 = y2
    elseif DIR == 2 then y1 = y1 - 1 ; y2 = y1
    end
  
    return boxes_overlap(x1,y1, x2,y2, T.x1,T.y1, T.x2,T.y2)
  end

  local function do_grow(S)
        if DIR==2 then S.y1 = S.y1-1
    elseif DIR==8 then S.y2 = S.y2+1
    elseif DIR==4 then S.x1 = S.x1-1
    elseif DIR==6 then S.x2 = S.x2+1
    end
  end

  local function do_shrink(S)
        if DIR==2 then S.y2 = S.y2-1
    elseif DIR==8 then S.y1 = S.y1+1
    elseif DIR==4 then S.x2 = S.x2-1
    elseif DIR==6 then S.x1 = S.x1+1
    end
  end

  local function check_for_overlap(S)
---   local dx,dy = dir_to_delta(DIR)
    
    for x = 1,SEEDS.w do for y = 1,SEEDS.h do
      local F = SEEDS[x][y]

      if F and F ~= S then
        if growth_overlap(S, F) then
          F.shrink = 1
          F.grow = 1   -- FIXME: unless pure shrink OK
        end
      end
    end end
  end

  local function link_cur_long(S, N)
    if DIR == 4 or DIR == 6 then

      local x1 = math.max(S.x1, N.x1)
      local x2 = math.min(S.x2, N.x2)

      assert(x2 >= x1)

      return x2 - x1 + 1
    else

      local y1 = math.max(S.y1, N.y1)
      local y2 = math.min(S.y2, N.y2)

      assert(y2 >= y1)

      return y2 - y1 + 1
    end
  end

  local function maintain_side_link(S, N, L)

    if same_room(S, N) then
      S.grow = S.grow or N.grow
      N.grow = S.grow

      S.shrink = S.shrink or N.shrink
      N.shrink = S.shrink

      return true
    end

    -- actually linked?
    if not L and not same_room(S, N) then return end

    -- nothing to do if both are changing the same way
    if S.grow == N.grow and S.shrink == N.shrink then return end

    -- figure out overlap (after grow/shrink)
    local cur_long = link_cur_long(S, N)
    --FIXME !!! take new sizes into account

    if cur_long < L.long then
      S.grow = S.grow or N.grow   --- ???
      N.grow = S.grow
    end

    if N.mass > S.mass then S,N = N,S end

    -- FIXME: need better ways specifying WHERE the link occurs

    -- FIXME: support "symmetric" links (L.twin ??)
  end

  local function maintain_back_link(S, B, L)

    -- actually linked?
    if not L and not same_room(S, B) then return end

    local changed = false

    if same_room(S, B) or true then
      if S.shrink then B.grow   = 1 ; changed = true end
      if B.grow   then S.shrink = 1 ;
                       S.grow = 1 ;   -- FIXME: unless pure shrink OK
                       changed = true end
    
      return changed
    end
  end

  local function maintain_links()
    local changed = false
    for x = 1,SEEDS.w-1 do for y = 1,SEEDS.h-1 do
      local S = SEEDS[x][y]
      if S then
        if S.grow then check_for_overlap(S) end

--        for side = 6,8,2 do
        local side = 6
        if is_parallel(side, DIR) then side = 8 end
        do
          local L = S.link[side]

          local N
          if side == 6 then N = SEEDS[x+1][y] else N = SEEDS[x][y+1] end

          if N then
            if maintain_link(S, N, L) then
              changed = true
            end
          end
        end

        -- backwards link
        local dx,dy = dir_to_delta(DIR)
        local B = get_seed_safe(x+dx, y+dy)

        if maintain_back_link(S, B, S.link[10-DIR]) then
          changed = true
        end
      end
    end end

    -- !! FIXME symmetry pass

    return changed
  end

  local function collect_changes()
    -- also clears the grow/shrink flags

    local list = {}

    for x = 1,SEEDS.w do for y = 1,SEEDS.h do
      local S = SEEDS[x][y]

      if S and (S.grow or S.shrink) then
          table.insert(list, { S=S, grow=S.grow, shrink=S.shrink })
          S.grow   = nil
          S.shrink = nil
      end
    end end

    return list
  end

  local function perform_pass(cur_dir)

    DIR = cur_dir
     
    -- 1. mark which seeds we want to grow in this pass

    for x = 1,SEEDS.w do for y = 1,SEEDS.h do
      local S = SEEDS[x][y]
      if S then
        
        local diff
        if (DIR==4 or DIR==6) then
          diff = S.min_W - get_width(S)
        else
          diff = S.min_H - get_height(S)
        end

        if diff > 0 then
          local chance = 33
          if diff >= 2 then chance = 66 end
          if diff >= 4 then chance = 99 end

          if rand_odds(chance) then
            S.grow = 1
          end
        end

      end
    end end

    -- 2. repeat the growth spurts until all done

    while maintain_links() do end

    list = collect_changes()

    for zzz,info in ipairs(list) do
      if info.grow   then do_grow  (info.S) end
      if info.shrink then do_shrink(info.S) end
    end
  end

  local function initialise_seeds()

    -- initialize all seeds, aligned to a 3x3 grid

    for x = 1,SEEDS.w do for y = 1,SEEDS.h do
      local S = SEEDS[x][y]
      if S then
        S.sx, S.sy = x, y

        S.x1, S.y1 = x*3+0, y*3+0
        S.x2, S.y2 = x*3+2, y*3+2

---     S.grow   = { [2]=0, [4]=0, [6]=0, [8]=0 }
---     S.shrink = { [2]=0, [4]=0, [6]=0, [8]=0 }
      end
    end end
  end

  local function is_finished()

    for x = 1,SEEDS.w do for y = 1,SEEDS.h do
      local S = SEEDS[x][y]
      if S then
        if get_width (S) < S.min_W then return false end
        if get_height(S) < S.min_H then return false end
      end
    end end

    return true
  end

  local function adjust_coordinates()

    -- make sure seeds have valid block ranges
    -- (in particular: negative coords are not allowed).

    local min_x = 999
    local min_y = 999

    for x = 1,SEEDS.w do for y = 1,SEEDS.h do
      local S = SEEDS[x][y]

      if S then
        S.w = get_width(S)
        S.h = get_height(S)

        min_x = math.min(min_x, S.x1)
        min_y = math.min(min_y, S.y1)

        -- sanity checking
        assert(S.w >= S.min_W)
        assert(S.h >= S.min_H)

        local N = SEEDS[x+1] and SEEDS[x+1][y]
        if N then assert(S.x2 < N.x1) end

        N = SEEDS[x][y+1]
        if N then assert(S.y2 < N.y1) end
      end

    end end

    min_x = min_x-1
    min_y = min_y-1

    for x = 1,SEEDS.w do for y = 1,SEEDS.h do
      S.x1 = S.x1 - min_x
      S.y1 = S.y1 - min_y

      S.x2 = S.x2 - min_x
      S.y2 = S.y2 - min_y
    end end
  end


  ----===| grow_all |===----


  initialise_seeds()

  -- perform growth passes until every seed is full-sized
  local SIDES = { 2,4,6,8 }

  repeat
    debug_render_seeds()

--  for loop = 1,4 do
      rand_shuffle(SIDES)
      for zzz,side in ipairs(SIDES) do
        perform_pass(side)
      end
--  end
  until is_finished()

  adjust_coordinates();

end -- grow_all


function test_grow_all()

  print("test_grow_all...")

  local seeds = array_2D(16,12)

  grow_all(seeds)
end


math.randomseed(1)

test_grow_all()

