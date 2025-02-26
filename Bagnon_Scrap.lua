--[[
	Copyright 2008-2025 João Cardoso
	All Rights Reserved
--]]

local Addon = Bagnon or Bagnonium
if not Addon then return end
local Plugin = Scrap:NewModule('Bagnon')


--[[ API Usage ]]--

Plugin:RegisterSignal('LIST_CHANGED', function()
	Addon.Frames:Update()
end)

Addon.Rules:New('scrap', 'Scrap', 'interface/addons/scrap/art/scrap-big', function(_, bag, slot, _, data)
	if data.itemID and bag and slot then
		return Scrap:IsJunk(data.itemID, bag, slot)
	end
end)


--[[ Extension ]]--

local UpdateBorder = Addon.Item.UpdateBorder
local R,G,B = GetItemQualityColor(0)

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
