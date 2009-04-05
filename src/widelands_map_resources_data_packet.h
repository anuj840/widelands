/*
 * Copyright (C) 2002-2004, 2006-2008 by the Widelands Development Team
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version 2
 * of the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
 *
 */

#ifndef WIDELANDS_MAP_RESOURCES_DATA_PACKET_H
#define WIDELANDS_MAP_RESOURCES_DATA_PACKET_H

#include "widelands_map_data_packet.h"

namespace Widelands {

/*
 * The resources data packet contains the resources of all fields
 */
struct Map_Resources_Data_Packet : public Map_Data_Packet {
	virtual void Read
		(FileSystem &,
		 Editor_Game_Base      &,
		 const bool,
		 Map_Map_Object_Loader * = 0)
		throw (_wexception);
	void Write(FileSystem &, Editor_Game_Base &, Map_Map_Object_Saver * = 0)
		throw (_wexception);
};

};

#endif
