local user = FindMetaTable("Player")

// Get Info //////////////////////////////////////////////////////////////////////////////////////////////////////////////////
function user:GetMLevel()
	if not self:IsPlayer() then print("MLevel: Attempted to get the level of a nil player") return end
	return self:GetNWInt("MLevel")
end

function user:GetMExp()
	if not self:IsPlayer() then print("MLevel: Attempted to get the level of a nil player") return end
	return self:GetNWInt("MExp")
end

function user:GetMSkill()
	if not self:IsPlayer() then print("MLevel: Attempted to get the Skill Points of a nil player") return end
	return self:GetNWInt("MSkill")
end

function user:GetMVar(var)
	if not user:IsPlayer() then print("MLevel: Attempted to get the "..var.." of a nil player") return end
	if not MLevel_IsVar(var) then print("MLevel: Attempted to get "..var..", A nil Variable") return end
	return self:GetNWInt(var)
end

// Set Info /////////////////////////////////////////////////////////////////////////////////////////////////////////////////

function user:SetMLevel(num)
	if not self:IsPlayer() then print("MLevel: Attempted to set the level of a nil player") return end
	if num == nil or num < 0 then print("MLevel: Invalid level") return end
	if (CLIENT) then
		self:SetNWInt("MLevel", num)
	end

	if (SERVER) then
		self:SetNWInt("MLevel", num)
	end
end

function user:SetMExp(num)
	if not self:IsPlayer() then print("MLevel: Attempted to set the expiriance of a nil player") return end
	if num == nil or num < 0 then print("MLevel: Invalid expiriance") return end
	self:SetNWInt("MExp", num)
end

function user:SetMSkill(num)
	if not self:IsPlayer() then print("MLevel: Attempted to set the skill of a nil player") return end
	if num == nil or num < 0 then print("MLevel: Invalid skill amount") return end
	self:SetNWInt("MSkill", num)
end

function user:SetMVar(var, num)
	if not MLevel_IsVar(var) then print("MLevel: Invalid skill") return end
	if not self:IsPlayer() then print("MLevel: Attempted to set the skill of a nil player") return end
	if num == nil or num < 0 then print("MLevel: Invalid skill amount") return end
	self:SetNWInt(var, num)
end
