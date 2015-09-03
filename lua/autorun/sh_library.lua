// What a library, whew...
function MLevel_PlayerIsAdmin(ply)
	for k,v in pairs(MLevel_AdminRanks) do
		if ply:IsUserGroup(v) then
			return true
		end
	end

	if MLevel_PushAdmin(ply) == true then return true end
	return false
end
