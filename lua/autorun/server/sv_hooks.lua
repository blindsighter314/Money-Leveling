local user = FindMetaTable("Player")
local MLevel_NextThink = math.floor(1/engine.TickInterval()) // Tickrate timers are less expensive and cleaner. Tell your cat
local MLevel_SyncSpeed = math.ceil(MLevel_SpeedSyncTime)	// Prepare speed sync on pulse

function MLevel_PlayerInitialize(ply)
	/*
	ply:SetNWInt("MLevel",		ply:GetPData("MLevel", 	1))
	ply:SetNWInt("MExp",		ply:GetPData("MExp", 	0))
	ply:SetNWInt("MSkill",		ply:GetPData("MSkill", 	0))
	ply:SetNWInt("Mhealth",		ply:GetPData("Mhealth", 0))
	ply:SetNWInt("Marmor",		ply:GetPData("Marmor",  0))
	ply:SetNWInt("Mspeed",		ply:GetPData("Mspeed",  0))
	ply:SetNWInt("Mjump",		ply:GetPData("Mjump",	0))
	ply:SetNWInt("Mfall",		ply:GetPData("Mfall",	0))
	*/

	ply.MLevel 	= ply:GetPData("MLevel",	1)
	ply.MExp 	= ply:GetPData("MExp",		0)
	ply.MSkill 	= ply:GetPData("MSkill",	0)
	ply.MHealth = ply:GetPData("Mhealth",	0)
	ply.MArmor 	= ply:GetPData("Marmor",	0)
	ply.MSpeed 	= ply:GetPData("Mspeed",	0)
	ply.MJump 	= ply:GetPData("Mjump",		0)
	ply.MFall 	= ply:GetPData("Mfall",		0)
	MLevel_SyncClient(ply)
end
hook.Add("PlayerInitialSpawn", "Money Level Initialize Player", MLevel_PlayerInitialize)



function MLevel_PlayerSpawn(ply)
	if MLevel_ConstantSpeedSync == true then
		/*
		ply:SetNWInt("MLevel_ProperPlayerRunSpeed", 	ply:GetRunSpeed())
		ply:SetNWInt("Mlevel_ProperPlayerWalkSpeed", 	ply:GetWalkSpeed())
		*/
		ply.MLevel_ProperPlayerRunSpeed 	= ply:GetRunSpeed()
		ply.MLevel_ProperPlayerWalkSpeed 	= ply:GetWalkSpeed() 
	end

	timer.Simple(MLevel_SpawnInitSkillsDelay, function()
		/*
		local hp 		= 	(ply:GetMVar("Mhealth")*MLevel_HealthPerPoint)
		local armor 	=	(ply:GetMVar("Marmor")*MLevel_ArmorPerPoint)
		local speed 	=	(ply:GetMVar("Mspeed")*MLevel_SpeedPerPoint)
		local jump 		=	(ply:GetMVar("Mfall")*MLevel_FallPerPoint)
		*/
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
	if MLevel_ConstantSpeedSync == true then
		MLevel_SyncSpeed = MLevel_SyncSpeed - 1
		if MLevel_SyncSpeed <= 0 then
			local MLevel_SyncSpeed = math.ceil(MLevel_SpeedSyncTime)
			for k,v in pairs(player.GetAll()) do
				/*
				v:SetRunSpeed(v:GetNWInt("MLevel_ProperPlayerRunSpeed")+(MLevel_SpeedPerPoint*v:GetMVar("Mspeed")))
				v:SetWalkSpeed(v:GetNWInt("MLevel_ProperPlayerWalkSpeed")+(MLevel_SpeedPerPoint*v:GetMVar("Mspeed")))
				*/
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
hook.Add("Think", "Mony Level Thinking Hook", MLevel_Think)
