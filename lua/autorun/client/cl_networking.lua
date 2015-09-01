net.Receive("MLevel_SyncClientToServer", function() // What's a NWInt? Lol fix that shit
	local ply =		net.ReadEntity()
	local level = 	net.ReadInt(32)
	local exp = 	net.ReadInt(32)
	local skill = 	net.ReadInt(32)
	local health = 	net.ReadInt(32)
	local armor = 	net.ReadInt(32)
	local speed = 	net.ReadInt(32)
	local jump =	net.ReadInt(32)
	local fall = 	net.ReadInt(32)

	/*
	ply:SetNWInt("MLevel",		level)
	ply:SetNWInt("MExp",		exp)
	ply:SetNWInt("MSkill",		skill)
	ply:SetNWInt("Mhealth",		health)
	ply:SetNWInt("Marmor",		armor)
	ply:SetNWInt("Mspeed",		speed)
	ply:SetNWInt("Mjump",		jump)
	ply:SetNWInt("Mfall",		fall)
	*/

	ply.MLevel =		level
	ply.MExp =			exp
	ply.MSkill =		skill
	ply.MHealth	=		health
	ply.MArmor =		armor
	ply.MSpeed =		speed
	ply.MJump =			jump
	ply.MFall =			fall
end)
