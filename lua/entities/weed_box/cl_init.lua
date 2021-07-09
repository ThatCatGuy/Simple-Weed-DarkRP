include("shared.lua")

surface.CreateFont( "weed_box", {
    font = "roboto",
    size = 45,
    weight = 1000
})

local color_white   = Color(255,255,255)
local color_red     = Color(255,0,0)
local color_green   = Color(0,255,0)
local color_black   = Color(0,0,0)


function ENT:Draw()
    self:DrawModel()

    local pos = self:GetPos()
    local ang = self:GetAngles()
	
	local dist = pos:Distance(LocalPlayer():GetPos())
	
	if (dist > 200) then return end

    local owner = self:Getowning_ent()
    owner = (IsValid(owner) and owner:Nick()) or DarkRP.getPhrase("unknown")

    surface.SetFont("HUDNumber5")
    local TextWidth = surface.GetTextSize(owner)

	ang:RotateAroundAxis(ang:Forward(), 90)
	ang:RotateAroundAxis(ang:Right(), -90)

    cam.Start3D2D(pos + self:GetForward() * (self:OBBMaxs().y - 4), ang, 0.11)
		draw.SimpleTextOutlined(owner, "weed_box", 0, -10, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM, 1, color_black)
		draw.SimpleTextOutlined(self:GetWeed() .. " ounces", "weed_box", 0, -10, (self:GetWeed() > 0 and color_green ) or color_red, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, color_black)
    cam.End3D2D()
end