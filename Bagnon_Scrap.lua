--[[
	Copyright 2008-2025 João Cardoso
	All Rights Reserved
--]]

local Addon = Bagnon or Bagnonium
if not Addon then return end


--[[ API Usage ]]--

Scrap:NewModule('Bagnon'):RegisterSignal('LIST_CHANGED', function()
	Addon.Frames:Update()
end)

Addon.Rules:Register {
	id = 'scrap', title = 'Scrap', icon = 'interface/addons/scrap/art/scrap-big',
	macro = [[
		if info.itemID and bag and slot then
			return Scrap:IsJunk(info.itemID, bag, slot)
		end]]
}


--[[ Extension ]]--

local C = LibStub('C_Everywhere')
local R,G,B = C.Item.GetItemQualityColor(0)
local UpdateBorder, UpdateGlow = Addon.Item.UpdateBorder, Addon.ContainerItem.UpdateGlow

function Addon.Item:UpdateBorder()
	local online = not self:IsCached()
	local junk = Scrap:IsJunk(self.info.itemID, online and tonumber(self:GetBag()), online and tonumber(self:GetID()))

	UpdateBorder(self)
	self.JunkIcon:SetShown(Scrap.sets.icons and junk)

	if Scrap.sets.glow and junk then
		self.IconGlow:SetVertexColor(R,G,B, Addon.sets.glowAlpha)
		self.IconGlow:Show()
		self.IconOverlay:SetVertexColor(R,G,B)
		self.IconOverlay:SetDesaturated(true)
		self.IconBorder:SetVertexColor(R,G,B)
		self.IconBorder:Show()
	else
		self.IconOverlay:SetDesaturated(false)
	end
end

function Addon.ContainerItem:UpdateGlow()
	UpdateGlow(self)
	
	if self.NewItemTexture:IsShown() and self.IconOverlay:IsDesaturated() then
		self.NewItemTexture:SetAtlas('bags-glow-white')
	end
end