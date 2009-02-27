----------------------------------------------------------------
--  Layouting Logic
----------------------------------------------------------------
--
--  Oblige Level Maker (C) 2006-2008 Andrew Apted
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
require 'util'
require 'ht_fabs'


X_MIRROR_CHARS =
{
  ['<'] = '>', ['>'] = '<',
  ['/'] = '%', ['%'] = '/',
  ['Z'] = 'N', ['N'] = 'Z',
  ['L'] = 'J', ['J'] = 'L',
  ['F'] = 'T', ['T'] = 'F',
}

Y_MIRROR_CHARS =
{
  ['v'] = '^', ['^'] = 'v',
  ['/'] = '%', ['%'] = '/',
  ['Z'] = 'N', ['N'] = 'Z',
  ['L'] = 'F', ['F'] = 'L',
  ['J'] = 'T', ['T'] = 'J',
}

TRANSPOSE_DIRS = { 1,4,7,2,5,8,3,6,9 }

TRANSPOSE_CHARS =
{
  ['<'] = 'v', ['v'] = '<',
  ['>'] = '^', ['^'] = '>',
  ['/'] = 'Z', ['Z'] = '/',
  ['%'] = 'N', ['N'] = '%',
  ['-'] = '|', ['|'] = '-',
  ['!'] = '=', ['='] = '!',
  ['F'] = 'J', ['J'] = 'F',
}

STAIR_DIRS =
{
  ['<'] = 4, ['>'] = 6,
  ['v'] = 2, ['^'] = 8,
}


function Test_room_fabs()
  
  local function pos_size(s, n)
    local ch = string.sub(s, n, n)
        if ch == 'A' then return 10
    elseif ch == 'B' then return 11
    elseif ch == 'C' then return 12
    elseif ch == 'D' then return 13
    else return 0 + (ch)
    end
  end

  local function total_size(s)
    local total = 0
    for i = 1,#s do
      total = total + pos_size(s, i)
    end
    return total
  end

  local function pad_line(src, x_sizes)
    assert(#src == #x_sizes)

    local padded = ""

    for x = 1,#x_sizes do
      local x_num = pos_size(x_sizes, x)
      local ch = string.sub(src, x, x)

      for i = 1,x_num do
        padded = padded .. ch
      end
    end

    return padded
  end

  local function dump_one_pattern(info, x_sizes, y_sizes)
    if (#info.structure ~= #y_sizes) then
      error("Pattern " .. info.name .. " has bad y_size")
    end

    for y = #y_sizes,1,-1 do
      local y_num = pos_size(y_sizes, y)
      local src = assert(info.structure[#y_sizes+1 - y])
      local padded = pad_line(src, x_sizes)
      for i = 1,y_num do
        gui.printf("  %s\n", padded)
      end
    end

    gui.printf("\n")
  end

  local function show_pattern(name, info, long, deep)
    assert(info.structure)
    assert(info.x_sizes)
    assert(info.y_sizes)

    gui.printf("==== %s %dx%d ==================\n\n", name, long, deep)

    local count = 0

    for _,ys in ipairs(info.y_sizes) do
      if total_size(ys) == deep then
        for _,xs in ipairs(info.x_sizes) do
          if total_size(xs) == long then
            dump_one_pattern(info, xs, ys)
            count = count + 1
          end
        end -- for xs
      end
    end -- for ys

    if count == 0 then
      gui.printf("Unsupported size\n\n")
    end
  end

  local function check_lines(info)
    local width = #info.structure[1]

    for _,line in ipairs(info.structure) do
      if #line ~= width then
        error("Bad structure (uneven widths)")
      end
    end
  end

  local function check_subs(info)
    local used_subs = {}

    -- first check the digits in the structure
    for y,line in ipairs(info.structure) do
      for x = 1,#line do
        local ch = string.sub(line, x, x)
        if ch == '0' then error("Invalid sub '0'") end
        if is_digit(ch) then
          local s_idx = 0 + ch  -- convert to number
          assert(s_idx >= 1 and s_idx <= 9)
          if not (info.subs and info.subs[s_idx]) then
            error("Missing subs entry [" .. ch .. "]")
          end

          -- determine 2D extent of sub-area
          local P = used_subs[s_idx]
          if not P then
            P = { x1=x, x2=x, y1=y, y2=y, ch=ch }
            used_subs[s_idx] = P
          else
            P.x1 = math.min(P.x1, x)
            P.y1 = math.min(P.y1, y)

            P.x2 = math.max(P.x2, x)
            P.y2 = math.max(P.y2, y)
          end
        end
      end -- for x
    end -- for y

    -- now make sure each sub-area is a full rectangle shape
    for _,P in ipairs(used_subs) do
      if P.recurse then
        for x = P.x1,P.x2 do for y = P.y1,P.y2 do
          local line = info.structure[y]
          local ch = string.sub(line, x, x)
          if ch ~= P.ch then
            error("Bad shape for sub area (not a full rectangle)")
          end
        end end -- for x, y
      end
    end -- for P

    -- check that each entry in info.subs is used
    for s_idx,_ in pairs(info.subs or {}) do
      if not used_subs[s_idx] then
        gui.printf("WARNING: sub entry %s is unused!\n", s_idx)
      end
    end
  end

  local function match_x_char(LC, RC)
    if X_MIRROR_CHARS[LC] then
      return RC == X_MIRROR_CHARS[LC]
    end

    -- having different sub-areas is OK
    if is_digit(LC) and is_digit(RC) then return true end

    return (LC == RC)
  end

  local function match_y_char(TC, BC)
    if Y_MIRROR_CHARS[BC] then
      return TC == Y_MIRROR_CHARS[BC]
    end

    -- having different sub-areas is OK
    if is_digit(TC) and is_digit(BC) then return true end

    return (TC == BC)
  end

  local function check_size_sym(mesg, s)
    local half_x = int(#s / 2)

    for x = 1,half_x do
      local x2 = #s - (x-1)

      if string.sub(s, x, x) ~= string.sub(s, x2, x2) then
        error("Broken size symmetry: " .. s)
      end
    end
  end

  local function check_horiz_sym(mesg, s)
    local half_x = int(#s / 2)

    for x = 1,half_x do
      local x2 = #s - (x-1)
      local LC = string.sub(s, x, x)
      local RC = string.sub(s, x2, x2)

      if not match_x_char(LC, RC) then
        error("Broken symmetry: " .. mesg)
      end
    end
  end

  local function check_vert_sym(top, bottom)
    assert(#top == #bottom)

    for x = 1,#top do
      local TC = string.sub(top, x, x)
      local BC = string.sub(bottom, x, x)

      if not match_y_char(TC, BC) then
        error("Broken vertical symmetry")
      end
    end
  end

  local function check_symmetry(info)
    -- Note: while it is techniclly possible to create a symmetrical
    -- pattern using non-symmetrical structure or size strings, we
    -- do not allow for that here.

    if info.symmetry == "x" or info.symmetry == "xy" then
      for _,line in ipairs(info.structure) do
        check_horiz_sym("structure X", line)
      end
      for _,xs in ipairs(info.x_sizes) do
        check_size_sym("x_size", xs)
      end
    end

    if info.symmetry == "y" or info.symmetry == "xy" then
      local half_y = int (#info.structure / 2)
      for y = 1,half_y do
        local top    = info.structure[y]
        local bottom = info.structure[#info.structure+1-y]

        check_vert_sym(top, bottom)
      end

      for _,ys in ipairs(info.y_sizes) do
        check_size_sym("y_size", ys)
      end
    end
  end

  local function show_fab_list(f_name, f_table)
    for name,info in pairs(f_table) do
      gui.printf("%s FAB: %s\n\n", f_name, name)

      check_lines(info)
      check_subs(info)
      check_symmetry(info)

      for deep = 2,11 do for long = 2,11 do
        show_pattern(name, info, long, deep)
      end end
    end
  end


  ---| Test_room_fabs |---
  
  show_fab_list("ROOM", ROOM_PATTERNS)

  error("TEST SUCCESSFUL")
end


function Layout_spot_for_wotsit(R, kind)
  local spots = {}

  -- for symmetrical rooms, prefer a centred item
  local bonus_x, bonus_y

  if R.mirror_x and R.tw >= 3 then bonus_x = int((R.tx1 + R.tx2) / 2) end
  if R.mirror_y and R.th >= 3 then bonus_y = int((R.ty1 + R.ty2) / 2) end

  for x = R.sx1,R.sx2 do for y = R.sy1,R.sy2 do
    local S = SEEDS[x][y][1]

    if S.room == R and S.kind == "walk" and not S.content then
      local P = { x=x, y=y, S=S }

      P.score = gui.random() + (S.div_lev or 0) * 20

      if R.entry_conn then
        local dx = math.abs(R.entry_conn.dest_S.sx - x)
        local dy = math.abs(R.entry_conn.dest_S.sy - y)

        P.score = P.score + dx + dy
      end

      if x == bonus_x then P.score = P.score + 15 end
      if y == bonus_y then P.score = P.score + 15 end

      table.insert(spots, P)
    end
  end end -- for x, y


  -- FIXME: no need to store spots
  local P = table_pick_best(spots,
        function(A,B) return A.score > B.score end)

  if not P then
    error("No usable spots in room!")
  end

  P.S.content = "wotsit"

  return P.x, P.y, P.S
end


function Layout_try_pattern(R, is_top, div_lev, req_sym, area, heights, f_texs)
  -- find a usable pattern in the ROOM_PATTERNS table and
  -- apply it to the room.

  -- this function is responsible for setting floor_h in every
  -- seed in the given 'area'.

  area.tw, area.th = box_size(area.x1, area.y1, area.x2, area.y2)

gui.debugf("Layout_try_pattern @ %s  div_lev:%d\n", R:tostr(), div_lev)
gui.debugf("Area: (%d,%d)..(%d,%d) heights: %d %d %d\n",
area.x1, area.y1, area.x2, area.y2,
heights[1] or -1, heights[2] or -1, heights[3] or -1)



  -- TODO: these little functions are duplicated in Test_height_patterns
  local function pos_size(s, n)
    local ch = string.sub(s, n, n)
        if ch == 'A' then return 10
    elseif ch == 'B' then return 11
    elseif ch == 'C' then return 12
    elseif ch == 'D' then return 13
    else return 0 + (ch)
    end
  end

  local function total_size(s)
    local total = 0
    for i = 1,#s do
      total = total + pos_size(s, i)
    end
    return total
  end

  local function pad_line(src, x_sizes)
    assert(#src == #x_sizes)

    local padded = ""

    for x = 1,#x_sizes do
      local x_num = pos_size(x_sizes, x)
      local ch = string.sub(src, x, x)

      for i = 1,x_num do
        padded = padded .. ch
      end
    end

    return padded
  end

  local function matching_sizes(list, dim)
    local result
    
    for _,sz in ipairs(list) do
      if total_size(sz) == dim then
        if not result then result = {} end
        table.insert(result, sz)
      end
    end

    return result
  end

  local function morph_dir(T, dir)
    if T.x_flip and is_horiz(dir) then dir = 10-dir end
    if T.y_flip and is_vert(dir)  then dir = 10-dir end

    if T.transpose then dir = TRANSPOSE_DIRS[dir] end

    return dir
  end

  local function morph_char(T, ch)
    if T.x_flip then
      ch = X_MIRROR_CHARS[ch] or ch
    end

    if T.y_flip then
      ch = Y_MIRROR_CHARS[ch] or ch
    end

    if T.transpose then
      ch = TRANSPOSE_CHARS[ch] or ch
    end

    return ch
  end

  local function convert_structure(T, info, x_sizes, y_sizes)

    T.structure = array_2D(area.tw, area.th)

    local stru_w = #x_sizes
    local stru_h = #y_sizes

    local function morph_coord2(T, i, j)
      if T.x_flip then i = T.long+1 - i end
      if T.y_flip then j = T.deep+1 - j end

      if T.transpose then i,j = j,i end

      return i, j
    end

    local function analyse_stair(E, ch, i, j)
      -- determine source height of stair.
      -- (dest height is simply in the pointed-to seed)

      local dir = assert(STAIR_DIRS[ch])

      local SIDES =
      {
        10 - dir,  -- try back first
        rotate_ccw90(dir),
        rotate_cw90 (dir)
      }

      for _,side in ipairs(SIDES) do
        local nch
        local nx, ny = nudge_coord(i, j, side)

        if (1 <= nx and nx <= stru_w) and (1 <= ny and ny <= stru_h) then
          local src = info.structure[stru_h+1 - ny]
          nch = string.sub(src, nx, nx)
        end

        if nch and (nch == '.' or is_digit(nch)) then
          E.stair_src = nch
          break;
        end
      end -- for side

      if not E.stair_src then
        error("Stair in pattern lacks a walkable neighbor!")
      end
    end


    ---| convert_structure |---

    local cur_j = 1

    for j = 1,stru_h do
      local j_num = pos_size(y_sizes, j)
      local src = info.structure[stru_h+1 - j]
      
      local cur_i = 1

      for i = 1,stru_w do
        local i_num = pos_size(x_sizes, i)
        local ch = string.sub(src, i, i)
        local mc = morph_char(T, ch)

        for di = 0,i_num-1 do for dj = 0,j_num-1 do
          local x, y = morph_coord2(T, cur_i+di, cur_j+dj)
          assert(1 <= x and x <= area.tw)
          assert(1 <= y and y <= area.th)

          local E = { char=mc }

          if ch == '<' or ch == '>' or ch == 'v' or ch == '^' then
            E.dir = STAIR_DIRS[mc]
            analyse_stair(E, ch, i, j)
          end

          T.structure[x][y] = E
        end end -- for di, dj

        cur_i = cur_i + i_num
      end -- for i

      cur_j = cur_j + j_num
    end -- for j


    --[[ Testing
    for ex = 1,area.tw do for ey = 1,area.th do
      local E = assert(T.structure[ex][ey])
    end end -- for ex, ey
    --]]
  end


  local function find_sub_area(T, match_ch)
    local x1, y1 = 999, 999
    local x2, y2 =-9, -9

    for ex = 1,area.tw do for ey = 1,area.th do
      local x  = area.x1 + ex-1
      local y  = area.y1 + ey-1

      local ch = T.structure[ex][ey].char

      if ch == match_ch then
        if x < x1 then x1 = x end
        if y < y1 then y1 = y end
        if x > x2 then x2 = x end
        if y > y2 then y2 = y end
      end
    end end -- for ex, ey

    if x2 < 0 then return nil end

    return { x1=x1, y1=y1, x2=x2, y2=y2 }
  end

  local function setup_floor(S, h, f_tex)
    S.floor_h = h

    if not R.outdoor then
      S.f_tex = f_tex
    end

    if S.conn or S.pseudo_conn then
      local C = S.conn or S.pseudo_conn
      if C.conn_h then assert(C.conn_h == S.floor_h) end

      C.conn_h = S.floor_h
      C.conn_ftex = f_tex
    end
  end

  local function setup_stair(T, S, E, h, f_tex)
    assert(not S.conn)

    S.kind = "stair"
    S.stair_dir = assert(E.dir)

    if not R.outdoor then
      S.f_tex = f_tex
    end

    
    -- determine height "around" the stair (source).
    -- the destination is done in process_stair()
    assert(E.stair_src)
    if E.stair_src == '.' then
      S.stair_z1 = h
    else
      local s_idx = 0 + E.stair_src
      local sub = assert(T.info.subs[s_idx])
      S.stair_z1 = heights[1 + sub.height]
    end

    assert(S.stair_z1)

    S.floor_h = S.stair_z1


    local N = S:neighbor(S.stair_dir)

    assert(N and N.room == R)
    assert(R:contains_seed(N.sx, N.sy))

    N.must_walk = true
  end

  local function setup_curve_stair(S, E, ch, h, f_tex)
    assert(not S.conn)

    S.kind = "curve_stair"

    S.x_side = sel(ch == 'L' or ch == 'F', 6, 4)
    S.y_side = sel(ch == 'L' or ch == 'J', 8, 2)

    if not R.outdoor then
      S.f_tex = f_tex
    end

---???  S.floor_h = h

    for pass = 1,2 do
      local dir = sel(pass == 1, S.x_side, S.y_side)

      local N = S:neighbor(dir)

      assert(N and N.room == R)
      assert(R:contains_seed(N.sx, N.sy))

      N.must_walk = true
    end
  end

  local function dump_structure(T)
    gui.debugf("T.structure =\n")
    for y = 1,area.th do
      local line = ""
      for x = 1,area.tw do
        line = line .. T.structure[x][y].char
      end
      gui.debugf("   %s\n", line)
    end
  end


  local function eval_pattern(T)
gui.debugf("eval_pattern %s\n", T.info.name)

    T.has_focus = false

    -- check symmetry
    local info_sym = T.info.symmetry
    if T.transpose then
          if info_sym == "x" then info_sym = "y"
      elseif info_sym == "y" then info_sym = "x"
      end
    end

    if not (not req_sym or req_sym == info_sym or info_sym == "xy") then
gui.debugf("SYMMETRY MISMATCH (%s ~= %s\n", req_sym or "NONE", info_sym or "NONE")
      return -1
    end

    -- check if enough heights are available
    if T.info.subs then
      for _,sub in ipairs(T.info.subs) do
        if (sub.height + 1) > #heights then
gui.debugf("NOT ENOUGH HEIGHTS\n")
        return -1 end
      end
    end

    local score = gui.random() * 99

    local matches = {}

    for ex = 1,area.tw do for ey = 1,area.th do
      local x = area.x1 + ex - 1
      local y = area.y1 + ey - 1
      assert(Seed_valid(x, y, 1))

      local S = SEEDS[x][y][1]
      assert(S and S.room == R)

      local E  = T.structure[ex][ey]
      local ch = assert(E.char)

      if (S.conn or S.pseudo_conn or S.must_walk) then
        if not (ch == '.' or is_digit(ch)) then
gui.debugf("CONN needs PLAIN WALK\n")
          return -1
        end

        if is_digit(ch) then
          local s_idx = (0 + ch)
          matches[s_idx] = (matches[s_idx] or 0) + 1
---??     score = score + 20
        end
      end

      if ch == '.' and S.conn == R.focus_conn then
        T.has_focus = true
      end

    end end -- for ex, ey

    -- for top-level pattern we require focus seed to hit a '.'
    if is_top and not T.has_focus then
gui.debugf("FOCUS not touch dot\n");
      return -1
    end

gui.debugf("matches: { %s %s }\n", tostring(matches[1]), tostring(matches[2]))

    -- check sub-area matches
    if T.info.subs then
      for s_idx,sub in ipairs(T.info.subs) do
        if sub.match == "one"  and not matches[s_idx] and
           not (R.kind == "purpose") then return -1 end

        if sub.match == "none" and matches[s_idx] then return -1 end

        if sub.match == "any" and matches[s_idx] then
          score = score + 100 * matches[s_idx]
        end
      end
    end

gui.debugf("OK : score = %1.4f\n", score)
    return score
  end


  local function install_pattern(T, want_subs)

gui.debugf("install_pattern %s :  hash_h:%d  (%d,%d)..(%d,%d)\n",
T.info.name, heights[1],
area.x1, area.y1, area.x2, area.y2)

-- dump_structure(T)

    for ex = 1,area.tw do for ey = 1,area.th do
      local x = area.x1 + ex - 1
      local y = area.y1 + ey - 1

      local S = SEEDS[x][y][1]
      local E  = T.structure[ex][ey]
      local ch = E.char

      local hash_h    = assert(heights[1])
      local hash_ftex = assert(f_texs[1])

      -- Note: any recursion will overwrite this value
      S.div_lev = div_lev

      do
        if ch == '.' or is_digit(ch) then
          if is_digit(ch) then
            local s_idx = 0 + ch
            if want_subs[s_idx] then
              local sub = assert(T.info.subs[s_idx])
              hash_h = assert(heights[1 + sub.height])
              hash_ftex = f_texs[1 + sub.height]
            else
              ch = nil
            end
          end

          if ch then
            setup_floor(S, hash_h, hash_ftex)
          end

        elseif ch == '<' or ch == '>' or ch == 'v' or ch == '^' then
          setup_stair(T, S, E, hash_h, hash_ftex)

        elseif ch == 'L' or ch == 'F' or ch == 'J' or ch == 'T' then
          setup_curve_stair(S, E, ch, hash_h, hash_ftex)

        elseif ch == '/' or ch == '%' or ch == 'Z' or ch == 'N' then
          S.kind = "diagonal"
          S.diag_char = ch

        elseif ch == '#' then
          S.kind = "void"

        elseif ch == '~' then
          -- NOTE: floor_h for liquids is determined later
          S.kind = "liquid"

        else
          error("unknown symbol in room pat: '" .. tostring(ch) .. "'")
        end
      end

    end end -- for ex, ey
gui.debugf("end install_fab\n")
  end

  local function install_flat_floor(h, f_tex)
    for x = area.x1,area.x2 do for y = area.y1,area.y2 do
      local S = SEEDS[x][y][1]
      if S.room == R and not S.floor_h then
        setup_floor(S, h, f_tex)
        S.div_lev = div_lev
      end
    end end -- for x, y
  end


  local function mirror_seed(S, OT, sym)
    -- S  : destination
    -- OT : other (source)

    if OT.kind == "walk" and not OT.floor_h then
gui.debugf("S  =\n%s\n\n", table_to_str(S,  1))
gui.debugf("OT =\n%s\n\n", table_to_str(OT, 1))
      error("mirror_seed : peer not setup yet!")
    end

    S.kind    = assert(OT.kind)
    S.div_lev = OT.div_lev

    S.floor_h = OT.floor_h
    S.ceil_h  = OT.ceil_h

    S.f_tex   = OT.f_tex
    S.c_tex   = OT.c_tex
    S.w_tex   = OT.w_tex

    -- NB: connection logic copied from setup_floor()
    if S.conn or S.pseudo_conn then
      local C = S.conn or S.pseudo_conn
      if C.conn_h then assert(C.conn_h == S.floor_h) end

      C.conn_h = S.floor_h
      if S.f_tex then C.conn_ftex = S.f_tex end
    end

    if OT.kind == "diagonal" then
      if sym == "x" then
        S.diag_char = X_MIRROR_CHARS[OT.diag_char]

      else assert(sym == "y")
        S.diag_char = Y_MIRROR_CHARS[OT.diag_char]
      end
    end

    assert(OT.kind ~= "lift")

    if OT.kind == "stair" then
      S.stair_dir = assert(OT.stair_dir)
      S.stair_z1  = assert(OT.stair_z1)

      if sym == "x" and is_horiz(S.stair_dir) then
        S.stair_dir = 10 - S.stair_dir
      end

      if sym == "y" and is_vert(S.stair_dir) then
        S.stair_dir = 10 - S.stair_dir
      end
    end

    if OT.kind == "curve_stair" then
      S.x_side = assert(OT.x_side)
      S.y_side = assert(OT.y_side)

      if sym == "x" then S.x_side = 10 - S.x_side end
      if sym == "y" then S.y_side = 10 - S.y_side end
    end
  end

  local function symmetry_fill(T, box)
    gui.debugf("Symmetry fill @ %s : (%d %d) -> (%d %d)\n",
               R:tostr(), box.x1, box.y1, box.x2, box.y2)

gui.debugf("Fab.symmetry = %s\n", tostring(T.info.symmetry))
gui.debugf("Room.symmetry = %s\n", tostring(R.symmetry))
gui.debugf("Transposed : %s\n", bool_str(T.transpose))

    local do_x = (T.info.symmetry == "x")
    local do_y = (T.info.symmetry == "y")

    -- TODO: support "xy" symmetrical fabs
    assert(do_x or do_y)

    if T.transpose then do_x,do_y = do_y,do_x end

    -- first pass is merely a test
    for pass = 1,2 do
      for x = box.x1,box.x2 do for y = box.y1,box.y2 do
        local S = SEEDS[x][y][1]
        assert(S and S.room == R)

        if S.kind == "walk" and not S.floor_h then
          local ox, oy = x, y

          if do_x then
            ox = area.x2 - (x - area.x1)
          elseif do_y then
            oy = area.y2 - (y - area.y1)
          end

          assert(Seed_valid(ox, oy, 1))

          local OT = SEEDS[ox][oy][1]
          assert(OT and OT.room == R)

          if pass == 1 then
            -- check that copy is possible
            -- (Note: most of the time it is OK)
            if (S.conn or S.pseudo_conn or S.must_walk) and
               not (OT.kind == "walk")
            then
gui.debugf("symmetry_fill FAILED  S:%s ~= OT:%s\n", S:tostr(), OT:tostr())
              R.symmetry = nil
              return false
            end

          elseif do_x then
            mirror_seed(S, OT, "x")
          elseif do_y then
            mirror_seed(S, OT, "y")
          end
        end
      end end -- for x, y
    end -- for pass

    return true  --OK--
  end

  local function clip_heights(tab, where)
    assert(tab and #tab >= 1)

    local new_tab = shallow_copy(tab)

    for i = 1,where do
      table.remove(new_tab, 1)
    end

    assert(#new_tab >= 1)
    return new_tab
  end

  local function try_one_pattern(name, info)
    local possibles = {}

    local T = { info=info }

    for tr_n = 0,1 do
      T.transpose = (tr_n == 1)

      T.long = sel(T.transpose, area.th, area.tw)
      T.deep = sel(T.transpose, area.tw, area.th)

      T.x_sizes = matching_sizes(info.x_sizes, T.long)
      T.y_sizes = matching_sizes(info.y_sizes, T.deep)

gui.debugf("  tr:%s  long:%d  deep:%d\n", bool_str(T.transpose), T.long, T.deep)
      if T.x_sizes and T.y_sizes then
        local xs = rand_element(T.x_sizes)
        local ys = rand_element(T.y_sizes)

        local xf_tot = 1
        local yf_tot = 1

        -- for symmetrical patterns no need to try the flipped version
        if T.info.symmetry == "x" or T.info.symmetry == "xy" then xf_tot = 0 end
        if T.info.symmetry == "y" or T.info.symmetry == "xy" then yf_tot = 0 end

        for xf_n = 0,xf_tot do for yf_n = 0,yf_tot do
          T.x_flip = (xf_n == 1)
          T.y_flip = (yf_n == 1)

          convert_structure(T, info, xs, ys)

          T.score = eval_pattern(T)

          if T.score > 0 then
            table.insert(possibles, shallow_copy(T))
          end
        end end -- for xf_n, yf_n
      end 
    end -- for tr_n

    if #possibles == 0 then
      return false
    end

gui.debugf("Possible patterns:\n%s\n", table_to_str(possibles, 2))

    T = table_pick_best(possibles,
        function(A,B) return A.score > B.score end)

gui.debugf("Chose pattern with score %1.4f\n", T.score)

    -- determine fill mode of each sub-area
    local want_subs = {}
    local sym_fills = {}

    for s_idx,sub in ipairs(info.subs or {}) do
      if sub.sym_fill and (req_sym or rand_odds(50)) then
        sym_fills[s_idx] = true
      elseif sub.recurse or sub.sym_fill then
        -- recursive fill
      else
        want_subs[s_idx] = true
      end
    end

    install_pattern(T, want_subs)


    -- recursive sub-division

    for s_idx,sub in ipairs(info.subs or {}) do
      local new_area = find_sub_area(T, tostring(s_idx))
      assert(new_area)

      if sym_fills[s_idx] and symmetry_fill(T, new_area) then
        -- OK, symmetry fill worked

      elseif sub.recurse or sub.sym_fill then
        local new_hs = clip_heights(heights, sub.height)
        local new_ft = clip_heights(f_texs,  sub.height)

        local new_sym = req_sym

        -- drop symmetry requirement??
        if (new_sym == "x" or new_sym == "xy") and
           ((new_area.x1 + new_area.x2) ~= (area.x1 + area.x2))
        then
          new_sym = nil
        end

        if (new_sym == "y" or new_sym == "xy") and
           ((new_area.y1 + new_area.y2) ~= (area.y1 + area.y2))
        then
          new_sym = nil
        end

        Layout_try_pattern(R, false, div_lev+1, new_sym, new_area, new_hs, new_ft)
      end
    end

    return true  -- YES !!
  end


  local function can_use_fab(info)
    if not info.prob then
      return false
    end

    if (info.environment == "indoor"  and R.outdoor) or
       (info.environment == "outdoor" and not R.outdoor)
    then
      return false -- wrong environment
    end

    if (info.z_direction == "up"   and (#heights < 2 or (heights[1] > heights[2]))) or
       (info.z_direction == "down" and (#heights < 2 or (heights[1] < heights[2])))
    then
      return false -- wrong z_direction
    end

    if (info.level == "top" and not is_top) or
       (info.level == "sub" and is_top)
    then
      return false -- wrong level
    end

    -- enough symmetry?
    -- [NOTE: because of transposing, treat "x" == "y" here]
    if not req_sym then return true end
    if info.symmetry == "xy" then return true end

    if req_sym == "xy" then return false end
    if not info.symmetry then return false end

    return true --OK--
  end

  local function add_fab_list(probs, infos, fabs, sol_mul, liq_mul)
    for name,info in pairs(fabs) do
      if can_use_fab(info) then
        infos[name] = info
        probs[name] = info.prob

        if info.kind == "solid" then
          probs[name] = probs[name] * sol_mul
        elseif info.kind == "liquid" then
          probs[name] = probs[name] * liq_mul
        end

        if info.shape == PLAN.favor_shape then
          probs[name] = probs[name] * 20.0
        end
      end
    end
  end

  local function do_try_divide()
    if R.children then return false end

    assert(R.kind ~= "hallway")
    assert(R.kind ~= "stairwell")

    --[[ some chance of not dividing at all
    local skip_prob = 50 - (area.tw + area.th) * 4
    if skip_prob > 0 and rand_odds(skip_prob) then
      return false
    end --]]

    local sol_mul = 1.0
    if PLAN.junk_mode == "heaps" then sol_mul = 3.0 end

    local liq_mul = 1.0
    if PLAN.liquid_mode == "few"   then liq_mul = 0.2 end
    if PLAN.liquid_mode == "heaps" then liq_mul = 9.0 end

    local f_probs = {}
    local f_infos = {}

    add_fab_list(f_probs, f_infos, ROOM_PATTERNS, sol_mul, liq_mul)


    local try_count = 12 + area.tw + area.th

    for loop = 1,try_count do
      if table_empty(f_probs) then
        break;
      end

      local which = rand_key_by_probs(f_probs)
      f_probs[which] = nil

      gui.debugf("Trying pattern %s in %s (loop %d)......\n",
                 which, R:tostr(), loop)

      if try_one_pattern(which, f_infos[which]) then
        gui.debugf("SUCCESS with %s!\n", which)
        return true
      end
    end

    gui.debugf("FAILED to apply any room pattern.\n")
    return false
  end


  ---==| Layout_try_pattern |==---
 
  if do_try_divide() then
gui.debugf("Success @ %s (div_lev %d)\n\n", R:tostr(), div_lev)
  else
gui.debugf("Failed @ %s (div_lev %d)\n\n", R:tostr(), div_lev)
    install_flat_floor(heights[1], f_texs[1])
  end
end


function Layout_set_floor_minmax(R)
  local min_h =  9e9
  local max_h = -9e9

  for x = R.sx1,R.sx2 do for y = R.sy1,R.sy2 do
    local S = SEEDS[x][y][1]
    if S.room == R and S.kind == "walk" then
      assert(S.floor_h)

      min_h = math.min(min_h, S.floor_h)
      max_h = math.max(max_h, S.floor_h)
    end
  end end -- for x, y

  assert(min_h <= max_h)

  R.floor_min_h = min_h
  R.floor_max_h = max_h

  R.fence_h  = R.floor_max_h + 30
  R.liquid_h = R.floor_min_h - 48

---#    for x = R.sx1,R.sx2 do for y = R.sy1,R.sy2 do
---#      local S = SEEDS[x][y][1]
---#      if S.room == R and S.kind == "liquid" then
---#        S.floor_h = R.liquid_h
---#      end
---#    end end -- for x, y
end


function Layout_scenic(R)

  local min_floor = 1000

  for x = R.sx1,R.sx2 do for y = R.sy1,R.sy2 do
    local S = SEEDS[x][y][1]
    if S.room == R then
      S.kind = "liquid"
      for side = 2,8,2 do
        local N = S:neighbor(side)
        if N and N.room and N.floor_h then
          min_floor = math.min(min_floor, N.floor_h)
        end
      end
    end
  end end -- for x,y

  if min_floor < 999 then
    local h1 = rand_irange(1,6)
    local h2 = rand_irange(1,6)

    R.liquid_h = min_floor - (h1 + h2) * 16
  else
    R.liquid_h = -24
  end
end


function Layout_hallway(R)

  local tx1,ty1, tx2,ty2 = R:conn_area()
  local tw = tx2 - tx1 + 1
  local th = ty2 - ty1 + 1

  local function T_fill()
    for x = R.sx1,R.sx2 do for y = R.sy1,R.sy2 do
      if x < tx1 or x > tx2 or y < ty1 or y > ty2 then
        SEEDS[x][y][1].kind = "void"
      end
    end end -- for x, y
  end

  local function make_O()
    for x = R.sx1+1,R.sx2-1 do for y = R.sy1+1,R.sy2-1 do
      local S = SEEDS[x][y][1]
      S.kind = "void"
    end end -- for x, y
  end

  local function make_L()
    local C1 = R.conns[1]
    local C2 = R.conns[2]

    local S1 = C1:seed(R)
    local S2 = C2:seed(R)

    if rand_odds(50) then S1,S2 = S2,S1 end

    for x = R.sx1,R.sx2 do for y = R.sy1,R.sy2 do
      if x < tx1 or x > tx2 or y < ty1 or y > ty2 or
         not (x == S1.sx or y == S2.sy)
      then
        SEEDS[x][y][1].kind = "void"
      end
    end end -- for x, y
  end

  local function criss_cross()
    -- block out seeds that don't "trace" from a connection
    local used_x = {}
    local used_y = {}

    for _,C in ipairs(R.conns) do
      local S = C:seed(R)
      if is_vert(S.conn_dir) then
        used_x[S.sx] = 1
      else
        used_y[S.sy] = 1
      end
    end

    -- all connections are parallel => fail
    if table_empty(used_x) or table_empty(used_y) then
      make_O()
      return
    end

    for x = R.sx1,R.sx2 do for y = R.sy1,R.sy2 do
      if x < tx1 or x > tx2 or y < ty1 or y > ty2 or
         not (used_x[x] or used_y[y])
      then
        SEEDS[x][y][1].kind = "void"
      end
    end end -- for x, y

    return true
  end


  ---| Layout_hallway |---

  local HALL_TEX   = { "BROWN1", "BROWNGRN", "GRAY1", "STARBR2" }
  local HALL_FLOOR = { "FLAT4", "CEIL5_1", "FLOOR1_1", "FLOOR3_3",  }
  local HALL_CEIL  = { "FLAT4", "CEIL5_1", "CEIL3_5", "CEIL3_3" }

  if not PLAN.hall_tex then
    PLAN.hall_tex   = rand_element(HALL_TEX)
    PLAN.hall_floor = rand_element(HALL_FLOOR)
    PLAN.hall_ceil  = rand_element(HALL_CEIL)

    PLAN.hall_trim   = rand_odds(50)
    PLAN.hall_lights = rand_odds(50)
  end


  local entry_C = assert(R.entry_conn)
  local h = assert(entry_C.conn_h)

  local O_CHANCES = { 0, 10, 40, 70 }
  local o_prob = O_CHANCES[math.min(4, #R.conns)]

  -- FIXME: more shapes (U, S)

  gui.debugf("Hall conn area: (%d,%d) .. (%d,%d)\n", tx1,ty1, tx2,ty2)

  if R.sw >= 3 and R.sh >= 3 and rand_odds(o_prob) then
    make_O()

  elseif tw == 1 or th == 1 then
    T_fill()

  elseif #R.conns == 2 then
    make_L()

  else
    criss_cross()
  end


  local height = 128
  local is_sky = false
  if rand_odds(20) then
    height = 192
  elseif rand_odds(10) then
    height = 256
    is_sky = true
  end

  for x = R.sx1,R.sx2 do for y = R.sy1,R.sy2 do
    local S = SEEDS[x][y][1]
    assert(S.room == R)
    if S.kind == "walk" then
      S.floor_h = h
      S.ceil_h = h + height

      S.f_tex = PLAN.hall_floor
      S.c_tex = PLAN.hall_ceil

      if is_sky then
        S.c_tex = PARAMS.sky_flat
      end
    end
  end end -- for x, y

  Layout_set_floor_minmax(R)

  for _,C in ipairs(R.conns) do
    C.conn_h = h
  end
end



function Layout_one(R)

  local function junk_sides()
    -- Adds solid seeds (kind "void") to the edges of large rooms.
    -- These seeds can be put to other uses later, such as: cages,
    -- monster closets, or secrets.
    --
    -- The best side is on the largest axis (minimises number of
    -- junked seeds), and prefer no connections on that side.
    -- Each side is only junked once.

    -- FIXME: occasionaly make ledge-cages in OUTDOOR rooms

    local JUNK_PROBS = { 0, 0,  3, 12, 20, 30, 40, 50 }
    local JUNK_HEAPS = { 0, 0, 50, 75, 99, 99, 99, 99 }


---##    local function max_junking(size)
---##      if size < min_space then return 0 end
---##      return size - min_space
---##    end

    local function eval_side(side)
      local th = R.junk_thick[side]

---##       if side == 2 or side == 8 then
---##         if R.junk_thick[2] + R.junk_thick[8] >= y_max then return -1 end
---##       else
---##         if R.junk_thick[4] + R.junk_thick[6] >= x_max then return -1 end
---##       end

      if PLAN.junk_mode == "few" and rand_odds(70) then
        return false
      end

      -- size checking
      local long = R.sw - R.junk_thick[4] - R.junk_thick[6]
      local deep = R.sh - R.junk_thick[2] - R.junk_thick[8]

      if R.mirror_x then long = int((long+3) / 2) end
      if R.mirror_y then deep = int((deep+3) / 2) end

      if is_vert(side) then long,deep = deep,long end

      if long <= 2 then return false end

      long = math.min(long, 8)

      local prob = JUNK_PROBS[long]
      if PLAN.junk_mode == "heaps" then prob = JUNK_HEAPS[long] end

      assert(prob)
      if not rand_odds(prob) then return false end


      -- connection checking
      local x1,y1, x2,y2 = side_coords(side, R.sx1,R.sy1, R.sx2,R.sy2)
      local dx, dy = dir_to_delta(side)
      x1, y1 = x1-dx*th, y1-dy*th
      x2, y2 = x2-dx*th, y2-dy*th

      local hit_conn = 0

      for x = x1,x2 do for y = y1,y2 do
        for who = 1,3 do
          local S = SEEDS[x][y][1]
          if who == 2 then S = R.mirror_x and S.x_peer end
          if who == 3 then S = R.mirror_y and S.y_peer end

          if S then
            if S.room ~= R then return false end
            if not (S.kind == "walk" or S.kind == "void") then return false end

            if S.conn or S.pseudo_conn then
              hit_conn = hit_conn + 1
            end
          end
        end -- for who
      end end -- for x,y

      -- Cannot allow "gaps" for connections (yet....)
      if hit_conn > 0 then return false end

      return true
    end

    local function apply_junk_side(side)
      local th = R.junk_thick[side]

      local x1,y1, x2,y2 = side_coords(side, R.sx1,R.sy1, R.sx2,R.sy2)
      local dx, dy = dir_to_delta(side)
      x1, y1 = x1-dx*th, y1-dy*th
      x2, y2 = x2-dx*th, y2-dy*th

      local p_conns = {}

      for x = x1,x2 do for y = y1,y2 do
        for who = 1,3 do
          local S = SEEDS[x][y][1]
          if who == 2 then S = R.mirror_x and S.x_peer end
          if who == 3 then S = R.mirror_y and S.y_peer end

          if S then
            if S.conn or S.pseudo_conn then
              error("Junked CONN!")
--??              local P = { x=x-dx, y=y-dy, conn=S.conn or S.pseudo_conn }
--??              table.insert(p_conns, P)
            elseif S.kind == "walk" then
              S.kind = "void"
            end
          end
        end -- for who
      end end -- for x,y

--??      for _,P in ipairs(p_conns) do
--??        SEEDS[P.x][P.y][1].pseudo_conn = P.conn
--??      end

      R.junk_thick[side] = R.junk_thick[side] + 1

      gui.debugf("Junked side:%d @ %s\n", side, R:tostr())

      if (is_horiz(side) and R.mirror_x) or
         (is_vert(side) and R.mirror_y)
      then
        side = 10 - side

        R.junk_thick[side] = R.junk_thick[side] + 1

        gui.debugf("and Junked mirrored side:%d\n", side)
      end
    end


    --| junk_sides |--

    local SIDES = { 2,4 }
    if not R.mirror_x then table.insert(SIDES,6) end
    if not R.mirror_y then table.insert(SIDES,8) end

    rand_shuffle(SIDES)

    for _,side in ipairs(SIDES) do
      if eval_side(side) then
        apply_junk_side(side)
      end
    end

    R.tx1 = R.sx1 + R.junk_thick[4]
    R.ty1 = R.sy1 + R.junk_thick[2]

    R.tx2 = R.sx2 - R.junk_thick[6]
    R.ty2 = R.sy2 - R.junk_thick[8]

    R.tw, R.th = box_size(R.tx1, R.ty1, R.tx2, R.ty2)
  end


  local function dir_for_wotsit(S)
    local dirs  = {}
  
    for dir = 2,8,2 do
      local N = S:neighbor(dir)
      if N and N.room == R and N.kind == "walk" then
        table.insert(dirs, dir)
      end
    end

    if #dirs == 1 then return dirs[1] end

    if #dirs > 1 then return rand_element(dirs) end

    return rand_irange(1,4)*2
  end

  local function add_purpose()
    local sx, sy, S = Layout_spot_for_wotsit(R, R.purpose)
    local z1 = S.floor_h or R.floor_h

    local mx, my = S:mid_point()

    if R.purpose == "START" then
      if rand_odds(10) then
        gui.debugf("Raising Start made\n")

        local info =
        {
          t_face = { texture=S.f_tex or R.combo.floor },
          b_face = { texture=S.f_tex or R.combo.floor },
          w_face = { texture=S.w_tex or R.combo.wall  },
        }

        Build_raising_start(S, 6, z1, info)
        S.no_floor = true
      else
        Build_pedestal(S, z1, "O_BOLT", "CEMENT2", -8)
      end

      local angle = 0  -- FIXME
      local dist = 56

      gui.add_entity(mx, my, z1 + 35,
      {
        name = tostring(GAME.things["player1"].id),
        angle = angle,
      })

      if GAME.things["player2"] then
        gui.add_entity(mx - dist, my, z1 + 35,
        {
          name = tostring(GAME.things["player2"].id),
          angle = angle,
        })

        gui.add_entity(mx + dist, my, z1 + 35,
        {
          name = tostring(GAME.things["player3"].id),
          angle = angle,
        })

        gui.add_entity(mx, my - dist, z1 + 35,
        {
          name = tostring(GAME.things["player4"].id),
          angle = angle,
        })
      end

    elseif R.purpose == "EXIT" then
      local CS = R.conns[1]:seed(R)
      local dir = dir_for_wotsit(S)

      if R.outdoor then
        Build_outdoor_exit_switch(S, dir, z1)
      else
        Build_exit_pillar(S, z1)
      end

    elseif R.purpose == "KEY" then
      Build_pedestal(S, z1, "CEIL1_2", "BLAKWAL2")

      gui.add_entity(mx, my, z1+40,
      {
        name = tostring(GAME.things[R.key_item].id),
      })
    elseif R.purpose == "SWITCH" then
gui.debugf("SWITCH ITEM = %s\n", R.do_switch)
      local LOCK = assert(R.lock_for_item)  -- eww
      local INFO = assert(GAME.switch_infos[R.do_switch])
      Build_small_switch(S, dir_for_wotsit(S), z1, INFO, LOCK.tag)

    else
      error("Layout_one: unknown purpose! " .. tostring(R.purpose))
    end
  end

  local function stairwell_height_diff(focus_C)
    local other_C = R.conns[2]
    if other_C == focus_C then other_C = R.conns[1] end

    assert(focus_C.conn_h)
    assert(not other_C.conn_h)

    other_C.conn_h = focus_C.conn_h

    if true then
      local delta = rand_element { -2,-2,-1, 1,2,2 }

      other_C.conn_h = other_C.conn_h + delta * 64

      if other_C.conn_h > 384 then other_C.conn_h = 384 end
      if other_C.conn_h <   0 then other_C.conn_h =   0 end
    end
  end

  local function flood_fill_for_junk()
    -- sets the floor_h (etc) for seeds in a junked side
    -- (which are ignored by Layout_try_pattern).

    gui.debugf("flood_fill_for_junk @ %s\n", R:tostr())

    local unset_list = {}

    for x = R.sx1,R.sx2 do for y = R.sy1,R.sy2 do
      local S = SEEDS[x][y][1]
      if S.room == R and S.kind == "walk" and not S.floor_h then
        if S.conn and S.conn.conn_h then
          S.floor_h = S.conn.conn_h
          S.f_tex   = S.conn.conn_ftex
        else
          table.insert(unset_list, S)
        end
      end
    end end -- for x, y

    local SIDES = { 2,4,6,8 }

    gui.debugf("  unset num: %d\n", #unset_list);

    while #unset_list > 0 do
      local new_list = {}

      for _,S in ipairs(unset_list) do
        local did_fix = false
        rand_shuffle(SIDES)
        for _,side in ipairs(SIDES) do
          local N = S:neighbor(side)
          if N and N.room and N.room == R and N.floor_h and
             (N.kind == "walk" or N.kind == "stair")
          then
            S.floor_h = N.floor_h
            S.f_tex   = N.f_tex
            did_fix   = true
            break;
          end
        end

        if not did_fix then
          table.insert(new_list, S)
        end
      end

      gui.debugf("  unset count now: %d\n", #new_list);

      if #new_list > 0 and #new_list == #unset_list then
        error("flood_fill_for_junk failed")
      end

      unset_list = new_list
    end
  end

  local function select_floor_texs(focus_C)
    local f_texs  = {}

    if focus_C.conn_ftex then
      table.insert(f_texs, focus_C.conn_ftex)
    end

    if R.combo.floors then
      for i = 1,4 do
        table.insert(f_texs, rand_element(R.combo.floors))
      end
    end
    
    while #f_texs < 4 do
      table.insert(f_texs, f_texs[1] or R.combo.floor)
    end

    return f_texs
  end

  local INDOOR_DELTAS  = { [64]=30, [96]=5,  [128]=10, [192]=2 }
  local OUTDOOR_DELTAS = { [48]=50, [96]=25, [144]=2 }

  local function select_heights(focus_C)

    local function gen_group(base_h, num, dir)
      local list = {}
      local delta_tab = sel(R.outdoor, OUTDOOR_DELTAS, INDOOR_DELTAS)

      for i = 1,num do
        table.insert(list, base_h)
        local delta = rand_key_by_probs(delta_tab)
        base_h = base_h + dir * delta
      end

      return list
    end


    ---| select_heights |---

    local base_h = focus_C.conn_h

    -- determine vertical momentum
    local mom_z = 0
    if R.entry_conn then
      local C2 = R.entry_conn.src.entry_conn
      if C2 and C2.conn_h and C2.conn_h ~= base_h then
        mom_z = sel(C2.conn_h < base_h, 1, -1)
      end 
      gui.debugf("Vertical momentum @ %s = %d\n", R:tostr(), mom_z)
    end

    local groups = {}

    for i = 1,10 do
      local dir = rand_sel(50, 1, -1)
      local hts = gen_group(base_h, 4, dir)

      local cost = math.abs(base_h - hts[4]) + gui.random()
      
      if dir ~= mom_z    then cost = cost + 100 end
      if hts[4] <= 0     then cost = cost + 200 end
      if hts[4] >= SKY_H then cost = cost + 300 end

      table.insert(groups, { hts=hts, dir=dir, cost=cost })
    end

    local g_info = table_pick_best(groups,
                      function(A,B) return A.cost < B.cost end)

    return g_info.hts
  end

  local function post_processing()
    -- this function sets up some stuff after the room patterns
    -- have been installed.  In particular it:
    -- (1) determines heights for stairs
    -- (2) handles diagonal seeds

    local function process_stair(S)

      local N = S:neighbor(S.stair_dir)

      assert(N and N.room == R)
      assert(R:contains_seed(N.sx, N.sy))

      -- source height already determined (in setup_stair)
      assert(S.stair_z1)

      if not N.floor_h then
        gui.debugf("Bad stair @ %s in %s\n", S:tostr(), S.room:tostr())
        error("Bad stair : destination not walkable")
      end

      S.stair_z2 = N.floor_h

      -- check if a stair is really needed
      if math.abs(S.stair_z1 - S.stair_z2) < 17 then
        S.kind = "walk"
        S.floor_h = int((S.stair_z1 + S.stair_z2) / 2)

        S.f_tex = N.f_tex
        S.w_tex = N.w_tex
      end

      -- check if too high, make a lift instead
      -- TODO: "lifty" mode, use > 55 or whatever
      if math.abs(S.stair_z1 - S.stair_z2) > 110 then
        S.kind = "lift"
      end
    end

    local function process_curve_stair(S)
      assert(S.x_side and S.y_side)

      local NX = S:neighbor(S.x_side)
      local NY = S:neighbor(S.y_side)

      S.x_height = assert(NX.floor_h)
      S.y_height = assert(NY.floor_h)

      S.floor_h = math.max(S.x_height, S.y_height)

      -- check if a stair is really needed
      if math.abs(S.x_height - S.y_height) < 17 then
        S.kind = "walk"
        S.floor_h = int((S.x_height + S.y_height) / 2)

        S.f_tex = NX.f_tex or NY.f_tex
        S.w_tex = NX.w_tex or NY.w_tex

        return
      end

      -- determine if can use tall stair

      if not R.outdoor then
        local OX = S:neighbor(10 - S.x_side)
        local OY = S:neighbor(10 - S.y_side)

        local x_void = not (OX and OX.room and OX.room == R) or (OX.kind == "void")
        local y_void = not (OY and OY.room and OY.room == R) or (OY.kind == "void")

        if x_void and y_void then
          S.stair_kind = "tall"
        end
      end
    end


    local function diag_neighbor(N)
      if not (N and N.room and N.room == R) then
        return "void"
      end

      if N.kind == "void" or N.kind == "liquid" then
        return N.kind
      end

      if N.kind == "diagonal" then
        return "void"
      end

      return "walk", assert(N.floor_h), N.f_tex
    end

    local DIAG_CORNER_TAB =
    {
      ["L/"] = 7, ["L%"] = 1, ["LZ"] = 3, ["LN"] = 1,
      ["H/"] = 3, ["H%"] = 9, ["HZ"] = 7, ["HN"] = 9,
    }

    local function process_diagonal(S)
gui.debugf("Processing diagonal @ %s\n", S:tostr())
      local low, high

      if S.diag_char == 'Z' or S.diag_char == 'N' then
        low  = S:neighbor(2)
        high = S:neighbor(8)
      else
        low  = S:neighbor(4)
        high = S:neighbor(6)
      end

      local l_kind, l_z, l_ftex
      local h_kind, h_z, h_ftex

      l_kind, l_z, l_ftex = diag_neighbor(low)
      h_kind, h_z, h_ftex = diag_neighbor(high)

      if l_kind == "void" and h_kind == "void" then
gui.debugf("BOTH VOID\n")
        S.kind = "void"
        return
      end

      if l_kind == "liquid" and h_kind == "liquid" then
gui.debugf("BOTH LIQUID\n")
        S.kind = "liquid"
        return
      end

      if l_kind == "walk" and h_kind == "walk" and math.abs(l_z-h_z) < 0.5 then
gui.debugf("BOTH SAME HEIGHT\n")
        S.kind = "walk"
        S.floor_h = l_z
        return
      end

      local who_solid

          if l_kind == "void"   then who_solid = 'L'
      elseif h_kind == "void"   then who_solid = 'H'
      elseif l_kind == "liquid" then who_solid = 'H'
      elseif h_kind == "liquid" then who_solid = 'L'
      else
        who_solid = sel(l_z > h_z, 'L', 'H')
      end

      S.stuckie_side = DIAG_CORNER_TAB[who_solid .. S.diag_char]
      assert(S.stuckie_side)

      S.stuckie_kind = sel(who_solid == 'L', l_kind, h_kind)
      S.stuckie_z    = sel(who_solid == 'L', l_z   , h_z)
      S.stuckie_ftex = sel(who_solid == 'L', l_ftex, h_ftex)

      S.diag_new_kind = sel(who_solid == 'L', h_kind, l_kind)
      S.diag_new_z    = sel(who_solid == 'L', h_z   , l_z)
      S.diag_new_ftex = sel(who_solid == 'L', h_ftex, l_ftex)

      assert(S.diag_new_kind ~= "void")
    end


    ---| post_processing |---

    for x = R.tx1, R.tx2 do for y = R.ty1, R.ty2 do
      local S = SEEDS[x][y][1]
      if S and S.room == R then
        if S.kind == "stair" then
          process_stair(S)
        elseif S.kind == "curve_stair" then
          process_curve_stair(S)
        end
      end
    end end -- for x, y

    -- need to do diagonals AFTER stairs

    for x = R.tx1, R.tx2 do for y = R.ty1, R.ty2 do
      local S = SEEDS[x][y][1]
      if S and S.room == R then
        if S.kind == "diagonal" then
          process_diagonal(S)
        end
      end
    end end -- for x, y
  end


  local PILLAR_PATTERNS =
  {
     "-2-",
     "1-1",
     "111",

     "-1-1-",
     "1-2-1",

     "1--1",
     "1111",

     "--1-1--",
     "-1---1-",
     "-1-2-1-",
     "1--2--1",
     "1-2-2-1",

     "-1--1-",
     "2-11-2",

     "--1--1--",
     "1-2--2-1",

     "--1-2-1--",
     "-1--2--1-",
     "-1-2-2-1-",
     "1---2---1",
     "2-1---1-2",

     "--1--2--1--",
     "-1---2---1-",
     "-1-1---1-1-",
     "1----2----1",
     "2--1---1--2",
  }

  local function can_pillar_pattern(side, offset, pat)
    local x1,y1, x2,y2 = side_coords(side, R.tx1,R.ty1, R.tx2,R.ty2)
    local pos = 1

    x1,y1 = nudge_coord(x1, y1, 10-side, offset)
    x2,y2 = nudge_coord(x2, y2, 10-side, offset)

    for x = x1,x2 do for y = y1,y2 do
      local S = SEEDS[x][y][1]

      local ch = string.sub(pat, pos, pos)
      pos = pos + 1
      assert(ch)

      if ch == '-' then
        if S.content == "pillar" then return false end
      else
        assert(is_digit(ch))
        if S.kind ~= "walk" or S.room ~= R or S.content or
           S.conn or S.pseudo_conn or S.must_walk
        then
          return false
        end
      end
    end end -- for x, y

    return true --OK--
  end

  local function make_pillar_pattern(side, offset, pat)
    local x1,y1, x2,y2 = side_coords(side, R.tx1,R.ty1, R.tx2,R.ty2)
    local pos = 1

    x1,y1 = nudge_coord(x1, y1, 10-side, offset)
    x2,y2 = nudge_coord(x2, y2, 10-side, offset)

    for x = x1,x2 do for y = y1,y2 do
      local S = SEEDS[x][y][1]

      local ch = string.sub(pat, pos, pos)
      pos = pos + 1

      if is_digit(ch) then
        S.content = "pillar"
        S.pillar_tex = sel(ch == '1', "TEKLITE", "SILVER2")
      end
    end end -- for x, y
  end

  local function add_pillars()
    if R.parent then return end

    -- FIXME this is too crude!
    if PLAN.pillar_mode == "few" then return end

    local SIDES = { 2, 4 }
    rand_shuffle(SIDES)

    for _,side in ipairs(SIDES) do for offset = 0,1 do
      local long, deep = R.tw, R.th
      if is_horiz(side) then long,deep = deep,long end

      if deep >= 3+offset*2 and long >= 3 then
        local lists = { {}, {} }

        for where = 1,2 do
          for _,pat in ipairs(PILLAR_PATTERNS) do
            if #pat == long and
               can_pillar_pattern(sel(where==1,side,10-side), offset, pat)
            then
              table.insert(lists[where], pat)
            end
          end -- for pat
        end -- for where

        -- FIXME: maintain symmetry : limit to symmetrical patterns
        --        and on certain sides we require the same pattern.

        if #lists[1] > 0 and #lists[2] > 0 then
          local pat1
          local pat2

          -- preference for same pattern
          for loop = 1,3 do
            pat1 = rand_element(lists[1])
            pat2 = rand_element(lists[2])
            if pat1 == pat2 then break; end
          end

          gui.debugf("Pillar patterns @ %s : %d=%s | %d=%s\n",
                     R:tostr(), side, pat1, 10-side, pat2)

          make_pillar_pattern(side,    offset, pat1)
          make_pillar_pattern(10-side, offset, pat2)

          R.pillar_rows =
          { 
            { side=side,    offset=offset },
            { side=10-side, offset=offset },
          }

          return --OK--
        end
      end
    end end -- for side, offset
  end


  ---==| Layout_one |==---

gui.debugf("LAYOUT %s >>>>\n", R:tostr())

  local focus_C = R.entry_conn
  if not focus_C then
    focus_C = assert(R.conns[1])
  end

  R.focus_conn = focus_C


  if not focus_C.conn_h then
gui.debugf("NO ENTRY HEIGHT @ %s\n", R:tostr())
    focus_C.conn_h = SKY_H - rand_irange(4,7) * 64
  end

  R.floor_h = focus_C.conn_h  -- ??? BLEH

  -- special stuff
  if R.kind == "stairwell" then
    stairwell_height_diff(focus_C)

    local WELL_TEX = { "BROWN1", "GRAY1", "STARGR1", "METAL4" }
    if not PLAN.well_tex then
      PLAN.well_tex = rand_element(WELL_TEX)
    end

    local wall_info =
    {
      t_face = { texture="FLOOR7_1" },
      b_face = { texture="FLOOR7_1" },
      w_face = { texture=PLAN.well_tex },
    }
    local flat_info =
    {
      t_face = { texture="FLAT1" },
      b_face = { texture="FLOOR7_1" },
      w_face = { texture="BROWN1" },
    }

    Build_stairwell(R, wall_info, flat_info)
    return
  end

  if R.kind == "hallway" then
    Layout_hallway(R, focus_C.conn_h)
    return
  end

  if R.kind == "smallexit" then
    local item = tostring(GAME.things["medikit"].id)
    Build_small_exit(R, item)
    return
  end


  R.tx1, R.ty1 = R.sx1, R.sy1
  R.tx2, R.ty2 = R.sx2, R.sy2
  R.tw,  R.th  = R.sw,  R.sh

  R.junk_thick = { [2]=0, [4]=0, [6]=0, [8]=0 }

  if R.kind == "building" and not R.children then
    junk_sides()
  end


  local area =
  {
    x1 = R.tx1, y1 = R.ty1,
    x2 = R.tx2, y2 = R.ty2,
  }

  local heights = select_heights(focus_C)
  local f_texs  = select_floor_texs(focus_C)

  Layout_try_pattern(R, true, 1, R.symmetry, area, heights, f_texs)

---??  flood_fill_for_junk()

  post_processing()

  for _,C in ipairs(R.conns) do
-- if not C.conn_h then gui.debugf("CONN_H NOT SET @ %s\n", C.src_S:tostr()) ; C.conn_h = 1 ; C.src_S.f_tex = "LAVA1" end --!!!!!!!
    assert(C.conn_h)
  end


  Layout_set_floor_minmax(R)

  if R.purpose then
    add_purpose()
  end

  if R.kind == "building" then
    add_pillars()
  end
end

