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

// Control //////////////////////////////////////////////////////////////////////////////////////////////////////////////////
function user:MLevelUp()
	self:SetMLevel(self:GetMLevel() + 1)
	self:SetMSkill(self:GetMSkill() + 1)
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

function user:SetMLevel(num)
	if not self:IsPlayer() then print("MLevel: Attempted to set the level of a nil player") return end
	if num == nil or num < 0 then print("MLevel: Invalid level") return end

	if MLevel_RealisticallySyncStatsOnChange == true then
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

		local function fixThatExpLol(numLeft)
			if numLeft > self:GetMLevel() then
				numLeft = numLeft - self:GetMLevel()
				self:MLevelUp()
				fixThatExpLol(numLeft)
			else
				self.MExp = numLeft
			end
		end
			fixThatExpLol(self:GetMExp())
		end
	else
		self.MLevel = num
	end
end

function user:SetMExp(num)
	if not self:IsPlayer() then print("MLevel: Attempted to set the experience of a nil player") return end
	if num == nil or num < 0 then print("MLevel: Invalid experience") return end

	if MLevel_RealisticallySyncStatsOnChange == true then
		local function fixThatExpLol(numLeft)
			if numLeft > self:GetMLevel() then
				numLeft = numLeft - self:GetMLevel()
				self:MLevelUp()
				fixThatExpLol(numLeft)
			else
				self.MExp = numLeft
			end
		end
		fixThatExpLol(num)
	else
		self.MExp = num
	end
end

function user:SetMSkill(num)	// Still needs work
	if not self:IsPlayer() then print("MLevel: Attempted to set the skill of a nil player") return end
	if num == nil or num < 0 then print("MLevel: Invalid skill amount") return end
	self:SetNWInt("MSkill", num)
end

function user:SetMVar(var, num)	// Still needs work
	if not MLevel_IsVar(var) then print("MLevel: Invalid skill") return end
	if not self:IsPlayer() then print("MLevel: Attempted to set the skill of a nil player") return end
	if num == nil or num < 0 then print("MLevel: Invalid skill amount") return end
	self:SetNWInt(var, num)
end
