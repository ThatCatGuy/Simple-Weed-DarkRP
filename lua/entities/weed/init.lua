AddCSLuaFile( "cl_init.lua" ) 
AddCSLuaFile( "shared.lua" ) 

include( 'shared.lua' )

function ENT:Initialize()
	self:SetUseType( SIMPLE_USE )
	self:SetModel("models/katharsmodels/contraband/zak_wiet/zak_wiet.mdl")
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetCollisionGroup( COLLISION_GROUP_WEAPON  )
	self:SetAmount(1)
	
    local phys = self:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Wake()
	end

    if IsValid(self.dt.owning_ent) then
        self:CPPISetOwner(self.dt.owning_ent)
        self.SID = self.dt.owning_ent.SID
    end
end

function ENT:Use(activator, caller)
	SimpleWeedPickUp(caller, self:GetAmount())
	self:Remove()
end