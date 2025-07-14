AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
    self:SetModel("models/props_junk/PlasticCrate01a.mdl")
    self:SetSkin(3)
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
    self:SetUseType(SIMPLE_USE)
    self:SetCollisionGroup( COLLISION_GROUP_WEAPON  )
    self:SetWeed(0)

    local phys = self:GetPhysicsObject()
    if IsValid(phys) then
        phys:EnableMotion(false)
    end
    if IsValid(self.dt.owning_ent) then
        self:CPPISetOwner(self.dt.owning_ent)
        self.SID = self.dt.owning_ent.SID
    end
end

function ENT:CanUse(player)
    if self.OnlyForOwner then
        return player == self:Getowning_ent()
    end
    return true
end

function ENT:Use(activator, caller)
    if caller:IsPlayer() then
        if self:CanUse(caller) and self:GetWeed() > 0 then
            if caller != self:Getowning_ent() then
                DarkRP.notify(self:Getowning_ent(), 3, 4, caller:Nick() .. " took " .. self:GetWeed() .. " ounces from your weed box.")
            end
            SimpleWeedPickUp(caller, self:GetWeed())
            self:SetWeed(0)
        end
    end
end

function ENT:Touch(ent)
    if IsValid(ent) and ent:GetClass() == "weed" and !ent.taken then
        ent.taken = true
        local total = self:GetWeed() + ent:GetAmount()
        self:SetWeed(total)
        ent:Remove()        
    end
end

function ENT:OnTakeDamage(dmg)
    if self.MaxHealth then
        self.MaxHealth = self.MaxHealth - (dmg:GetDamage() * 0.5)
        if (self.MaxHealth <= 0) then
            self:Remove()
        end
    end
end