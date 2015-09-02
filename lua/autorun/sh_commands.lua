// Commands is general, this file is dedicated to concommands and chat command API

// User Console commands ////////////////////////////////////////////////////////////////////////////////////////////////////

concommand.Add("ML_CheckStats", function(ply, cmd, args)
	if not IsValid(ply) then return end
	if not ply:IsPlayer() then return end
	
	print(ply.MLevel)
end)

// Admin Console Commands ///////////////////////////////////////////////////////////////////////////////////////////////////

concommand.Add("ML_Admin_SetLevel", function(ply, cmd, args)
	if not IsValid(ply) then return end
	if not ply:IsPlayer() then return end


end)

concommand.Add("mstats", function(ply, cmd, args)
	if CLIENT then
		print("\n"..ply.MLevel.."\n"..ply.MExp.."\n"..ply.MSkill.."\n"..ply.MHealth.."\n"..ply.MArmor.."\n"..ply.MSpeed.."\n"..ply.MJump.."\n"..ply.MFall.."\n")
	end
end)

concommand.Add("test", function(ply, cmd, args)
	print(type(MLevel_IsVar))

	if SERVER then
		print(type(MLevel_IsVar))
	end
end)
