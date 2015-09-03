MLevel_MenuIsOpen = false

function MLevel_OpenMenu(ply)
	local MenuBase = vgui.Create("DFrame")
	MenuBase:SetSize(ScrW()/2, ScrH()/2)
	MenuBase:SetPos(0, 0)
	MenuBase:SetTitle("Money Leveling Menu")
	MenuBase:SetDeleteOnClose(false)
	MenuBase:SetDraggable(false)
	MenuBase:SetBackgroundBlur(false)
	MenuBase:Center(true)
	MenuBase:SetVisible(true)
	MenuBase:ShowCloseButton(false)
	MenuBase.Paint = function()
		draw.RoundedBox( 8, 0, 0, MenuBase:GetWide(), MenuBase:GetTall(), Color( 0, 0, 0, 150 ) )
	end
	MenuBase:MakePopup()

	local cl = vgui.Create("DButton", MenuBase)
	cl:SetSize( 50, 20 )
	cl:SetPos( MenuBase:GetWide() - 60, 0 )
	cl:SetText( "X" )
	cl:SetFont( "CloseCaption_Bold" )
	cl:SetTextColor( Color( 255, 255, 255, 255 ) )
	cl.Paint = function( self, w, h )
		local kcol
		if self.hover then
			kcol = Color( 255, 150, 150, 255 )
		else
			kcol = Color( 175, 100, 100 )
		end
		draw.RoundedBoxEx( 0, 0, 0, w, h, Color( 255, 150, 150, 255 ), false, false, true, true )
		draw.RoundedBoxEx( 0, 1, 0, w - 2, h - 1, kcol, false, false, true, true )
	end
	cl.DoClick = function()
		MenuBase:Close()
		MLevel_MenuIsOpen = false
	end
	cl.OnCursorEntered = function( self )
		self.hover = true
	end
	cl.OnCursorExited = function( self )
		self.hover = false
	end

	local ScrollBar = vgui.Create( "DScrollPanel", MenuBase )
	ScrollBar:SetSize( MenuBase:GetWide() - 50, MenuBase:GetTall() - 40 )
	ScrollBar:SetPos( 25,30 )
		
	local Base1 = vgui.Create("DPanel", ScrollBar)
	Base1:SetPos(0,0)
	Base1:SetSize(MenuBase:GetWide() - 20, (ScrH()/2) - 50)
	Base1:SizeToContents()
	Base1.Paint = function()
		draw.RoundedBox( 8, 0, 0, Base1:GetWide(), Base1:GetTall(), Color( 255, 255, 255, 255 ) )
	end

	// CLIENT MENU //////////////////////////////////////////////////////////////////////////////////////////////////////////
	local currencyLabel = ""

	if MLevel_PriceType == 1 then
		currencyLabel = "$"
	end

	local clientText = vgui.Create("DLabel", Base1)
	clientText:SetPos(10, 10)
	clientText:SetText("Client Menu")
	clientText:SetTextColor(Color(0, 0, 0))
	clientText:SizeToContents()

	local expText = vgui.Create("DLabel", Base1)
	expText:SetPos(10, 30)
	expText:SetText("Amount of Exp you want to buy")
	expText:SetTextColor(Color(0, 0, 0))
	expText:SizeToContents()

	local amountCache = 0

	local expBuy = vgui.Create("DButton", Base1)
	expBuy:SetPos(110, 45)
	expBuy:SetText("Buy 0 Exp: "..currencyLabel.."0")
	expBuy:SetSize(150, 20)
	expBuy.DoClick = function()
		if amountCache > 0 then
			MLevel_ClientRequestExpBuy(amountCache)
		end
	end

	local expAmountSelect = vgui.Create("DNumberWang", Base1)
	expAmountSelect:SetPos(10, 45)
	expAmountSelect:SetSize(100, 20)
	expAmountSelect:SetDecimals(0)
	expAmountSelect:SetMin(0)
	expAmountSelect:SetValue(0)
	expAmountSelect:HideWang()
	expAmountSelect.OnValueChange = function()
		expBuy:SetText("Buy "..expAmountSelect:GetValue().." Exp: "..currencyLabel..(MLevel_PricePerExp * expAmountSelect:GetValue()))
		amountCache = expAmountSelect:GetValue()
	end

	local LstatText = vgui.Create("DLabel", Base1)
	LstatText:SetPos(10, 70)
	LstatText:SetText("Level: "..ply.MLevel)
	LstatText:SetTextColor(Color(0, 0, 0))
	LstatText:SizeToContents()

	local EstatText = vgui.Create("DLabel", Base1)
	EstatText:SetPos(110, 70)
	EstatText:SetText("Experience: "..ply.MExp)
	EstatText:SetTextColor(Color(0, 0, 0))
	EstatText:SizeToContents()

	local SstatText = vgui.Create("DLabel", Base1)
	SstatText:SetPos(10, 90)
	SstatText:SetText("Skill: "..ply.MSkill)
	SstatText:SetTextColor(Color(0, 0, 0))
	SstatText:SizeToContents()

	local HstatText = vgui.Create("DLabel", Base1)
	HstatText:SetPos(110, 90)
	HstatText:SetText("Health: "..ply.MHealth)
	HstatText:SetTextColor(Color(0, 0, 0))
	HstatText:SizeToContents()

	local AstatText = vgui.Create("DLabel", Base1)
	AstatText:SetPos(10, 110)
	AstatText:SetText("Armor: "..ply.MArmor)
	AstatText:SetTextColor(Color(0, 0, 0))
	AstatText:SizeToContents()

	local SpstatText = vgui.Create("DLabel", Base1)
	SpstatText:SetPos(110, 110)
	SpstatText:SetText("Speed: "..ply.MSpeed)
	SpstatText:SetTextColor(Color(0, 0, 0))
	SpstatText:SizeToContents()

	local JstatText = vgui.Create("DLabel", Base1)
	JstatText:SetPos(10, 130)
	JstatText:SetText("Jump: "..ply.MJump)
	JstatText:SetTextColor(Color(0, 0, 0))
	JstatText:SizeToContents()

	local FstatText = vgui.Create("DLabel", Base1)
	FstatText:SetPos(110, 130)
	FstatText:SetText("Fall: "..ply.MFall)
	FstatText:SetTextColor(Color(0, 0, 0))
	FstatText:SizeToContents()

	local CstatType = vgui.Create("DComboBox", Base1)
	CstatType:SetPos(10, 150)
	CstatType:SetSize(100, 20)
	CstatType:SetValue("Select Stat")
	CstatType:AddChoice("Health")
	CstatType:AddChoice("Armor")
	CstatType:AddChoice("Speed")
	CstatType:AddChoice("Jump Height")
	CstatType:AddChoice("Fall Damage")

	local setStat = vgui.Create("DButton", Base1)
	setStat:SetPos(110, 150)
	setStat:SetText("Set Stat")
	setStat:SetSize(150, 20)
	setStat.DoClick = function()
		if CstatType:GetValue() == "Select Stat" then
			ply:ChatPrint("You need to select a stat")
			return
		end

		if ply.MSkill == 0 then
			ply:ChatPrint("You do not have any skill points to spend")
			return
		end

		if CstatType:GetValue() == "Health" then
			stat = "health"
		elseif CstatType:GetValue() == "Armor" then
			stat = "armor"
		elseif CstatType:GetValue() == "Speed" then
			stat = "speed"
		elseif CstatType:GetValue() == "Jump Height" then
			stat = "jump"
		elseif CstatType:GetValue() == "Fall Damage" then
			stat = "fall"
		end

		MLevel_ClientRequestStatIncrease(stat)

		timer.Simple(0.1, function()
		LstatText:SetText("Level: "..ply.MLevel)
		EstatText:SetText("Experience: "..ply.MExp)
		SstatText:SetText("Skill: "..ply.MSkill)
		HstatText:SetText("Health: "..ply.MHealth)
		AstatText:SetText("Armor: "..ply.MArmor)
		SpstatText:SetText("Speed: "..ply.MSpeed)
		JstatText:SetText("Jump: "..ply.MJump)
		FstatText:SetText("Fall: "..ply.MFall)
		end)
	end

	// ADMIN MENU //////////////////////////////////////////////////////////////////////////////////////////////////////////
	if MLevel_PlayerIsAdmin(ply) == false then return end
	local function updatePlayerText() 
		timer.Simple(0.1, function()
		LstatText:SetText("Level: "..ply.MLevel)
		EstatText:SetText("Experience: "..ply.MExp)
		SstatText:SetText("Skill: "..ply.MSkill)
		HstatText:SetText("Health: "..ply.MHealth)
		AstatText:SetText("Armor: "..ply.MArmor)
		SpstatText:SetText("Speed: "..ply.MSpeed)
		JstatText:SetText("Jump: "..ply.MJump)
		FstatText:SetText("Fall: "..ply.MFall)
		end)
	end
	
	local ap = ((Base1:GetWide()/2) - 65)
	local clientText = vgui.Create("DLabel", Base1)
	clientText:SetPos(ap, 10)
	clientText:SetText("Admin Menu")
	clientText:SetTextColor(Color(0, 0, 0))
	clientText:SizeToContents()

	local playerSelect = vgui.Create("DComboBox", Base1)
	playerSelect:SetPos(ap + 65, 10)
	playerSelect:SetSize(100, 20)
	playerSelect:SetValue("Select Player")
	for k,v in pairs(player.GetAll()) do
		playerSelect:AddChoice(v:Nick())
	end

	local amountSelect = vgui.Create("DNumberWang", Base1)
	amountSelect:SetPos(ap + 165, 10)
	amountSelect:SetSize(100, 20)
	amountSelect:SetDecimals(0)
	amountSelect:SetMin(0)
	amountSelect:SetMax(999999) // I might change but seriously guys, this is excessive
	amountSelect:SetValue(0)

	local wipeSkills = vgui.Create("DButton", Base1)
	wipeSkills:SetPos(ap + 265, 10)
	wipeSkills:SetText("Wipe Player's Level")
	wipeSkills:SetSize(100, 20)
	wipeSkills.DoClick = function()
		if playerSelect:GetValue() == "Select Player" then
			ply:ChatPrint("You need to select a player")
			return
		end
		local target

		for k,v in pairs(player.GetAll()) do
			if v:Nick() == playerSelect:GetValue() then
				target = v
			end
		end
		MLevel_ClientRequestWipe(target)
		updatePlayerText()
	end

	local setLevel = vgui.Create("DButton", Base1)
	setLevel:SetPos(ap, 30)
	setLevel:SetText("Set Level")
	setLevel:SetSize(400, 40)
	setLevel.DoClick = function()
		if playerSelect:GetValue() == "Select Player" then
			ply:ChatPrint("You need to select a player")
			return
		end
		local target

		for k,v in pairs(player.GetAll()) do
			if v:Nick() == playerSelect:GetValue() then
				target = v
			end
		end
		MLevel_ClientRequestChange(target, "level", amountSelect:GetValue())
		updatePlayerText()
	end

	local setSkill = vgui.Create("DButton", Base1)
	setSkill:SetPos(ap, 72)
	setSkill:SetText("Set Skill Points")
	setSkill:SetSize(400, 40)
	setSkill.DoClick = function()
		if playerSelect:GetValue() == "Select Player" then
			ply:ChatPrint("You need to select a player")
			return
		end
		local target

		for k,v in pairs(player.GetAll()) do
			if v:Nick() == playerSelect:GetValue() then
				target = v
			end
		end
		MLevel_ClientRequestChange(target, "skill", amountSelect:GetValue())
		updatePlayerText()
	end

	local setExp = vgui.Create("DButton", Base1)
	setExp:SetPos(ap, 114)
	setExp:SetText("Set Experience")
	setExp:SetSize(400, 40)
	setExp.DoClick = function()
		if playerSelect:GetValue() == "Select Player" then
			ply:ChatPrint("You need to select a player")
			return
		end
		local target

		for k,v in pairs(player.GetAll()) do
			if v:Nick() == playerSelect:GetValue() then
				target = v
			end
		end
		MLevel_ClientRequestChange(target, "exp", amountSelect:GetValue())
		updatePlayerText()
	end

	local statType = vgui.Create("DComboBox", Base1)
	statType:SetPos(ap + 200, 156)
	statType:SetSize(200, 40)
	statType:SetValue("Select Stat")
	statType:AddChoice("Health")
	statType:AddChoice("Armor")
	statType:AddChoice("Speed")
	statType:AddChoice("Jump Height")
	statType:AddChoice("Fall Damage")

	local setStat = vgui.Create("DButton", Base1)
	setStat:SetPos(ap, 156)
	setStat:SetText("Set Stat")
	setStat:SetSize(200, 40)
	setStat.DoClick = function()
		if playerSelect:GetValue() == "Select Player" then
			ply:ChatPrint("You need to select a player")
			return
		end

		if statType:GetValue() == "Select Stat" then
			ply:ChatPrint("You need to select a stat")
			return
		end
		local target

		for k,v in pairs(player.GetAll()) do
			if v:Nick() == playerSelect:GetValue() then
				target = v
			end
		end
		local stat

		if statType:GetValue() == "Health" then
			stat = "health"
		elseif statType:GetValue() == "Armor" then
			stat = "armor"
		elseif statType:GetValue() == "Speed" then
			stat = "speed"
		elseif statType:GetValue() == "Jump Height" then
			stat = "jump"
		elseif statType:GetValue() == "Fall Damage" then
			stat = "fall"
		end

		MLevel_ClientRequestChange(target, "stat", amountSelect:GetValue(), stat)
		updatePlayerText()
	end
end
concommand.Add("ML_Menu", function(ply, cmd, args) 
	if MLevel_MenuIsOpen == false then
		MLevel_MenuIsOpen = true
		MLevel_OpenMenu(ply)
	end
end)
