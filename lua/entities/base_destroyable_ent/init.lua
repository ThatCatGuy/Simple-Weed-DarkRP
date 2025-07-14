AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
    self:SetUseType( SIMPLE_USE )
    self:SetModel(self.Model)
    if self.Color then
        self:SetColor(self.Color)
    end
    if self.Material then
        self:SetMaterial(self.Material)
    end
    self:PhysicsInit( SOLID_VPHYSICS )
    self:SetMoveType( MOVETYPE_VPHYSICS )
    self:SetSolid( SOLID_VPHYSICS )
    self:SetCollisionGroup( COLLISION_GROUP_WEAPON  )

    local phys = self:GetPhysicsObject()
    if (phys:IsValid()) then
        phys:Wake()
    end

    if IsValid(self.dt.owning_ent) then
        self:CPPISetOwner(self.dt.owning_ent)
        self.SID = self.dt.owning_ent.SID
    end
end

function ENT:OnTakeDamage(damage)
    self:Remove()
end