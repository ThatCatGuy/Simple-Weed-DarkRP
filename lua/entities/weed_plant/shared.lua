ENT.Type = 'anim'
 
ENT.PrintName = "Weed Plant"
ENT.Category = "Simple Weed"
ENT.Purpose = "growing weed"
ENT.Instructions = "N/A"

ENT.SeizeReward = 10000

ENT.Spawnable = true
ENT.AdminSpawnable = true
ENT.HP = 200
ENT.DoNoDuplicate = true
ENT.ReadyForHarvest = false
ENT.IsWeedPot = true

function ENT:SetupDataTables()
    self:NetworkVar("Entity", 0, "owning_ent")
    self:NetworkVar("Int", 1, "Stage")
end