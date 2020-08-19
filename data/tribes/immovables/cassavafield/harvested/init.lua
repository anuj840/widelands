dirname = path.dirname(__file__)

tribes:new_immovable_type {
   msgctxt = "immovable",
   name = "cassavarootfield_harvested",
   -- TRANSLATORS: This is an immovable name used in lists of immovables
   descname = pgettext("immovable", "Cassavaroot Field (harvested)"),
   helptext_script = dirname .. "helptexts.lua",
   icon = dirname .. "menu.png",
   programs = {
      main = {
         "animate=idle duration:50s",
         "remove=",
      }
   },

   animation_directory = dirname,
   spritesheets = {
      idle = {
         hotspot = {15, 36},
         frames = 4,
         columns = 2,
         rows = 2,
         fps = 2
      }
   }
}
