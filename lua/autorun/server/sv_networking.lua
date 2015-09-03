util.AddNetworkString("MLevel_SyncClientToServer")
util.AddNetworkString("MLevel_PlayerRequestChange")
util.AddNetworkString("MLevel_PlayerRequestWipe")
util.AddNetworkString("MLevel_PlayerRequestBuyExp")
util.AddNetworkString("MLevel_PlayerRequestIncreaseStat")


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

	ply:SetPData("MLevel", 				ply.MLevel)
	ply:SetPData("MExp", 				ply.MExp)
	ply:SetPData("MSkill", 				ply.MSkill)
	ply:SetPData("Mhealth", 			ply.MHealth)
	ply:SetPData("Marmor", 				ply.MArmor)
	ply:SetPData("Mspeed", 				ply.MSpeed)
	ply:SetPData("Mjump", 				ply.MJump)
	ply:SetPData("Mfall", 				ply.MFall)
end

// Receiving ////////////////////////////////////////////////////////////////////////////////////////////////////////////////
net.Receive("MLevel_PlayerRequestChange", function(len, ply)
	if MLevel_PlayerIsAdmin(ply) == false then ply:ChatPrint("You must be admin to do this") end
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
	MLevel_SyncClient(target)
end)

net.Receive("MLevel_PlayerRequestWipe", function(len, ply)
	if MLevel_PlayerIsAdmin(ply) == false then ply:ChatPrint("You must be admin to do this") end
	local target 	= net.ReadEntity()
	if not IsValid(target) then return end
	if not target:IsPlayer() then return end

	target:SetMLevel(0)
	target:SetMSkill(0)
	target:SetMExp(0)
	target:SetMVar("health", 0)
	target:SetMVar("armor", 0)
	target:SetMVar("speed", 0)
	target:SetMVar("jump", 0)
	target:SetMVar("fall", 0)
	MLevel_SyncClient(target)
end)

net.Receive("MLevel_PlayerRequestBuyExp", function(len, ply)
	local amount 	= net.ReadInt(32)
	local price 	= (MLevel_PricePerExp * amount)

	if MLevel_PriceType == 1 then
		if ply:canAfford(price) then
			ply:addMoney(-price)

			if MLevel_Notification == true then
				DarkRP.notify(ply, 2, 5, ("You have bought "..amount.." experience points for $"..price.." Exp: "..ply:GetMExp().."/"..ply:GetMLevel()))
			end
			
			MLevel_FixPlayerExp(ply, amount)
		else
			if MLevel_Notification == true then
				DarkRP.notify(ply, 2, 5, ("You can not afford to buy this much experience"))
			end
		end
	elseif MLevel_PriceType == 2 then
		if ply:PS_GetPoints() >= price then
			ply:PSTakePoints(price)

			if MLevel_Notification == true then
				DarkRP.notify(ply, 2, 5, ("You have bought "..amount.." experience points for "..price.." points Exp: "..ply:GetMExp().."/"..ply:GetMLevel()))
			end

			MLevel_FixPlayerExp(ply, amount)
		else
			if MLevel_Notification == true then
				DarkRP.notify(ply, 2, 5, ("You can not afford to buy this much experience"))
			end
		end
	end
end)

net.Receive("MLevel_PlayerRequestIncreaseStat", function(len, ply)
	local stat = net.ReadString()

	if ply:GetMSkill() == 0 then
		ply:ChatPrint("You don't have enough skill points")
	else
		ply:SetMSkill(ply:GetMSkill() - 1)
		ply:SetMVar(stat, ply:GetMVar(stat) + 1)

		if MLevel_Notification == true then
			DarkRP.notify(ply, 2, 5, "You have increased the selected stat by one.")
		end
	end
end)
