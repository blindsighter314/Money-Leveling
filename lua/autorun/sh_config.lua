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



// Fixes and Compatibility (May effect usability; Only touch these if it's neccesary)
// Some gamemodes may lock down your speed under certain circumstances (Looking at you darkrp -_-).
// This will constantly set players speed to the correct speed. (Will be ignored if they have 0 speed to preserve resources.)
MLevel_ConstantSpeedSync	= true		// Are the players speed synced to MoneyLevel
MLevel_SpeedSyncTime		= 10		// How often (IN SECONDS) are players speed synced

// How long (IN SECONDS) does it take for player to recieve all his skills after spawn
// If this is set lower than one, the script will force it back to one as there needs to be at least a one second delay
// Due to core functionality
MLevel_SpawnInitSkillsDelay = 1

// CONFIG ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
