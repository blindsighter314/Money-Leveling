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
	local clientText = vgui.Create("DLabel", Base1)
	clientText:SetPos(10, 10)
	clientText:SetText("Client Menu")
	clientText:SetTextColor(Color(0, 0, 0))
	clientText:SizeToContents()

	// ADMIN MENU //////////////////////////////////////////////////////////////////////////////////////////////////////////
	if not ply:IsAdmin() then return end
	local ap = ((Base1:GetWide()/2) + 10)
	print(ap)
	local clientText = vgui.Create("DLabel", Base1)
	clientText:SetPos(ap, 10)
	clientText:SetText("Admin Menu")
	clientText:SetTextColor(Color(0, 0, 0))
	clientText:SizeToContents()

	local playerSelect = vgui.Create("DComboBox", Base1)
	playerSelect:SetPos(ap + 100, 8)
	playerSelect:SetSize(100, 20)
	playerSelect:SetValue("Select Player")
	for k,v in pairs(player.GetAll()) do
		playerSelect:AddChoice(v:Nick())
	end

	local amountSelect = vgui.Create("DNumberWang", Base1)
	amountSelect:SetPos(ap + 100, 30)
	amountSelect:SetSize(100, 20)
	amountSelect:SetDecimals(0)
	amountSelect:SetMin(0)
	amountSelect:SetMax(999999) // I might change but seriously guys, this is excessive
	amountSelect:SetValue(0)

	local setLevel = vgui.Create("DButton", Base1)
	setLevel:SetPos(ap, 30)
	setLevel:SetText("Set Level")
	setLevel:SetSize(100, 20)
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
	end

	local setSkill = vgui.Create("DButton", Base1)
	setSkill:SetPos(ap, 50)
	setSkill:SetText("Set Skill Points")
	setSkill:SetSize(100, 20)
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
	end

	local setExp = vgui.Create("DButton", Base1)
	setExp:SetPos(ap, 70)
	setExp:SetText("Set Experience")
	setExp:SetSize(100, 20)
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
	end
end
concommand.Add("ML_Menu", function(ply, cmd, args) 
	if MLevel_MenuIsOpen == false then
		MLevel_MenuIsOpen = true
		MLevel_OpenMenu(ply)
	end
end)
