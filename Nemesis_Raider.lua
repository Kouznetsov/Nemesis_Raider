-----------------------------------------------------------------------------------------------
-- Client Lua Script for Nemesis_Raider
-- Copyright (c) NCsoft. All rights reserved
-----------------------------------------------------------------------------------------------
 
require "Window"
 
-----------------------------------------------------------------------------------------------
-- Nemesis_Raider Module Definition
-----------------------------------------------------------------------------------------------
local Nemesis_Raider = {} 
 
-----------------------------------------------------------------------------------------------
-- Constants
-----------------------------------------------------------------------------------------------
-- e.g. local kiExampleVariableMax = 999
 
-----------------------------------------------------------------------------------------------
-- Initialization
-----------------------------------------------------------------------------------------------
function Nemesis_Raider:new(o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self 

    -- initialize variables here

    return o
end

function Nemesis_Raider:Init()
	local bHasConfigureFunction = false
	local strConfigureButtonText = ""
	local tDependencies = {
		-- "UnitOrPackageName",
	}
    Apollo.RegisterAddon(self, bHasConfigureFunction, strConfigureButtonText, tDependencies)
end
 

-----------------------------------------------------------------------------------------------
-- Nemesis_Raider OnLoad
-----------------------------------------------------------------------------------------------
function Nemesis_Raider:OnLoad()
    -- load our form file
	self.xmlDoc = XmlDoc.CreateFromFile("Nemesis_Raider.xml")
	self.xmlDoc:RegisterCallback("OnDocLoaded", self)
end

-----------------------------------------------------------------------------------------------
-- Nemesis_Raider OnDocLoaded
-----------------------------------------------------------------------------------------------
function Nemesis_Raider:OnDocLoaded()

	if self.xmlDoc ~= nil and self.xmlDoc:IsLoaded() then
	    self.wndMain = Apollo.LoadForm(self.xmlDoc, "Nemesis_RaiderForm", nil, self)
		if self.wndMain == nil then
			Apollo.AddAddonErrorText(self, "Could not load the main window for some reason.")
			return
		end
		
	    self.wndMain:Show(false, true)

		-- if the xmlDoc is no longer needed, you should set it to nil
		-- self.xmlDoc = nil
		
		-- Register handlers for events, slash commands and timer, etc.
		-- e.g. Apollo.RegisterEventHandler("KeyDown", "OnKeyDown", self)
		Apollo.RegisterSlashCommand("nraid", "OnNemesis_RaiderOn", self)

		self.timer = ApolloTimer.Create(1.0, true, "OnTimer", self)

		-- Do additional Addon initialization here
	end
end

-----------------------------------------------------------------------------------------------
-- Nemesis_Raider Functions
-----------------------------------------------------------------------------------------------
-- Define general functions here

-- on SlashCommand "/nraid"
function Nemesis_Raider:OnNemesis_RaiderOn()
	self.wndMain:Invoke() -- show the window
	self:CloseWindows()
end

-- on timer
function Nemesis_Raider:OnTimer()
	-- Do your timer-related stuff here.
end

-----------------------------------------------------------------------------------------------
-- Nemesis_RaiderForm Functions
-----------------------------------------------------------------------------------------------
-- when the OK button is clicked
function Nemesis_Raider:OnOK()
	self.wndMain:Close() -- hide the window
end

-- when the Cancel button is clicked
function Nemesis_Raider:OnCancel()
	self.wndMain:Close() -- hide the window
end

-- To call before opening a raid concerning window 
function Nemesis_Raider:CloseWindows()
	self.wndMain:FindChild("currentRaidsWindow"):Close()
	self.wndMain:FindChild("invitationsWindow"):Close()
	self.wndMain:FindChild("passedRaidsWindow"):Close()
	self.wndMain:FindChild("createRaidWindow"):Close()
end


-- Click button events function
-- Raid button click
function Nemesis_Raider:OnCurrentRaidsButtonClick( wndHandler, wndControl, eMouseButton )
	self:CloseWindows()
	self.wndMain:FindChild("currentRaidsWindow"):Invoke()
end

function Nemesis_Raider:OnInvitationsButtonClick(wndHandler, wndControl, eMouseButton)
	self:CloseWindows()
	self.wndMain:FindChild("invitationsWindow"):Invoke()
end

function Nemesis_Raider:OnPassedRaidsButtonClick(wndHandler, wndControl, eMouseButton)
	self:CloseWindows()
	self.wndMain:FindChild("passedRaidsWindow"):Invoke()
end

function Nemesis_Raider:OnCreateRaidButtonClick(wndhandler, wndControl, eMouseButton)
	self:CloseWindows()
	self.wndMain:FindChild("createRaidWindow"):Invoke()
end

-----------------------------------------------------------------------------------------------
-- Nemesis_Raider Instance
-----------------------------------------------------------------------------------------------
local Nemesis_RaiderInst = Nemesis_Raider:new()
Nemesis_RaiderInst:Init()
