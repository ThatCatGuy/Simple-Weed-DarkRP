ENT.Type = "anim"
ENT.PrintName = "base destroyable ent"
ENT.Author = ""
ENT.Spawnable = false
ENT.Category = ""

function ENT:SetupDataTables()	
	self:NetworkVar("Entity", 0, "owning_ent")
end