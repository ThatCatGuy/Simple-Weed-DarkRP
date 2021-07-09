AddCSLuaFile('cl_init.lua')
AddCSLuaFile('shared.lua')
include('shared.lua')

function ENT:Initialize()
	self:SetModel(self.Model)

	self:SetHullType(HULL_HUMAN)
	self:SetHullSizeNormal()
	self:SetNPCState(NPC_STATE_SCRIPT)
	self:SetSolid(SOLID_BBOX)
	self:CapabilitiesAdd(CAP_ANIMATEDFACE)
	self:SetUseType(SIMPLE_USE)
	self:DropToFloor()
	self:SetCollisionGroup(COLLISION_GROUP_DEBRIS_TRIGGER)
	self:SetMaxYawSpeed(90)
end

local simpleweed_sellprice = GetConVar( "simpleweed_sellprice" )

function ENT:AcceptInput(name, activator, caller, data)
	if caller.NPCNextUse and caller.NPCNextUse > CurTime() then
		return
	end
	caller.NPCNextUse = CurTime() + 5
	if name == "Use" and IsValid(caller) and caller:IsPlayer() then
		if caller.Weed and caller.Weed > 0 then
			local reward = caller.Weed * simpleweed_sellprice:GetInt()
			local msg = "Yeah my guy pulling in " .. caller.Weed .. " ounces of weed. Here is " .. DarkRP.formatMoney(reward) .. "."
			SimpleWeedSold(caller, msg)
			caller.Weed = 0
			caller:addMoney(reward)
			SimpleWeedWantedPlayer(caller, "Selling weed.", 300)
		else
			SimpleWeedRandomSaying(caller)
		end
	end
end