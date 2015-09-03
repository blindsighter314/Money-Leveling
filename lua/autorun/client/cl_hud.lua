// This addon having a hud element? Maybe some day™
/*
CreateClientConVar("ML_BoxX", "0", true, true)
CreateClientConVar("ML_BoxY", tostring(ScrW() - 115), true, true)
CreateClientConVar("ML_BoxW", "100", true, true)
CreateClientConVar("ML_BoxH", "125", true, true)
CreateClientConVar("ML_BoxA", "100", true, true)
CreateClientConVar("ML_Font", "13", true, true)
CreateClientConVar("ML_Spacing", "15", true, true)

local function tn(num) return tonumber(num) end
local ply = LocalPlayer()
local x, y, w, h = tn(ply:GetInfoNum("ML_BoxX", 0)), tn(ply:GetInfoNum("ML_BoxY", 0)), tn(ply:GetInfoNum("ML_BoxW", 100)), tn(ply:GetInfoNum("ML_BoxH", 125))

surface.CreateFont("MoneyLevelFont", {
	font = "DermaDefault",
	size = ply:GetInfoNum("ML_Font", 13),
	weight = 500,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = false,
})

function MLevel_HudElement() // plug
	draw.RoundedBox(0,
	x, y, w, h,
	Color(0, 0, 0, ply:GetInfoNum("ML_BoxA", 100)))
	local sp = ply:GetInfoNum("ML_Spacing", 15)

	draw.DrawText(("Level:\t "..ply.MLevel), "MoneyLevelFont", 		x + 5, y + (sp * 1) - 10, Color(0, 0, 0, 255), TEXT_ALIGN_LEFT)
	draw.DrawText(("Exp:\t "..ply.MExp), "MoneyLevelFont", 			x + 5, y + (sp * 2) - 10, Color(0, 0, 0, 255), TEXT_ALIGN_LEFT)
	draw.DrawText(("Skill:\t "..ply.MSkill), "MoneyLevelFont", 		x + 5, y + (sp * 3) - 10, Color(0, 0, 0, 255), TEXT_ALIGN_LEFT)
	draw.DrawText(("Health:\t "..ply.MHealth), "MoneyLevelFont", 	x + 5, y + (sp * 4) - 10, Color(0, 0, 0, 255), TEXT_ALIGN_LEFT)
	draw.DrawText(("Armor:\t "..ply.MArmor), "MoneyLevelFont", 		x + 5, y + (sp * 5) - 10, Color(0, 0, 0, 255), TEXT_ALIGN_LEFT)
	draw.DrawText(("Speed:\t "..ply.MSpeed), "MoneyLevelFont", 		x + 5, y + (sp * 6) - 10, Color(0, 0, 0, 255), TEXT_ALIGN_LEFT)
	draw.DrawText(("Jump:\t "..ply.MJump), "MoneyLevelFont", 		x + 5, y + (sp * 7) - 10, Color(0, 0, 0, 255), TEXT_ALIGN_LEFT)
	draw.DrawText(("Fall:\t "..ply.MFall), "MoneyLevelFont", 		x + 5, y + (sp * 8) - 10, Color(0, 0, 0, 255), TEXT_ALIGN_LEFT)
end
hook.Add("HUDPaint", "Add MLevel Hud element", MLevel_HudElement)
*/
