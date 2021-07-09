ENT.Base = "base_ai" 
ENT.Type = "ai" 
ENT.AutomaticFrameAdvance = true
ENT.PrintName = "Weed Buyer"
ENT.Category = "Simple Weed"
ENT.Spawnable = false
ENT.AdminOnly = false 

ENT.Name = "Weed Buyer"
ENT.Model = "models/Humans/Group01/male_02.mdl"

function ENT:SetAutomaticFrameAdvance( bUsingAnim )
	self.AutomaticFrameAdvance = bUsingAnim
end