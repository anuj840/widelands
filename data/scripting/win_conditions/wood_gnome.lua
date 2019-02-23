-- =======================================================================
--                       Wood Gnome win condition
-- =======================================================================

include "scripting/coroutine.lua" -- for sleep
include "scripting/table.lua"
include "scripting/win_conditions/win_condition_functions.lua"

set_textdomain("win_conditions")

include "scripting/win_conditions/win_condition_texts.lua"

local wc_name = "Wood Gnome"
-- This needs to be exactly like wc_name, but localized, because wc_name
-- will be used as the key to fetch the translation in C++
local wc_descname = _("Wood Gnome")
local wc_version = 2
local wc_desc = _(
[[As wood gnome you like big forests, so your task is to have more trees on ]] ..
[[your territory than any other player. The game will end after 4 hours of ]] ..
[[playing. The one with the most trees at that point will win the game.]])
local wc_trees_owned = _"Trees owned"


-- Table of terrestrial fields
local fields = {}

return {
   name = wc_name,
   description = wc_desc,
   init = function()
      -- Get all terrestrial fields of the map
      fields = wl.Game().map.terrestrial_fields
   end,
   func = function()
   local plrs = wl.Game().players
   local game = wl.Game()

   -- set the maximum game time of 4 hours
   local max_time = 4 * 60

   -- set the objective with the game type for all players
   broadcast_objective("win_condition", wc_descname, wc_desc)

   -- The function to calculate the current points.
   local _last_time_calculated = -100000
   local _plrpoints = {}
   local function _calc_points()
      local game = wl.Game()

      if _last_time_calculated > game.time - 5000 then
         return _plrpoints
      end

      -- clear out the table. We count afresh.
      for k,v in pairs(_plrpoints) do
         _plrpoints[k] = 0
      end

      -- Insert all players who are still in the game.
      for idx,plr in ipairs(plrs) do
         _plrpoints[plr.number] = 0
      end

      for idf,f in ipairs(fields) do
         -- check if field is owned by a player
         local owner = f.owner
         if owner and not owner.defeated then
            owner = owner.number
            -- check if field has an immovable
            local imm = f.immovable
            if imm then
               -- check if immovable is a tree
               if imm:has_attribute("tree") then
                  _plrpoints[owner] = _plrpoints[owner] + 1
               end
            end
         end
      end

      _last_time_calculated = game.time
      return _plrpoints
   end

   local function _send_state(remaining_time, plrs, show_popup)
      local playerpoints = _calc_points()
      local msg = format_remaining_time(remaining_time) .. vspace(8) .. game_status.body

      for idx,plr in ipairs(plrs) do
         local trees = (ngettext ("%i tree", "%i trees", playerpoints[plr.number]))
               :format(playerpoints[plr.number])
         -- TRANSLATORS: %1$s = player name, %2$s = x tree(s)
         msg = msg .. p(_"%1$s has %2$s at the moment."):bformat(plr.name,trees)
      end

      broadcast(plrs, game_status.title, msg, {popup = show_popup})
   end

   local function _game_over(plrs)
      local playerpoints = _calc_points()
      local points = {}
      for idx,plr in ipairs(plrs) do
         points[#points + 1] = { plr, playerpoints[plr.number] }
      end
      table.sort(points, function(a,b) return a[2] < b[2] end)

      local msg = vspace(8) .. game_status.body
      for idx,plr in ipairs(plrs) do
         msg = msg .. vspace(8)
         local trees = (ngettext ("%i tree", "%i trees", playerpoints[plr.number])):format(playerpoints[plr.number])
         -- TRANSLATORS: %1$s = player name, %2$s = x tree(s)
         msg = msg ..  p(_"%1$s had %2$s."):bformat(plr.name,trees)
      end
      msg = msg .. vspace(8)
      local trees = (ngettext ("%i tree", "%i trees", playerpoints[points[#points][1].number]))
            :format(playerpoints[points[#points][1].number])
      -- TRANSLATORS: %1$s = player name, %2$s = x tree(s)
      msg = msg ..  h3(_"The winner is %1$s with %2$s."):bformat(points[#points][1].name, trees)

      local privmsg = ""
      for i=1,#points-1 do
         privmsg = lost_game_over.body
         privmsg = privmsg .. msg
         points[i][1]:send_message(lost_game_over.title, privmsg)
         wl.game.report_result(points[i][1], 0, make_extra_data(points[i][1], wc_descname, wc_version, {score=points[i][2]}))
      end
      privmsg = won_game_over.body
      privmsg = privmsg .. msg
      points[#points][1]:send_message(won_game_over.title, privmsg)
      wl.game.report_result(points[#points][1], 1,
         make_extra_data(points[#points][1], wc_descname, wc_version, {score=points[#points][2]}))
   end

   -- Install statistics hook
   hooks.custom_statistic = {
      name = wc_trees_owned,
      pic = "images/wui/stats/genstats_trees.png",
      calculator = function(p)
         local pts = _calc_points(p)
         return pts[p.number]
      end,
   }

   -- Start a new coroutine that triggers status notifications.
   run(function()
      local remaining_time = max_time
      while game.time <= ((max_time - 5) * 60 * 1000) and count_factions(plrs) > 1 do
         remaining_time, show_popup = notification_remaining_time(max_time, remaining_time)
         _send_state(remaining_time, plrs, show_popup)
      end
   end)

   -- main loop checks for defeated players
   while game.time < (max_time * 60 * 1000) and count_factions(plrs) > 1 do
      sleep(1000)
      check_player_defeated(plrs, lost_game.title, lost_game.body, wc_descname, wc_version)
   end

   -- Game has ended
   _game_over(plrs)

end
}
