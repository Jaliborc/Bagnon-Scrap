--[[
Copyright 2008-2020 João Cardoso
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

local Plugin = Scrap:NewModule('Wildpants')
local Addon = Bagnon or Combuctor


--[[ API Usage ]]--

Plugin:RegisterSignal('LIST_CHANGED', function()
	Addon.Frames:Update()
end)

Addon.Rules:New('scrap', 'Scrap', 'Interface/Addons/Scrap/art/enabled-box', function(_, bag, slot, _, item)
	if item.id and bag and slot then
		return Scrap:IsJunk(item.id, bag, slot)
	end
end)


--[[ Extension ]]--

local UpdateBorder = Addon.Item.UpdateBorder
local R,G,B = GetItemQualityColor(0)

function Addon.Item:UpdateBorder()
	local online = not self.info.cached
	local junk = Scrap:IsJunk(self.info.id, online and self:GetBag(), online and self:GetID())

	UpdateBorder(self)
	self.JunkIcon:SetShown(Scrap.sets.icons and junk)

	if Scrap.sets.glow and junk then
		self.IconBorder:SetVertexColor(R,G,B)
		self.IconBorder:Show()
		self.IconGlow:SetVertexColor(R,G,B, Addon.sets.glowAlpha)
		self.IconGlow:Show()
	end
end
