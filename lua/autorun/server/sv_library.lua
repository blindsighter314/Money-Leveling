local user = FindMetaTable("Player")

function MLevel_IsVar(ply, var)
	local varTable = {
		{"health",	ply.MHealth},
		{"armor", 	ply.MArmor},
		{"speed",	ply.MSpeed},
		{"jump",	ply.MJump},
		{"fall",	ply.MFall}
	}

	for k,v in pairs(varTable) do
		if v[1] == var then
			return v[2]
		end
	end
	return false
end

function MLevel_FixPlayerExp(ply, numLeft)
	if numLeft > ply:GetMLevel() then
		numLeft = numLeft - ply:GetMLevel()
		ply:MLevelUp()
		MLevel_FixPlayerExp(ply, numLeft)
	else
		ply.MExp = numLeft
	end
end

// Control //////////////////////////////////////////////////////////////////////////////////////////////////////////////////
function user:MLevelUp()
	self:SetMLevel(self:GetMLevel() + 1, false)
	self:SetMSkill(self:GetMSkill() + 1, false)
	self:SetMExp(0)
end

// Get Info /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
function user:GetMLevel()
	if not self:IsPlayer() then print("MLevel: Attempted to get the level of a nil player") return end
//	return self:GetNWInt("MLevel")
	return self.MLevel
end

function user:GetMExp()
	if not self:IsPlayer() then print("MLevel: Attempted to get the level of a nil player") return end
//	return self:GetNWInt("MExp")
	return self.MExp
end

function user:GetMSkill()
	if not self:IsPlayer() then print("MLevel: Attempted to get the Skill Points of a nil player") return end
//	return self:GetNWInt("MSkill")
	return self.MSkill
end

function user:GetMVar(var)
	if not user:IsPlayer() then print("MLevel: Attempted to get the "..var.." of a nil player") return end
	if MLevel_IsVar(var) == false then print("MLevel: Attempted to get "..var..", A nil Variable") return end
	return MLevel_IsVar(var)
end

// Set Info /////////////////////////////////////////////////////////////////////////////////////////////////////////////////

function user:SetMLevel(num, runSyncCheck) 	// NEEDS A SKILL CLAMP, LOOK AT YOUR NOTES PLUG PLUG PLUG PLUG PLUG PLUG PLUG
	if not self:IsPlayer() then print("MLevel: Attempted to set the level of a nil player") return end
	if num == nil or num < 0 then print("MLevel: Invalid level") return end

	if MLevel_RealisticallySyncStatsOnChange == true and runSyncCheck == true then
		local curLevel 	= self:GetMLevel()
		if curLevel > num then
			if self:GetMSkill() > 0 then
				local skChange = self:GetMSkill() - (curLevel - num)
				if skChange < 0 then
					self:SetMSkill(0)
				else
					self:SetMSkill(skChange)
				end
			end
		else
			self:SetMSkill(self:GetMSkill() + (num - curLevel))
		end
		self.MLevel = num
		MLevel_FixPlayerExp(self, self:GetMExp())
	else
		self.MLevel = num
	end
	MLevel_SyncClient(self)
end

function user:SetMExp(num, runSyncCheck)
	if not self:IsPlayer() then print("MLevel: Attempted to set the experience of a nil player") return end
	if num == nil or num < 0 then print("MLevel: Invalid experience") return end

	if MLevel_RealisticallySyncStatsOnChange == true and runSyncCheck == true then
		MLevel_FixPlayerExp(self, num)
	else
		self.MExp = num
	end
	MLevel_SyncClient(self)
end

function user:SetMSkill(num, runSyncCheck)
	if not self:IsPlayer() then print("MLevel: Attempted to set the skill of a nil player") return end
	if num == nil or num < 0 then print("MLevel: Invalid skill amount") return end

	if MLevel_RealisticallySyncStatsOnChange == true and runSyncCheck == true then
		local curLevel 	= ply:GetMLevel()
		local curSkill 	= ply:GetMSkill()
		local change 	= (num - curSkill)

		ply:SetMLevel(curLevel + change, false)
		MLevel_FixPlayerExp(self, num)
	end
	ply.MSkill = num
end

function user:SetMVar(var, num, runSyncCheck)	// Still needs work
	if MLevel_IsVar(var) == false then print("MLevel: Invalid skill") return end
	if not self:IsPlayer() then print("MLevel: Attempted to set the skill of a nil player") return end
	if num == nil or num < 0 then print("MLevel: Invalid skill amount") return end
	local trueVar = MLevel_IsVar(var)

	if MLevel_RealisticallySyncStatsOnChange == true and runSyncCheck == true then
		local curLevel 	= ply:GetMLevel()
		local curVar 	= ply:GetMVar(var)

		if num > curVar then
			ply:SetMLevel(ply:GetMLevel + (num - curVar), false)
			if var == "health" then
				ply.MHealth = num
			elseif var == "armor" then
				ply.MArmor = num
			elseif var == "speed" then
				ply.MSpeed = num
			elseif var =="jump" then
				ply.MJump = num
			elseif var == "fall" then
				ply.MFall = num
			else
				print("MLevel: SOMETHING HAS GONE HORRIBLY WRONG.")
			end
		end
	end

	self:SetNWInt(var, num)
end
