ENT.Type = 'anim'
 
ENT.PrintName = "Weed Bag"
ENT.Purpose = "To hold the weed"
ENT.Category = "Simple Weed"
ENT.Spawnable = true
ENT.AdminSpawnable = true
ENT.DoNoDuplicate = true
ENT.IsWeed = true

function ENT:SetupDataTables()
    self:NetworkVar("Entity", 0, "owning_ent")
    self:NetworkVar("Int", 0, "Amount")
end