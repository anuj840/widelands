dirname = path.dirname(__file__)

tribes:new_ware_type {
   msgctxt = "ware",
   name = "ironwood",
   -- TRANSLATORS: This is a ware name used in lists of wares
   descname = pgettext("ware", "Ironwood"),
   helptext_script = dirname .. "helptexts.lua",
   icon = dirname .. "menu.png",
   default_target_quantity = {
      amazons = 40
   },
   preciousness = {
      amazons = 50
   },

   animations = {
      idle = {
         pictures = path.list_files(dirname .. "idle.png"),
         hotspot = { 10, 10 },
      },
   }
}
