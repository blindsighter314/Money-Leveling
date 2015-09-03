// Sending //////////////////////////////////////////////////////////////////////////////////////////////////////////////////

function MLevel_ClientRequestChange(target, changeType, amount, stat)
	if stat == nil then stat = "" end
	net.Start("MLevel_PlayerRequestChange")
		net.WriteEntity(target)
		net.WriteString(changeType)
		net.WriteInt(amount, 32)
		net.WriteString(stat)
	net.SendToServer()
end

function MLevel_ClientRequestWipe(target)
	net.Start("MLevel_PlayerRequestWipe")
		net.WriteEntity(target)
	net.SendToServer()
end

function MLevel_ClientRequestExpBuy(amount)
	net.Start("MLevel_PlayerRequestBuyExp")
		net.WriteInt(amount, 32)
	net.SendToServer()
end

function MLevel_ClientRequestStatIncrease(stat)
	net.Start("MLevel_PlayerRequestIncreaseStat")
		net.WriteString(stat)
	net.SendToServer()
end

// Receiving ////////////////////////////////////////////////////////////////////////////////////////////////////////////////

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

	ply.MLevel =		level
	ply.MExp =			exp
	ply.MSkill =		skill
	ply.MHealth	=		health
	ply.MArmor =		armor
	ply.MSpeed =		speed
	ply.MJump =			jump
	ply.MFall =			fall
end)
