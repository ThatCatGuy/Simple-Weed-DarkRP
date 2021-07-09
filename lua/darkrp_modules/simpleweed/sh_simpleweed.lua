hook.Add("loadCustomDarkRPItems", "SimpleWeed_Initialize", function()

DarkRP.createCategory{
    name = "Simple Weed", -- The name of the category.
    categorises = "entities", -- What it categorises. MUST be one of "jobs", "entities", "shipments", "weapons", "vehicles", "ammo".
    startExpanded = true, -- Whether the category is expanded when you open the F4 menu.
    color = Color(0, 107, 0, 255), -- The color of the category header.
    canSee = function(ply) return true end, -- OPTIONAL: whether the player can see this category AND EVERYTHING IN IT.
    sortOrder = 100, -- OPTIONAL: With this you can decide where your category is. Low numbers to put it on top, high numbers to put it on the bottom. It's 100 by default.
}

local allowedWeed = {TEAM_GANG}

DarkRP.createEntity("Weed Pot", {
  ent = "weed_plant",
  model = "models/nater/weedplant_pot.mdl",
  price = 12000,
  max = 2,
  category = "Simple Weed",
  cmd = "buyplantpot",
  allowed = allowedWeed
})

DarkRP.createEntity("Weed Box", {
  ent = "weed_box",
  model = "models/props_junk/PlasticCrate01a.mdl",
  price = 2000,
  max = 1,
  category = "Simple Weed",
  cmd = "buyweedbox",
  allowed = allowedWeed
})

DarkRP.createEntity("Weed Seeds", {
  ent = "weed_seed",
  model = "models/props_junk/garbage_bag001a.mdl",
  price = 6000,
  max = 2,
  category = "Simple Weed",
  cmd = "buyseeds",
  allowed = allowedWeed
})
end)