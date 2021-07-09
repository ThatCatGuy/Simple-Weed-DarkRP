util.AddNetworkString("SimpleWeed.Notify")
local function Notify(ply, msg)
	net.Start("SimpleWeed.Notify")
		net.WriteString(msg)
	net.Send(ply)
end

util.AddNetworkString("SimpleWeed.NPCNotify")
local function NPCNotify(ply, msg)
	net.Start("SimpleWeed.NPCNotify")
		net.WriteString(msg)
	net.Send(ply)
end

CreateConVar( "simpleweed_sellprice", 27000, FCVAR_SERVER_CAN_EXECUTE )
local simpleweed_sellprice = GetConVar( "simpleweed_sellprice" )

function SimpleWeedWantedPlayer(ply, reason, time)
	ply:setDarkRPVar("wanted", true)
	timer.Create(ply:SteamID64() .. " wantedtimer", time, 1, function()
		if not IsValid(ply) then return end
		ply:unWanted()
	end)
end

local Sayings = {
	"Yeah?",
	"You got something for me?",
	"What?",
	"Bring me something and then we can talk...",
	"Im running low on product, bring me some?",
	"Stop wasting my time bruv",
	"Where the green at cuz?!"
}

function SimpleWeedRandomSaying(ply)
	local msg = Sayings[math.random(#Sayings)]
	NPCNotify(ply, msg)
end

function SimpleWeedSold(ply, msg)
	NPCNotify(ply, msg)
end

function SimpleWeedPickUp(ply)
	ply.Weed = (ply.Weed or 0) + 1
	Notify(ply, "You now have " .. ply.Weed .. " ounces of weed.")
end

function SimpleWeedBoxPickUp(ply, qty)
	ply.Weed = (ply.Weed or 0) + qty
	Notify(ply, "You now have " .. ply.Weed .. " ounces of weed.")
end

local function Fail(ply)
	Notify(ply, "You lost all your weed.")
	ply.Weed = 0
end

local function SimpleWeedCheck(ply)
	ply.Weed = (ply.Weed or 0)
	if ply.Weed == 0 then Notify(ply, "You don't have any weed.") return end
	Notify(ply, "You have " .. ply.Weed .. " ounces of weed.")
end

hook.Add( "PlayerSay", "SimpleWeedCheck", function( ply, text  )
    if  ( string.lower( text ) == "/weed" or string.lower( text ) == "!weed" ) then
	     SimpleWeedCheck(ply)
	    return ""
	end
end)

hook.Add("PlayerDeath", "SimpleWeedWeed.PlayerDeath", function(victim, inflictor, attacker)
	if victim.Weed and victim.Weed > 0 then
		if attacker:isCP() then
			local reward = (victim.Weed * simpleweed_sellprice:GetInt()) * 0.5
			attacker:addMoney(reward)
			Notify(attacker, "You just killed a weed dealer and got " .. DarkRP.formatMoney(reward) .. ".")
		else
			local reward = math.floor(victim.Weed / 4)
			if reward > 0 then
				attacker.Weed = (attacker.Weed or 0) + reward
				Notify(attacker, "You just killed a weed dealer and got " .. reward .. " ounces of weed.")
			end
		end
		Fail(victim)
	end
end)

hook.Add("playerArrested", "SimpleWeed.RewardCP", function(criminal, time, actor)
	if criminal.Weed and criminal.Weed > 0 then
		local reward = (criminal.Weed * simpleweed_sellprice:GetInt()) * 0.5
		Fail(criminal)		
		actor:addMoney(reward)
		Notify(actor, "You just arrested a weed dealer and got " .. DarkRP.formatMoney(reward) .. "!")
	end
end)

// NPC Spawn Functions
local map = string.lower( game.GetMap() )
//##### Spawn the NPC ##############################################################
local function SimpleWeedNPCSpawn(ply)
    if ply:IsSuperAdmin() then
    	local tr = ply:GetEyeTrace()
        local spawnBuyer = ents.Create( "weed_npc" )
        if ( !IsValid( spawnBuyer ) ) then return end
        spawnBuyer:SetPos( tr.HitPos + Vector( 0, 0, 10 ) )
        spawnBuyer:SetAngles(Angle(0,ply:GetAngles().y - 180,0))
        spawnBuyer:Spawn()
        NPCNotify(ply, "NPC Spawned for map " .. map)
    end    
end
concommand.Add("simpleweed_spawnnpc", SimpleWeedNPCSpawn)

//##### Save the NPC ##############################################################
local function SimpleWeedNPCSave(ply)
    if ply:IsSuperAdmin() then   
        local buyer = {}
        for k,v in pairs( ents.FindByClass("weed_npc") ) do
            buyer[k] = { type = v:GetClass(), pos = v:GetPos(), ang = v:GetAngles() }
        end	
        local convert_data = util.TableToJSON( buyer )		
        file.Write( "simpleweed/weedbuyer_" .. map .. ".txt", convert_data )
        NPCNotify(ply, "NPC Locations Saved for map " .. map)  
    end
end
concommand.Add("simpleweed_savenpcs", SimpleWeedNPCSave)
 
//##### Delete the NPC ##############################################################
local function SimpleWeedNPCDelete(ply)
    if ply:IsSuperAdmin() then
        file.Delete( "simpleweed/weedbuyer_" .. map .. ".txt" )
        NPCNotify(ply, "NPC Locations Deleted from map " .. map)
    end    
end
concommand.Add("simpleweed_removenpcs", SimpleWeedNPCDelete)

//##### Load the NPCs ##############################################################
local function SimpleWeedNPCLoad(ply)
	if ply:IsSuperAdmin() then
		if not file.IsDir( "simpleweed", "DATA" ) then
        	file.CreateDir( "simpleweed", "DATA" )
    	end
		if not file.Exists("simpleweed/weedbuyer_" .. map .. ".txt","DATA") then return end
		for k,v in pairs( ents.FindByClass("weed_npc") ) do
            v:Remove()
        end	
		local ImportData = util.JSONToTable(file.Read("simpleweed/weedbuyer_" .. map .. ".txt","DATA"))
	    	for k, v in pairs(ImportData) do
	        local npc = ents.Create( v.type )
	        npc:SetPos( v.pos )
	        npc:SetAngles( v.ang )
	        npc:Spawn()
		end
	end
end
concommand.Add("simpleweed_respawnnpcs", SimpleWeedNPCLoad)

//##### Autospawn the NPCs ##############################################################
local function SimpleWeedNPCInit()
    if not file.IsDir( "simpleweed", "DATA" ) then
        file.CreateDir( "simpleweed", "DATA" )
    end
	if not file.Exists("simpleweed/weedbuyer_" .. map .. ".txt","DATA") then return end
	local ImportData = util.JSONToTable(file.Read("simpleweed/weedbuyer_" .. map .. ".txt","DATA"))
    	for k, v in pairs(ImportData) do
        local npc = ents.Create( v.type )
        npc:SetPos( v.pos )
        npc:SetAngles( v.ang )
        npc:Spawn()
	end
end
hook.Add( "InitPostEntity", "SimpleWeedNPCInit", SimpleWeedNPCInit )