ENT.Type = 'anim'
 
ENT.PrintName = "Weed Plant"
ENT.Category = "Simple Weed"
ENT.Purpose = "growing weed"
ENT.Instructions = "N/A"

ENT.Spawnable = true
ENT.AdminSpawnable = true
ENT.Time = 85
ENT.HP = 200
ENT.DoNoDuplicate = true
ENT.ReadyForHarvest = false
ENT.IsWeedPot = true

function ENT:SetupDataTables()
    self:NetworkVar("Entity", 0, "owning_ent")
    self:NetworkVar("Int", 0, "Stage")
    self:NetworkVar("Int", 1, "Seeds")
end

ENT.ScaleToHarvest = {
    [1] = 1,
    [1.25] = 2,
    [1.5] = 3
}