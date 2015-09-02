util.AddNetworkString("MLevel_SyncClientToServer")
util.AddNetworkString("MLevel_PlayerRequestChange")
util.AddNetworkString("MLevel_ClientDebug")


// Sending //////////////////////////////////////////////////////////////////////////////////////////////////////////////////
function MLevel_SyncClient(ply)
	net.Start("MLevel_SyncClientToServer")
		net.WriteEntity(ply)
		net.WriteInt(ply.MLevel, 	32)
		net.WriteInt(ply.MExp, 		32)
		net.WriteInt(ply.MSkill, 	32)
		net.WriteInt(ply.MHealth, 	32)
		net.WriteInt(ply.MArmor, 	32)
		net.WriteInt(ply.MSpeed, 	32)
		net.WriteInt(ply.MJump, 	32)
		net.WriteInt(ply.MFall, 	32)
	net.Send(ply)
end

// Receiving ////////////////////////////////////////////////////////////////////////////////////////////////////////////////
net.Receive("MLevel_PlayerRequestChange", function(ply, len)
	// if he isn't an admin, stahp it
	local target 		= net.ReadEntity()
	local changeType 	= net.ReadString() 	// level, skill, exp, stat
	local amount 		= net.ReadInt(32)
	local statType 		= net.ReadString() // health, armor, speed, jump, fall

	if not IsValid(target) then return end
	if not target:IsPlayer() then return end
	if not tonumber(amount) then return end
	local num = tonumber(amount)
	
	if changeType == "level" then
		target:SetMLevel(num, true)
	elseif changeType == "skill" then
		target:SetMSkill(num, true)
	elseif changeType == "exp" then
		target:SetMExp(num, true)
	elseif changeType == "stat" then
		target:SetMVar(statType, num, true)
	end
end)
