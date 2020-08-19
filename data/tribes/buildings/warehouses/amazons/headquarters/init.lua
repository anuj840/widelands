dirname = path.dirname (__file__)

tribes:new_warehouse_type {
   msgctxt = "amazons_building",
   name = "amazons_headquarters",
   -- TRANSLATORS: This is a building name used in lists of buildings
   descname = pgettext ("amazons_building", "Headquarters"),
   helptext_script = dirname .. "helptexts.lua",
   icon = dirname .. "menu.png",
   size = "big",
   destructible = false,

   animation_directory = dirname,
   animations = { idle = {hotspot = {92, 89}}},

   aihints = {},

   heal_per_second = 220,
   conquers = 9,
}
