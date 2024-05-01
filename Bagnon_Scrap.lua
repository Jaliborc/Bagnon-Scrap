--[[
Copyright 2008-2024 João Cardoso
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

local Addon = Bagnon or Bagnonium
if not Addon then return end
local Plugin = Scrap:NewModule('Bagnon')


--[[ API Usage ]]--

Plugin:RegisterSignal('LIST_CHANGED', function()
	Addon.Frames:Update()
end)

Addon.Rules:New('scrap', 'Scrap', 'interface/addons/scrap/art/scrap-big', function(_, bag, slot, _, item)
	if item.id and bag and slot then
		return Scrap:IsJunk(item.id, bag, slot)
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
