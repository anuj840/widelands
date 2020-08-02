dirname = path.dirname(__file__)

tribes:new_productionsite_type {
   msgctxt = "amazons_building",
   name = "amazons_rare_trees_woodcutters_hut",
   -- TRANSLATORS: This is a building name used in lists of buildings
   descname = pgettext("amazons_building", "Rare Tree Woodcutter's Hut"),
   helptext_script = dirname .. "helptexts.lua",
   icon = dirname .. "menu.png",
   size = "small",

   enhancement_cost = {
      log = 1,
      granite = 1,
      rope = 1
   },
   return_on_dismantle_on_enhanced = {
      log = 1,
      rope = 1
   },

   animation_directory = dirname,
   animations = {
      idle = {hotspot = {40, 66}},
      unoccupied = {hotspot = {39, 66}}
   },

   aihints = {
      collects_ware_from_map = "rubber",
      -- dirty hack to inverse relation between cutter and plantation
      supports_production_of = { "ironwood" },
      requires_supporters = true,
   },

   working_positions = {
      amazons_woodcutter_master = 1
   },

   programs = {
      work = {
         -- TRANSLATORS: Completed/Skipped/Did not start working because ...
         descname = _"working",
         actions = {
            "call=harvest_balsa",
            "call=harvest_rubber",
            "call=harvest_ironwood",
         },
      },
      harvest_balsa = {
         -- TRANSLATORS: Completed/Skipped/Did not start preparing only one ration because ... (can produce more efficient when supply is good)
         descname = _"harvesting balsa",
         actions = {
            -- time total: xx
            "callworker=harvest_balsa",
            "sleep=12000"
         },
      },
      harvest_rubber = {
         -- TRANSLATORS: Completed/Skipped/Did not start preparing only one ration because ... (can produce more efficient when supply is good)
         descname = _"harvesting rubber",
         actions = {
            -- time total: xx
            "callworker=harvest_rubber",
            "sleep=12000"
         },
      },
      harvest_ironwood = {
         -- TRANSLATORS: Completed/Skipped/Did not start preparing only one ration because ... (can produce more efficient when supply is good)
         descname = _"harvesting ironwood",
         actions = {
            -- time total: xx
            "callworker=harvest_ironwood",
            "sleep=12000"
         },
      },
   },
}
