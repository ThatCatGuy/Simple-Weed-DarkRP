include("shared.lua")

surface.CreateFont( "weed_plant_large", {
    font = "roboto",
    size = 75,
    weight = 1000
})

surface.CreateFont( "weed_plant_small", {
    font = "roboto",
    size = 45,
    weight = 1000
})

local color_green = Color(0, 220, 0)
local color_darkgreen = Color(123, 170, 71)
local color_white = Color(255, 255, 255)
local color_black = Color(0, 0, 0)

local scales_adjust = {
	[1] = -50,
	[1.25] = -60,
	[1.5] = -70
}

local scale_to_seeds = {
	[1] = 1,
	[1.25] = 2,
	[1.5] = 3
}

function ENT:Draw()
	self:DrawModel()
		
	local simpleweed_growtime = GetConVar( "simpleweed_growtime" )
	local pos = self:GetPos()
	local ang = self:GetAngles()
	local distance = pos:DistToSqr(LocalPlayer():GetPos())
	
	if distance > 160000 then return end
	color_white.a = 400 - (distance / 400)
	color_black.a = 400 - (distance / 400)
	if self:GetStage() == 8 then
		self.RemainingTime = nil
	end
	if self:GetStage() > 0 then 
		if !self.RemainingTime then self.RemainingTime = CurTime() + (simpleweed_growtime:GetInt() * 7) end
	end	

	ang:RotateAroundAxis(ang:Up(), 135)
	ang:RotateAroundAxis(ang:Forward(), 90)
	cam.Start3D2D(self:GetPos() + ang:Right() * scales_adjust[self:GetModelScale()], ang, 0.10)
		if self:GetStage() > 0 && self:GetStage() < 8 then
			draw.SimpleTextOutlined(SimpleWeedTimeLeftString(self.RemainingTime - CurTime()), "DermaLarge", 0, -10, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, color_black)
		end
		draw.SimpleTextOutlined(self:GetStage() == 0 and "Weed Pot" or self:GetStage() == 8 and "Ready!" or "Growing", "weed_plant_large", 0, 0, self:GetStage() == 8 and color_green or color_darkgreen, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, color_black)
	cam.End3D2D()	
	cam.Start3D2D(self:GetPos() + ang:Right() * scales_adjust[self:GetModelScale()], ang, 0.05)
		draw.SimpleTextOutlined("Seeds " .. self:GetSeeds() .. "/" .. scale_to_seeds[self:GetModelScale()], "weed_plant_small", 0, 150, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, color_black)
		draw.SimpleTextOutlined("Shift + E to Stand Up", "weed_plant_small", 0, 200, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, color_black)
	cam.End3D2D()	

	ang:RotateAroundAxis(ang:Up(), 180)
	ang:RotateAroundAxis(ang:Forward(), 180)
	cam.Start3D2D(self:GetPos() + ang:Right() * scales_adjust[self:GetModelScale()], ang, 0.10)
		if self:GetStage() > 0 && self:GetStage() < 8 then
			draw.SimpleTextOutlined(SimpleWeedTimeLeftString(self.RemainingTime - CurTime()), "DermaLarge", 0, -10, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, color_black)
		end
		draw.SimpleTextOutlined(self:GetStage() == 0 and "Weed Pot" or self:GetStage() == 8 and "Ready!" or "Growing", "weed_plant_large", 0, 0, self:GetStage() == 8 and color_green or color_darkgreen, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, color_black)
	cam.End3D2D()	
	cam.Start3D2D(self:GetPos() + ang:Right() * scales_adjust[self:GetModelScale()], ang, 0.05)
		draw.SimpleTextOutlined("Seeds " .. self:GetSeeds() .. "/" .. scale_to_seeds[self:GetModelScale()], "weed_plant_small", 0, 150, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, color_black)
		draw.SimpleTextOutlined("Shift + E to Stand Up", "weed_plant_small", 0, 200, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, color_black)
	cam.End3D2D()
end