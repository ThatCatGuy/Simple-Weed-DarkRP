include("shared.lua")

function ENT:Draw()
	self:DrawModel()

	local green = Color(123, 170, 71, 255)
	local dark = Color(25, 25, 25, 100)

	local pos = self:GetPos()
	local ang = self:GetAngles()
	
	ang:RotateAroundAxis(ang:Up(), 90);
	ang:RotateAroundAxis(ang:Forward(), 90);	
	if LocalPlayer():GetPos():DistToSqr(self:GetPos()) < 30000 then
		cam.Start3D2D(pos + ang:Up(), Angle(0, LocalPlayer():EyeAngles().y-90, 90), 0.1)
				draw.SimpleTextOutlined("Weed ("..self:GetAmount().." ounces)", "Trebuchet24", 8, -96, green, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, dark)
		cam.End3D2D()
	end
end