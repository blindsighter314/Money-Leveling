// CONFIG ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Preference (It's what you want, everything will work)
MLevel_MaxLevel		=	500			// 	The max achievable level
MLevel_PriceType	=	1			//	What is the currency? (1=darkrp money, 2=pointshop points)
MLevel_PricePerExp	=	250000		//	How much of the PriceType is needed to recieve one experience point

// Modifiers (How much extra of the stat the player gets on spawn per stat level.)
MLevel_HealthPerPoint 	= 2	
MLevel_ArmorPerPoint 	= 2	
MLevel_SpeedPerPoint 	= 5	
MLevel_JumpPerPoint 	= 5	
MLevel_FallPerPoint 	= 5	

// Usability (How easy the script is to use for players)
MLevel_Notification = true // Notify players when they level up/buy exp

// Permissions (Who is an admin? Who gets special treatment?)
MLevel_AdminRanks = {
	"superadmin",
	"admin"
}

function MLevel_PushAdmin(ply) 	// This is where to put special exceptions ie. "Joe" is a user but I want him to have admin powers
	if ply:SteamID() == "STEAM_0:0:000000000" then return true end
end

function MLevel_DiscountPrice(ply)
	if ply:IsUserGroup("Owner") then return 0.5 end 			// This means that anyone with the "owner" rank gets half off
	if ply:SteamID() == "STEAM_0:0:000000000" then return 0 end // Anyone with this Steam ID gets experience free




	return 1 // DO NOT TOUCH THIS, CHANGING THIS COULD BREAK THE SCRIPT			
end

// Fixes and Compatibility (May effect usability; Only touch these if it's neccesary)

// Some gamemodes may lock down your speed under certain circumstances (Looking at you darkrp -_-).
// This will constantly set players speed to the correct speed. (Will be ignored if they have 0 speed to preserve resources.)
MLevel_ConstantSpeedSync	= true		// Are the players speed synced to MoneyLevel
MLevel_SpeedSyncTime		= 10		// How often (IN SECONDS) are players speed synced

// How long (IN SECONDS) does it take for player to recieve all his skills after spawn
// If this is set lower than one, the script will force it back to one as there needs to be at least a one second delay
// Due to core functionality
MLevel_SpawnInitSkillsDelay = 1

// When a target's stats, exp, skill, or level is changed, should they go through normal level up checks?
// For example: If a player is level 5 and their experience is 0/5 and you set their experience to 6
// If this is true then the player's level will become 6 and their experience will be 1/6
// If this is false then the player's level will stay 5 and their experience will be 6/5
// TLDR KEEP THIS TRUE BECAUSE MAKING IT FALSE CAN FUCK EVERYTHING UP PLEASE THANKS KDUDE :^^^^^^^^)
MLevel_RealisticallySyncStatsOnChange	= true

// CONFIG ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
