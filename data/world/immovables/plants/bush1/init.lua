push_textdomain("world")

dirname = path.dirname(__file__)

wl.World():new_immovable_type{
   name = "bush1",
   descname = _ "Bush",
   size = "none",
   programs = {},
   animations = {
      idle = {
         pictures = path.list_files(dirname .. "idle.png"),
         hotspot = { 10, 9 },
      },
   }
}

pop_textdomain()
