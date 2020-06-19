dirname = path.dirname(__file__)

tribes:new_productionsite_type {
   msgctxt = "amazons_building",
   name = "amazons_furnace",
   -- TRANSLATORS: This is a building name used in lists of buildings
   descname = pgettext("amazons_building", "Furnace"),
   helptext_script = dirname .. "helptexts.lua",
   icon = dirname .. "menu.png",
   size = "medium",

   buildcost = {
      granite = 5,
      ironwood = 2
   },
   return_on_dismantle = {
      granite = 3,
      ironwood = 1
   },

   animation_directory = dirname,
   animations = {unoccupied = {hotspot = {43, 44}}},
   spritesheets = {
      idle = {
         hotspot = {43, 44},
         fps = 4,
         frames = 4,
         columns = 2,
         rows = 2
      },
      working = {
         hotspot = {43, 44},
         fps = 15,
         frames = 30,
         columns = 6,
         rows = 5
      }
   },

   aihints = {
      prohibited_till = 700,
      very_weak_ai_limit = 1,
      weak_ai_limit = 2,
      --basic_amount = 1
   },

   working_positions = {
      amazons_gold_smelter = 1
   },

   inputs = {
      { name = "charcoal", amount = 8 },
      { name = "gold_dust", amount = 8 },
   },
   outputs = {
      "gold"
   },

   programs = {
      work = {
         -- TRANSLATORS: Completed/Skipped/Did not start smelting gold because ...
         descname = _"smelting gold",
         actions = {
            "return=skipped unless economy needs gold",
            "consume=charcoal gold_dust",
            "sleep=30000",
            "animate=working 42000",
            "produce=gold"
         },
      },
   },
}
