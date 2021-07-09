AddCSLuaFile( "cl_init.lua" ) 
AddCSLuaFile( "shared.lua" ) 

include( 'shared.lua' )

function ENT:Initialize()
	self:SetUseType( SIMPLE_USE )
	self:SetModel("models/nater/weedplant_pot.mdl")
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetCollisionGroup( COLLISION_GROUP_WEAPON  )
	self:SetPos(self:GetPos()+Vector(0, 0, 32));
    local phys = self:GetPhysicsObject()

	if (phys:IsValid()) then
		phys:Wake()
	end
	self.angleResetCooldown = 0
	self:SetStage(0)
    if IsValid(self.dt.owning_ent) then
        self:CPPISetOwner(self.dt.owning_ent)
        self.SID = self.dt.owning_ent.SID
    end
end

function ENT:StartTouch(ent)
	if ent:GetClass() == "weed_seed" and self:GetStage() == 0 and !ent.Used then
		ent.Used = true
		ent:Remove()
		self:StageOne()
	end
end

function ENT:OnRemove()
	timer.Remove("WeedPlant: " .. self:EntIndex())
end

function ENT:Restart()
	self:SetModel("models/nater/weedplant_pot.mdl")
	self:SetStage(0)
end

function ENT:Use(act, caller)
	if caller:KeyDown(IN_SPEED) and self.angleResetCooldown < CurTime() then
		self:SetAngles(Angle(0,caller:GetAngles().y - 45,0))
		self.angleResetCooldown = CurTime() + 1
		self:GetPhysicsObject():Wake()
	end
	if self:GetStage() == 8 then
		self:Restart()
		self:EmitSound("weapons/physcannon/physcannon_claws_close.wav")
		local weed = ents.Create("weed")
		weed:SetPos(self:GetPos()+Vector(0, 0, 20))
		weed:Spawn()
	end
end

function ENT:Finish()
	self:SetStage(8)
end

CreateConVar( "simpleweed_growtime", 85, FCVAR_SERVER_CAN_EXECUTE )
local simpleweed_growtime = GetConVar( "simpleweed_growtime" )

function ENT:StageOne()
	self:SetStage(1)
	self:SetModel("models/nater/weedplant_pot_planted.mdl")
	timer.Create("WeedPlant: " .. self:EntIndex(), simpleweed_growtime:GetInt(), 0, function()
		if self:GetStage() == 7 then
			timer.Remove("WeedPlant: " .. self:EntIndex())
			self:Finish()
		else
			self:SetModel("models/nater/weedplant_pot_growing"..self:GetStage()..".mdl")
			self:SetStage(self:GetStage() + 1)
			self:EmitSound("physics/rubber/rubber_tire_impact_soft3.wav")
		end
	end)
end

function ENT:Destruct()
    local vPoint = self:GetPos()
    local effectdata = EffectData()
    effectdata:SetStart(vPoint)
    effectdata:SetOrigin(vPoint)
    effectdata:SetScale(1)
    util.Effect("Explosion", effectdata)
end

function ENT:OnTakeDamage(dmg)
    self:TakePhysicsDamage(dmg)
	
    self.HP = self.HP - dmg:GetDamage()
	
    if self.HP <= 0 then
        self:Destruct()
        self:Remove()
    end
end