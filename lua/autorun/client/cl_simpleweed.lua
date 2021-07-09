local function Notify(msg)
	chat.AddText(Color(60, 189, 60), "Weed | ", Color(240, 240, 240), msg)
end

local function NPCNotify(msg)
	chat.AddText(Color(60, 189, 60), "Weed Buyer | ", Color(240, 240, 240), msg)
end

net.Receive("SimpleWeed.Notify", function()
	Notify(net.ReadString())
end)

net.Receive("SimpleWeed.NPCNotify", function()
	NPCNotify(net.ReadString())
end)