include('shared.lua')

surface.CreateFont("npc_title",{
	font = "DermaLarge",
	size = 95
})

local color_white = Color(255, 255, 255)
local color_black = Color(0, 0, 0)

function ENT:Draw()
	self.Entity:DrawModel()
	
	local pos = self:GetPos()
	local ang = self:GetAngles()
	local distance = pos:Distance(LocalPlayer():GetPos())
	
	if distance > 400 then return end
	color_white.a = 400 - distance
	color_black.a = 400 - distance

	ang:RotateAroundAxis(ang:Up(), 90)
	ang:RotateAroundAxis(ang:Forward(), 90)	
	cam.Start3D2D(pos + ang:Up() + ang:Right() * -70, Angle(0, LocalPlayer():EyeAngles().y-90, 90), 0.1)
			draw.SimpleTextOutlined(self.Name, "npc_title", 0, -125, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_LEFT, 1, color_black)			
	cam.End3D2D()	
end