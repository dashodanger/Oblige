------------------------------------------------------------------------
--  ITEM SELECTION / PLACEMENT
------------------------------------------------------------------------
--
--  Oblige Level Maker
--
--  Copyright (C) 2006-2015 Andrew Apted
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
------------------------------------------------------------------------


HEALTH_FACTORS =
{
  none=0, scarce=0.40, less=0.64, normal=1.00, more=1.50, heaps=2.50
}

AMMO_FACTORS =
{
  none=0, scarce=0.60, less=0.80, normal=1.00, more=1.25, heaps=1.80
}


COOP_HEALTH_FACTOR = 1.35
COOP_AMMO_FACTOR   = 1.35


-- Doom flags
DOOM_FLAGS =
{
  EASY    = 1
  MEDIUM  = 2
  HARD    = 4
  DEAF    = 8
}

-- Hexen thing flags
HEXEN_FLAGS =
{
  FIGHTER = 32
  CLERIC  = 64
  MAGE    = 128

  DM      = 1024
}

-- Quake flags
QUAKE_FLAGS =
{
  DEAF       = 1

  NOT_EASY   = 256
  NOT_MEDIUM = 512
  NOT_HARD   = 1024
  NOT_DM     = 2048
}

-- Hexen2 flags  [NOT USED YET]
HEXEN2_FLAGS =
{
  NOT_PALADIN  = 256
  NOT_CLERIC   = 512
  NOT_NECRO    = 1024
  NOT_ASSASSIN = 2048

  NOT_EASY     = 4096
  NOT_MEDIUM   = 8192
  NOT_HARD     = 16384
  NOT_DM       = 32768
}


function Player_init()
  LEVEL.hmodels = table.deep_copy(GAME.PLAYER_MODEL)

  each CL,hmodel in LEVEL.hmodels do
    hmodel.class = CL
  end
end


function Player_give_weapon(weapon, only_CL)
  gui.printf("Giving weapon: %s\n", weapon)

  each CL,hmodel in LEVEL.hmodels do
    if not only_CL or (only_CL == CL) then
      hmodel.weapons[weapon] = 1
    end
  end
end


function Player_give_class_weapon(slot)
  each name,W in GAME.WEAPONS do
    each CL,hmodel in LEVEL.hmodels do
      if W.slot == slot and W.class == CL then
        hmodel.weapons[name] = 1
      end
    end
  end
end


function Player_give_map_stuff()
  if LEVEL.assume_weapons then
    each name,_ in LEVEL.assume_weapons do
          if name == "weapon2" then Player_give_class_weapon(2)
      elseif name == "weapon3" then Player_give_class_weapon(3)
      elseif name == "weapon4" then Player_give_class_weapon(4)
      else
        Player_give_weapon(name)
      end
    end
  end
end


function Player_give_room_stuff(R)
  if R.weapons and not PARAM.hexen_weapons then
    each name in R.weapons do
      Player_give_weapon(name)
      local weap = GAME.WEAPONS[name]
      if weap and weap.give then
        Player_give_stuff(LEVEL.hmodels.doomguy, weap.give)
      end
      EPISODE.seen_weapons[name] = 1
    end
  end
end


function Player_give_stuff(hmodel, give_list)
  each give in give_list do
    if give.health then
      gui.debugf("Giving [%s] health: %d\n",
                 hmodel.class, give.health)
      hmodel.stats.health = hmodel.stats.health + give.health

    elseif give.ammo then
      gui.debugf("Giving [%s] ammo: %dx %s\n",
                 hmodel.class, give.count, give.ammo)

      hmodel.stats[give.ammo] = (hmodel.stats[give.ammo] or 0) + give.count

    elseif give.weapon then
      gui.debugf("Giving [%s] weapon: %s\n",
                 hmodel.class, give.weapon)

      hmodel.weapons[give.weapon] = 1
    else
      error("Bad give item : not health, ammo or weapon")
    end
  end
end


function Player_firepower()
  -- The 'firepower' is (roughly) how much damage per second
  -- the player would normally do using their current set of
  -- weapons.
  --
  -- If there are different classes (Hexen) then the result
  -- will be an average of each class, as all classes face
  -- the same monsters.

  local function get_firepower(hmodel)
    local firepower = 0 
    local divisor   = 0

    each weapon,_ in hmodel.weapons do
      local info = GAME.WEAPONS[weapon]

      if not info then
        error("Missing weapon info for: " .. weapon)
      end

      local dm = info.damage * info.rate
      if info.splash then dm = dm + info.splash[1] end

      -- melee attacks are hard to use, and
      -- projectiles miss more often than hitscan
      if info.attack == "melee" then
        dm = dm / 3.0
      elseif info.attack == "missile" then
        dm = dm / 1.3
      end

      local pref = info.pref or 1

---   gui.debugf("  weapon:%s dm:%1.1f pref:%1.1f\n", weapon, dm, pref)

      firepower = firepower + dm * pref
      divisor   = divisor + pref
    end

    if divisor == 0 then
      error("Player_firepower: no weapons???")
    end

    return firepower / divisor
  end

  ---| Player_firepower |---

  local fp_total  = 0
  local class_num = 0

  each CL,hmodel in LEVEL.hmodels do
    fp_total = fp_total + get_firepower(hmodel)
    class_num = class_num + 1
  end

  assert(class_num > 0)

  return fp_total / class_num
end


function Player_has_weapon(weap_needed)
  
  local function class_has_one(hmodel)
    each name,_ in hmodel.weapons do
      if weap_needed[name] then
        return true
      end
    end
    return false
  end

  --| Player_has_weapon |--

  -- we require a match for every class

  each CL,hmodel in LEVEL.hmodels do
    if not class_has_one(hmodel) then
      return false
    end
  end

  return true -- OK
end


function Player_has_min_weapon(min_weapon)
  each name,info in GAME.WEAPONS do
    if (info.level or 0) >= min_weapon then
      if Player_has_weapon({ [name]=1 }) then
        return true
      end
    end
  end

  return false
end


function Player_weapon_palettes()

  local Middle  = 1.00
  local High    = 2.20
  local Highest = 4.80
  local Low     = 0.44
  local Lowest  = 0.21


  local function initial_weapons()
    -- find with weapons the player always owns
    local list = {}

    each CL,hmodel in LEVEL.hmodels do
      each name,_ in hmodel.weapons do
        list[name] = 1
      end
    end

    return list
  end


  local function add_weapons_from_zone(Z, list)

--!!!!!!!
do return end


    each R in Z.rooms do
      each name in R.weapons do
        list[name] = 1
      end
    end
  end


  local function insert_multiple(list, count, what)
    for i = 1, count do
      table.insert(list, what)
    end
  end


  local function decide_quantities(total)
    local list = {}

    -- Note: result is often longer than strictly required

    local num_low  = int(total / 2 + gui.random())
    local num_high = total - num_low

    insert_multiple(list, num_low,  Low)
    insert_multiple(list, num_high, High)

    if total >= 2 then
      local num_very = int(total / 6 + gui.random())

      insert_multiple(list, num_very, Lowest)
      insert_multiple(list, num_very, Highest)
    end

    assert(#list >= total)

    rand.shuffle(list)

    return list
  end


  local function apply_pref_table(pal, prefs)
    if not prefs then return end

    each name,factor in prefs do
      if pal[name] then
         pal[name] = pal[name] * factor
      end
    end
  end


  local function gen_palette(got_weaps)
    local total = table.size(got_weaps)

    -- TODO: support Hexen
    if total < 2 or PARAM.hexen_weapons then
      return {}
    end

    local pal = {}

    -- decide number of "normal" weapons : at least one!
    local normal_num = int(total / 3 + gui.random())
    if normal_num < 1 then normal_num = 1 end

    got_weaps = table.copy(got_weaps)

    for n = 1, normal_num do
      local name = rand.key_by_probs(got_weaps)

      pal[name] = Middle
      got_weaps[name] = nil
    end

    -- decide what to give everything else
    total = total - normal_num

    local quants = decide_quantities(total)

    each name,_ in got_weaps do
      pal[name] = table.remove(quants, 1)
    end

    -- apply level and theme preferences
    apply_pref_table(pal, LEVEL.weap_prefs)
    apply_pref_table(pal, THEME.weap_prefs)

    return pal
  end


  local function dump_palette(pal)
    each weap,qty in pal do
      gui.debugf("   %-9s* %1.2f\n", weap, qty)
    end
  end


  ---| Player_weapon_palettes |---

  -- Note: not using initial_weapons() here, they tend to be melee
  --       weapons and it sucks to promote them.
  local got_weaps = {}

  each Z in LEVEL.zones do
    add_weapons_from_zone(Z, got_weaps)

    Z.weap_palette = gen_palette(got_weaps)

    gui.debugf("Weapon palette in ZONE_%d:\n", Z.id)
    dump_palette(Z.weap_palette)
  end
end


------------------------------------------------------------------------


function Item_simulate_battles()
  
  local R  -- current room


  local function make_empty_stats()
    local stats = {}

    each CL,_ in GAME.PLAYER_MODEL do
      stats[CL] = {}
    end

    return stats
  end


  local function user_adjust_result(stats)
    -- apply the user's health/ammo adjustments here

    local heal_mul = HEALTH_FACTORS[OB_CONFIG.health]
    local ammo_mul =   AMMO_FACTORS[OB_CONFIG.ammo]

    heal_mul = heal_mul * (PARAM.health_factor or 1)
    ammo_mul = ammo_mul * (PARAM.ammo_factor or 1)

    -- give less ammo in later maps (to counter the build-up over an episode)
    if not PARAM.pistol_starts then
      local along = math.clamp(0, LEVEL.ep_along - 0.2, 0.8)
      local factor = 1.0 - along * 0.25

      ammo_mul = ammo_mul * factor
    end

    if OB_CONFIG.mode == "coop" then
      heal_mul = heal_mul * COOP_HEALTH_FACTOR
      ammo_mul = ammo_mul * COOP_AMMO_FACTOR
    end

    each name,qty in stats do
      if name == "health" then
        stats[name] = qty * heal_mul
      else
        stats[name] = qty * ammo_mul
      end
    end
  end


  local function subtract_stuff_we_have(stats, hmodel)
    each name,have_qty in hmodel.stats do
      local need_qty = stats[name] or 0
      if have_qty > 0 and need_qty > 0 then
        local min_q = math.min(have_qty, need_qty)

               stats[name] =        stats[name] - min_q
        hmodel.stats[name] = hmodel.stats[name] - min_q
      end
    end
  end


  local function give_monster_drops(hmodel, mon_list)
    each M in mon_list do
      if M.is_cage then continue end

      if M.info.give then
        Player_give_stuff(hmodel, M.info.give)
      end
    end
  end


  local function is_weapon_upgraded(name, list)
    each W in list do
      if W.info.upgrades == name then
        return true
      end
    end

    return false
  end


  local function collect_weapons(hmodel)
    local list = {}
    local seen = {}

    each name,_ in hmodel.weapons do
      local info = assert(GAME.WEAPONS[name])

      local factor = R.zone.weap_palette[name]

      if info.pref then
        table.insert(list, { info=info, factor=factor })
        seen[name] = true
      end
    end

    -- gameplay_tweaks : assume weapons from previous levels
    if PARAM.keep_weapons then
      each name,_ in EPISODE.seen_weapons do
      if not seen[name] then
        local info = assert(GAME.WEAPONS[name])
        assert(info.pref)

        table.insert(list, { info=info, factor=0.5 })
      end
      end
    end

    if #list == 0 then
      error("No usable weapons???")
    end

    -- remove "upgraded" weapons (e.g. supershotgun > shotgun)

    for i = #list, 1, -1 do
      if is_weapon_upgraded(list[i].info.name, list) then
        table.remove(list, i)
      end
    end

    return list
  end


  local function battle_for_class(CL, hmodel)
    local mon_list = R.monster_list

    local weap_list = collect_weapons(hmodel)

    local stats = R.item_stats[CL]

    gui.debugf("Fight Simulator @ %s  class: %s\n", R:tostr(), CL)

    gui.debugf("weapons = \n")
    each W in weap_list do
      gui.debugf("  %s\n", W.info.name)
    end

    Fight_Simulator(mon_list, weap_list, stats)

--  gui.debugf("raw result = \n%s\n", table.tostr(stats,1))

    user_adjust_result(stats)

--  gui.debugf("adjusted result = \n%s\n", table.tostr(stats,1))

    give_monster_drops(hmodel, mon_list)

    subtract_stuff_we_have(stats, hmodel)
  end


  local function sim_battle(room)
    R = room

    assert(R.monster_list)

    R.item_stats = make_empty_stats()

    if #R.monster_list >= 1 then
      each CL,hmodel in LEVEL.hmodels do
        battle_for_class(CL, hmodel)
      end
    end
  end


  ---| Item_simulate_battles |---

  each room in LEVEL.rooms do
    sim_battle(room)
  end
end



function Item_distribute_stats()
  --|
  --| This distributes the item statistics (how much health and ammo to
  --| give the player needs) into earlier rooms and also storage rooms
  --| in the same zone.
  --|

  -- health mainly stays in same room (a reward for killing the monsters).
  -- ammo mainly goes back, to prepare player for the fight.
  local health_factor = 0.25
  local ammo_factor   = 0.65

  local function get_previous_locs(room)
    local list = {}

    -- find previous rooms
    local R = room

    while R.entry_conn do
      R = R.entry_conn:neighbor(R)

      if R.kind != "hallway" then
        local ratio = rand.irange(3,7) / (2.0 ^ #list)
        table.insert(list, { room=R, ratio=ratio })
      end
    end

    -- add storage rooms
    -- FIXME !!!!
--[[
    if room.zone.storage_rooms then
      each R in room.zone.storage_rooms do
        local ratio = rand.irange(3,7) / 2.0
        table.insert(list, { room=R, ratio=ratio })
      end
    end
--]]

    return list
  end


  local function distribute(R, N, ratio)
    each CL,R_stats in R.item_stats do
      local N_stats = N.item_stats[CL]

      each stat,count in R_stats do
        if count <= 0 then continue end

        local value

        if stat == "health" then
          value = count * health_factor * ratio
        else 
          value = count * ammo_factor * ratio
        end

        N_stats[stat] = (N_stats[stat] or 0) + value
        R_stats[stat] =  R_stats[stat]       - value

        gui.debugf("Distributing %s:%1.1f [%s]  %s --> %s\n",
                   stat, value,  CL, R:tostr(), N:tostr())
      end
    end
  end


  local function distribute_to_list(R, list)
    local total = 0

    each loc in list do
      total = total + loc.ratio
    end

    each loc in list do
      distribute(R, loc.room, loc.ratio / total)
    end
  end


  ---| Item_distribute_stats |---

  -- Note: we don't distribute to or from hallways

  each R in LEVEL.rooms do
    if R.is_storage then continue end

    if R.item_stats then
      distribute_to_list(R, get_previous_locs(R))
    end
  end

  each R in LEVEL.rooms do
    if R.item_stats then
      gui.debugf("final result @ %s = \n%s\n", R:tostr(),
                 table.tostr(R.item_stats, 2))
    end
  end
end



function Item_pickups_in_room(R)
  --
  -- Once all monsters have been placed and all battles simulated
  -- (including cages and traps), then we can decide *what* pickups to add
  -- (the easy part) and *where* to place them (the hard part).
  --

  local function grab_a_big_spot(R)
    local result = table.pick_best(R.big_spots,
            function(A, B) return A.score > B.score end, "remove")

    -- update remaining scores so next one chosen is far away
    each spot in R.big_spots do
      local dist = Monsters_dist_between_spots(spot, result, 80) / 256

      spot.score = spot.score + dist
    end

    return result
  end


  local function place_item(item_name, x, y, z)
    local props = {}

    if PARAM.use_spawnflags then
      -- no change
    else
      props.flags = DOOM_FLAGS.EASY + DOOM_FLAGS.MEDIUM + DOOM_FLAGS.HARD
    end

    Trans.entity(item_name, x, y, z, props)
  end


  local function place_item_in_spot(item_name, spot)
    local x, y = geom.box_mid(spot.x1, spot.y1, spot.x2, spot.y2)

    place_item(item_name, x, y, spot.z1)
  end


  local function find_cluster_spot(R, prev_spots, item_name)
    if #prev_spots == 0 then
      local spot = table.remove(R.item_spots, 1)
      table.insert(prev_spots, spot)
      return spot
    end

    local best_idx
    local best_dist

    -- FIXME: optimise this!
    for index = 1,#R.item_spots do
      local spot = R.item_spots[index]
      local dist = 9e9

      each prev in prev_spots do
        local d = Monsters_dist_between_spots(prev, spot)
        dist = math.min(dist, d)
      end

      -- prefer closest row to a wall
      if spot.wall_dist then
        dist = dist + spot.wall_dist * 200
      end

      -- avoid already used spots
      if spot.used then dist = dist + 100000 end

      if not best_idx or dist < best_dist then
        best_idx  = index
        best_dist = dist
      end
    end

    assert(best_idx)

    local spot = table.remove(R.item_spots, best_idx)

    if #prev_spots >= 3 then
      table.remove(prev_spots, 1)
    end

    table.insert(prev_spots, spot)

    return spot
  end


  local function place_item_list(R, item_list, CL)
    each pair in item_list do
      local item  = pair.item
      local count = pair.count

      -- big item?
      if (item.rank or 0) >= 2 and count == 1 and not table.empty(R.big_spots) then
        local spot = grab_a_big_spot(R)
        place_item_in_spot(item.name, spot)
        continue
      end

      -- keep track of a limited number of previously chosen spots.
      -- when making clusters, this is used to find the next spot.
      local prev_spots = {}

      for i = 1,count do
        if table.empty(R.item_spots) then
          gui.printf("Unable to place items: %s x %d\n", item.name, count+1-i)
          break;
        end

        local spot = find_cluster_spot(R, prev_spots, item.name)

        place_item_in_spot(item.name, spot)

        -- reuse spots if they run out
        spot.used = true
        table.insert(R.item_spots, spot)
      end
    end
  end


  local function decide_pickup(R, stat, qty)
    local item_tab = {}

    each name,info in GAME.PICKUPS do
      -- compatibilty crud...
      local prob = info.add_prob or info.prob

      if prob and
         (stat == "health" and info.give[1].health) or
         (info.give[1].ammo == stat)
      then
        item_tab[name] = prob

        if R.is_start and info.start_prob then
          item_tab[name] = info.start_prob
        end
      end
    end

    assert(not table.empty(item_tab))

    local name = rand.key_by_probs(item_tab)
    local info = GAME.PICKUPS[name]

    local count = 1
    
    if info.cluster then
      local each_qty = info.give[1].health or info.give[1].count
      local min_num  = info.cluster[1]
      local max_num  = info.cluster[2]

      assert(max_num <= 9)

      --- count = rand.irange(min_num, max_num)

      if min_num * each_qty >= qty then
        count = min_num
      elseif max_num * each_qty <= qty then
        count = max_num - rand.sel(20,1,0)
      else
        count = 1 + int(qty / each_qty)
      end
    end

    return GAME.PICKUPS[name], count
  end


  local function bonus_for_room(R, stat)
    local bonus = 0

    -- more stuff in start room
    if R.is_start then
      if stat == "health" then
        bonus = 20
      end
    end

    -- when getting a weapon, should get some ammo for it too
    if R.weapons then
      each name in R.weapons do
        local info = GAME.WEAPONS[name]

        if info.ammo and info.ammo == stat and info.bonus_ammo then
          bonus = bonus + info.bonus_ammo
        end
      end
    end

    if OB_CONFIG.strength == "crazy" then
      bonus = bonus * 2
    end

    -- compensation for environmental hazards
    if stat == "health" and R.hazard_health then
      bonus = bonus + R.hazard_health
    end

    return bonus
  end


  local function do_select_pickups(R, item_list, stat, qty)
    assert(qty >= 0)

    while qty > 0 do
      local item, count = decide_pickup(R, stat, qty)
      table.insert(item_list, { item=item, count=count, random=gui.random() })

      if stat == "health" then
        qty = qty - item.give[1].health * count
      else
        assert(item.give[1].ammo)
        qty = qty - item.give[1].count * count
      end
    end

    -- return the excess amount
    return (-qty)
  end


  local function select_pickups(R, item_list, stat, qty, hmodel)
    assert(qty >= 0)

    if hmodel.stats[stat] == nil then
       hmodel.stats[stat] = 0
    end

    local actual_qty = 0

    -- when the player is already holding more than required, simply
    -- reduce the hmodel (don't place any items).
    if hmodel.stats[stat] >= qty then
      hmodel.stats[stat] = hmodel.stats[stat] - qty
    else
      actual_qty = qty - hmodel.stats[stat]
      hmodel.stats[stat] = 0
    end

    -- bonus stuff : this is _not_ applied to the hmodel
    -- (otherwise future rooms would get less of it).
    actual_qty = actual_qty + bonus_for_room(R, stat)

    local excess = do_select_pickups(R, item_list, stat, actual_qty)

    -- there will usually be a small excess amount, since items come
    -- in discrete quantities.  accumulate it into the hmodel...
    hmodel.stats[stat] = hmodel.stats[stat] + excess
  end


  local function compare_items(A, B)
    local A_rank = A.item.rank or 0
    local B_rank = B.item.rank or 0

    if A_rank != B_rank then return A_rank > B_rank end

     return (A.count + A.random) > (B.count + B.random)
  end


  local function pickups_for_class(R, CL, hmodel)
    if table.empty(GAME.PICKUPS) then
      return
    end

    local stats = R.item_stats[CL]
    local item_list = {}

    each stat,qty in stats do
      -- this updates the hmodel too
      select_pickups(R, item_list, stat, qty, hmodel)

      gui.debugf("Item list for %s:%1.1f [%s] @ %s\n", stat,qty, CL, R:tostr())

      each pair in item_list do
        local item = pair.item
        gui.debugf("   %dx %s (%d)\n", pair.count, item.name,
                   item.give[1].health or item.give[1].count)
      end
    end

    rand.shuffle(R.item_spots)

    -- sort items by rank
    -- also: place large clusters before small ones
    table.sort(item_list, compare_items)

    place_item_list(R, item_list, CL)
  end


  ---| Item_pickups_in_room |---

  R.item_spots = Monsters_split_spots(R.item_spots, 25)

  each CL,hmodel in LEVEL.hmodels do
    pickups_for_class(R, CL, hmodel)
  end
end



function Item_add_pickups()

  gui.printf("\n--==| Item Pickups |==--\n\n")

  Item_simulate_battles()

  Item_distribute_stats()

  each R in LEVEL.rooms do
    Item_pickups_in_room(R)
  end
end

