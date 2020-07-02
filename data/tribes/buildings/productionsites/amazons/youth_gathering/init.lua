dirname = path.dirname (__file__)

tribes:new_productionsite_type {
   msgctxt = "amazons_building",
   name = "amazons_youth_gathering",
   -- TRANSLATORS: This is a building name used in lists of buildings
   descname = pgettext ("amazons_building", "Youth Gathering"),
   helptext_script = dirname .. "helptexts.lua",
   icon = dirname .. "menu.png",
   size = "medium",

   buildcost = {
      log = 3,
      rubber = 5,
      rope = 2,
   },
   return_on_dismantle = {
      log = 2,
      rubber = 2,
      rope = 1,
   },

   animation_directory = dirname,
   animations = {
      idle = {hotspot = {43, 44}},
      unoccupied = {hotspot = {43, 44}},
   },
   spritesheets = {
      working = {
         hotspot = {43, 44},
         fps = 15,
         frames = 30,
         columns = 6,
         rows = 5
      }
   },

   aihints = {
      prohibited_till = 920,
      very_weak_ai_limit = 1,
      weak_ai_limit = 2
   },

   working_positions = {
      amazons_trainer = 1
   },

   inputs = {
      { name = "spear_wooden", amount = 5 },
      { name = "tunic", amount = 5 },
      { name = "amazons_bread", amount = 5 },
      { name = "fish", amount = 3 },
      { name = "meat", amount = 3 },
      { name = "amazons_carrier", amount = 8 }
   },
   outputs = {
      "amazons_soldier",
   },

   programs = {
      work = {
         -- TRANSLATORS: Completed/Skipped/Did not start recruiting soldier because ...
         descname = pgettext("amazons_building", "recruiting soldier"),
         actions = {
            "return=skipped unless economy needs amazons_soldier",
            "consume=spear_wooden tunic amazons_bread fish,meat amazons_carrier",
            "sleep=15000",
            "animate=working 15000",
            "recruit=amazons_soldier"
         }
      },
   }
}
