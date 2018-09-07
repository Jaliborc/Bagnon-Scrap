--[[
Copyright 2008-2018 João Cardoso
Bagnon Scrap is distributed under the terms of the GNU General Public License (Version 3).
As a special exception, the copyright holders of this addon do not give permission to
redistribute and/or modify it.

This addon is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with the addon. If not, see <http://www.gnu.org/licenses/gpl-3.0.txt>.

This file is part of Bagnon Scrap.
--]]

local Addon = Bagnon
local ItemSlot = Addon.ItemSlot
local UpdateBorder = ItemSlot.UpdateBorder
local r, g, b = GetItemQualityColor(0)


--[[ Ruleset ]]--

Addon.Rules:New('scrap', 'Scrap', 'Interface\\Addons\\Scrap\\Art\\Enabled Box', function(player, bag, slot, bagInfo, itemInfo)
	if itemInfo.id and bag and slot then
		return Scrap:IsJunk(itemInfo.id, bag, slot)
	end
end)


--[[ Glow and Icon ]]--

function ItemSlot:UpdateBorder()
	local id = self.info.id
	local online = not self.info.cached

	local bag = online and self:GetBag()
	local slot = online and self:GetID()
	local junk = Scrap:IsJunk(id, bag, slot)

	UpdateBorder(self)
	self.JunkIcon:SetShown(Scrap_Icons and junk)

	if Scrap_Glow and junk then
		self.IconBorder:SetVertexColor(r, g, b)
		self.IconBorder:Show()

		self.IconGlow:SetVertexColor(r, g, b, Addon.sets.glowAlpha)
		self.IconGlow:Show()
	end
end


--[[ Update Events ]]--

local function UpdateBags()
	Addon:UpdateFrames()
end

hooksecurefunc(Scrap, 'VARIABLES_LOADED', UpdateBags)
hooksecurefunc(Scrap, 'ToggleJunk', UpdateBags)
Scrap.HasSpotlight = true
