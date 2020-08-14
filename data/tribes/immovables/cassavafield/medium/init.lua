dirname = path.dirname(__file__)

tribes:new_immovable_type {
   msgctxt = "immovable",
   name = "cassavarootfield_medium",
   -- TRANSLATORS: This is an immovable name used in lists of immovables
   descname = pgettext("immovable", "Cassavaroot Field (medium)"),
   helptext_script = dirname .. "helptexts.lua",
   icon = dirname .. "menu.png",
   size = "small",
   attributes = { "field", "flowering" },
   programs = {
      main = {
         "animate=idle duration:50s",
         "transform=cassavarootfield_ripe",
      }
   },

   animation_directory = dirname,
   spritesheets = {
      idle = {
         hotspot = {11, 25},
         frames = 4,
         columns = 2,
         rows = 2,
         fps = 2
      }
   }
}
