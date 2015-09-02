local user = FindMetaTable("Player")
local MLevel_NextThink = math.floor(1/engine.TickInterval()) // Tickrate timers are less expensive and cleaner. Tell your cat
local MLevel_SyncSpeed = math.ceil(MLevel_SpeedSyncTime)	// Prepare speed sync on pulse

function MLevel_PlayerInitialize(ply)
	ply.MLevel 	= ply:GetPData("MLevel",	0)
	ply.MExp 	= ply:GetPData("MExp",		0)
	ply.MSkill 	= ply:GetPData("MSkill",	0)
	ply.MHealth = ply:GetPData("Mhealth",	0)
	ply.MArmor 	= ply:GetPData("Marmor",	0)
	ply.MSpeed 	= ply:GetPData("Mspeed",	0)
	ply.MJump 	= ply:GetPData("Mjump",		0)
	ply.MFall 	= ply:GetPData("Mfall",		0)
	timer.Simple( 1, function() MLevel_SyncClient(ply) end)
end
hook.Add("PlayerInitialSpawn", "Money Level Initialize Player", MLevel_PlayerInitialize)



function MLevel_PlayerSpawn(ply)
	print(type(MLevel_IsVar))
	if MLevel_ConstantSpeedSync == true then
		ply.MLevel_ProperPlayerRunSpeed 	= ply:GetRunSpeed()
		ply.MLevel_ProperPlayerWalkSpeed 	= ply:GetWalkSpeed() 
	end

	timer.Simple(MLevel_SpawnInitSkillsDelay, function()
		local hp 		=	(ply.MHealth*MLevel_HealthPerPoint)
		local armor		=	(ply.MArmor*MLevel_ArmorPerPoint)
		local speed		=	(ply.MSpeed*MLevel_SpeedPerPoint)
		local jump 		=	(ply.MJump*MLevel_JumpPerPoint)

		ply:SetHealth(ply:Health()			+ hp)
		ply:SetArmor(ply:Armor()			+ armor)
		ply:SetRunSpeed(ply:GetRunSpeed() 	+ speed)
		ply:SetWalkSpeed(ply:GetWalkSpeed() + speed)
		ply:SetJumpPower(ply:GetJumpPower() + jump)
	end)
end
hook.Add("PlayerSpawn", "Money Level Player spawn", MLevel_PlayerSpawn)

function MLevel_Pulse()	// Called once a second
//	print(player.GetAll()[1].MJump)
//	net.Start("MLevel_ClientDebug")
//	net.Send(player.GetAll()[1])
	if MLevel_ConstantSpeedSync == true then
		MLevel_SyncSpeed = MLevel_SyncSpeed - 1
		if MLevel_SyncSpeed <= 0 then
			local MLevel_SyncSpeed = math.ceil(MLevel_SpeedSyncTime)
			for k,v in pairs(player.GetAll()) do
				v:SetRunSpeed(v.MLevel_ProperPlayerRunSpeed+(MLevel_SpeedPerPoint*v.MSpeed))
				v:SetWalkSpeed(v.MLevel_ProperPlayerWalkSpeed+(MLevel_SpeedPerPoint*v.MSpeed))
			end
		end
	end
end

function MLevel_Think()
	MLevel_NextThink = MLevel_NextThink - 1
	if MLevel_NextThink <= 0 then
		MLevel_NextThink = math.floor(1/engine.TickInterval())
		MLevel_Pulse()
	end
end
hook.Add("Think", "Money Level Thinking Hook", MLevel_Think)
