util.AddNetworkString("MLevel_SyncClientToServer")

function MLevel_SyncClient(ply) 	// What's a NWInt? Lol fix that shit
	net.Start("MLevel_SyncClientToServer")
		net.WriteEntity(ply)
		net.WriteInt(ply:GetNWInt("MLevel"), 	32)
		net.WriteInt(ply:GetNWInt("MExp"), 		32)
		net.WriteInt(ply:GetNWInt("MSkill"), 	32)
		net.WriteInt(ply:GetNWInt("Mhealth"), 	32)
		net.WriteInt(ply:GetNWInt("Marmor"), 	32)
		net.WriteInt(ply:GetNWInt("Mspeed"), 	32)
		net.WriteInt(ply:GetNWInt("Mjump"), 	32)
		net.WriteInt(ply:GetNWInt("Mfall"), 	32)
	net.Send(ply)
end
