/*
 * Copyright (C) 2002-2004, 2006, 2008-2010 by the Widelands Development Team
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

#ifndef EVENT_PLAYER_WORKER_TYPES_H
#define EVENT_PLAYER_WORKER_TYPES_H

#include "event.h"

#include <set>

namespace Widelands {

struct Tribe_Descr;

/// Abstract base for events involving a player and a set of buildable worker
/// types.
struct Event_Player_Worker_Types : public Event {
	Event_Player_Worker_Types
		(char const * const Name, State const S)
		: Event(Name, S), m_player_number(1)
	{}
	Event_Player_Worker_Types
		(Section &, Editor_Game_Base &, Tribe_Descr const *);

	virtual char const * action_name() const = 0; /// What the event type does.

	int32_t option_menu(Editor_Interactive &);

	void Write(Section &, Editor_Game_Base &) const;

	Player_Number player_number() const {return m_player_number;}
	void set_player(Player_Number);
	typedef std::set<Ware_Index> Worker_Types;
	Worker_Types const & worker_types() const {return m_worker_types;}
	Worker_Types       & worker_types()       {return m_worker_types;}
protected:
	Player_Number m_player_number;
	Worker_Types  m_worker_types;
};

}

#endif
