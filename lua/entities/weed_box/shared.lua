ENT.Type = "anim"
ENT.Base = "base_anim"
ENT.PrintName = "Weed Box"
ENT.Category = "Simple Weed"
ENT.Spawnable = true
ENT.OnlyForOwner = false
ENT.MaxHealth = 100
ENT.Freeze = true

function ENT:SetupDataTables()
    self:NetworkVar("Entity", 0, "owning_ent")
    self:NetworkVar("Float", 1, "Weed")
end