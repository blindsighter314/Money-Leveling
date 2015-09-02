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
	if numLeft >= ply:GetMLevel() then
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
	return self.MLevel
end

function user:GetMExp()
	if not self:IsPlayer() then print("MLevel: Attempted to get the level of a nil player") return end
	return self.MExp
end

function user:GetMSkill()
	if not self:IsPlayer() then print("MLevel: Attempted to get the Skill Points of a nil player") return end
	return self.MSkill
end

function user:GetMVar(var)
	if not user:IsPlayer() then print("MLevel: Attempted to get the "..var.." of a nil player") return end
	if MLevel_IsVar(self, var) == false then print("MLevel: Attempted to get "..var..", A nil Variable") return end
	return MLevel_IsVar(self, var)
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

		local totalSkillPoints = self:GetMSkill()
		totalSkillPoints = (totalSkillPoints + self:GetMVar("health"))
		totalSkillPoints = (totalSkillPoints + self:GetMVar("armor"))
		totalSkillPoints = (totalSkillPoints + self:GetMVar("speed"))
		totalSkillPoints = (totalSkillPoints + self:GetMVar("jump"))
		totalSkillPoints = (totalSkillPoints + self:GetMVar("fall"))

		if totalSkillPoints > self:GetMLevel() then
			if self:GetMSkill() > 0 then
				while self:GetMSkill() > 0 and totalSkillPoints > self:GetMLevel() do
					self:SetMSkill(self:GetMSkill() - 1, false)
					totalSkillPoints = (totalSkillPoints - 1)
				end
			end

			if self:GetMVar("health") > 0 then
				while self:GetMVar("health") > 0 and totalSkillPoints > self:GetMLevel() do
					self:SetMVar("health", self:GetMVar("health") - 1, false)
					totalSkillPoints = (totalSkillPoints - 1)
				end
			end

			if self:GetMVar("armor") > 0 then
				while self:GetMVar("armor") > 0 and totalSkillPoints > self:GetMLevel() do
					self:SetMVar("armor", self:GetMVar("armor") - 1, false)
					totalSkillPoints = (totalSkillPoints - 1)
				end
			end

			if self:GetMVar("speed") > 0 then
				while self:GetMVar("speed") > 0 and totalSkillPoints > self:GetMLevel() do
					self:SetMVar("speed", self:GetMVar("speed") - 1, false)
					totalSkillPoints = (totalSkillPoints - 1)
				end
			end

			if self:GetMVar("jump") > 0 then
				while self:GetMVar("jump") > 0 and totalSkillPoints > self:GetMLevel() do
					self:SetMVar("jump", self:GetMVar("jump") - 1, false)
					totalSkillPoints = (totalSkillPoints - 1)
				end
			end

			if self:GetMVar("fall") > 0 then
				while self:GetMVar("fall") > 0 and totalSkillPoints > self:GetMLevel() do
					self:SetMVar("fall", self:GetMVar("fall") - 1, false)
					totalSkillPoints = (totalSkillPoints - 1)
				end
			end
		end
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
		local curLevel 	= self:GetMLevel()
		local curSkill 	= self:GetMSkill()
		local change 	= (num - curSkill)

		self:SetMLevel(curLevel + change, false)
		MLevel_FixPlayerExp(self, num)
	end
	self.MSkill = num
	MLevel_SyncClient(self)
end

function user:SetMVar(var, num, runSyncCheck)	// Still needs work
	if MLevel_IsVar(self, var) == false then print("MLevel: Invalid skill") return end
	if not self:IsPlayer() then print("MLevel: Attempted to set the skill of a nil player") return end
	if num == nil or num < 0 then print("MLevel: Invalid skill amount") return end
	local trueVar = MLevel_IsVar(self, var)

	if MLevel_RealisticallySyncStatsOnChange == true and runSyncCheck == true then
		local curLevel 	= self:GetMLevel()
		local curVar 	= self:GetMVar(var)

		if num > curVar then
			self:SetMLevel(self:GetMLevel() + (num - curVar), false)
			if var == "health" then
				self.MHealth = num
			elseif var == "armor" then
				self.MArmor = num
			elseif var == "speed" then
				self.MSpeed = num
			elseif var =="jump" then
				self.MJump = num
			elseif var == "fall" then
				self.MFall = num
			else
				print("MLevel: SOMETHING HAS GONE HORRIBLY WRONG.")
			end
		end
	else
		if var == "health" then
			self.MHealth = num
		elseif var == "armor" then
			self.MArmor = num
		elseif var == "speed" then
			self.MSpeed = num
		elseif var =="jump" then
			self.MJump = num
		elseif var == "fall" then
			self.MFall = num
		else
			print("MLevel: SOMETHING HAS GONE HORRIBLY WRONG.")
		end
	end
end

