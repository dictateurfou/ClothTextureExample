--save Data
local players = {}

local textures = {
    "texturetest/textures/police1.png",
    "texturetest/textures/jacket_lacoste_gold.png",
    "texturetest/textures/NormalMap.png",
    "texturetest/textures/universe.jpg",
    "texturetest/textures/lv.jpg"
}

local clothes = {
    shirt = {
        {["type"] = "texture", ["texture"] = "texturetest/textures/jacket_lacoste_gold.png", ["model"] = "/Game/CharacterModels/SkeletalMesh/Outfits/HZN_Outfit_Piece_Shirt_LPR"},
        {
            ["type"] = "texture", 
            ["texture"] = "texturetest/textures/universe.jpg",
            ["model"] = "/Game/CharacterModels/SkeletalMesh/Outfits/HZN_Outfit_Piece_Shirt_LPR",
            ["materials"] = "/Materials2/MI_AnimatedTexture",--materials instance
            ["panner"] = {x=0.2,y=0.0}
        }
    },

    pants = {
        {
            ["type"] = "texture", 
            ["texture"] = "texturetest/textures/lv.jpg",
            ["model"] = "/Game/CharacterModels/SkeletalMesh/Outfits/HZN_Outfit_Piece_DenimPants_LPR",
            ["materials"] = "/Materials2/MI_AnimatedTexture",--materials instance
            ["panner"] = {x=0.2,y=0.1},
            ["roughness"] = 0.0
        }
    }
}

AddEvent("OnPlayerSteamAuth", function(player)
    players[player] = {
        model = "/Game/CharacterModels/SkeletalMesh/BodyMerged/HZN_CH3D_Normal02_LPR",
        shirt = {["type"] = "texture", ["texture"] = "texturetest/textures/police1.png", ["model"] = "/Game/CharacterModels/SkeletalMesh/Outfits/HZN_Outfit_Piece_Shirt_LPR"},
    }
    CallRemoteEvent(player,"LoadTextures",textures)
end)

AddCommand("cloth",function(player,part,id)
    id = tonumber(id)
    if clothes[part][id] ~= nil then
        players[player][part] = clothes[part][id]
        CallRemoteEvent(player,"texturetest:setPart",part,clothes[part][id],players[player].model)
    end
end)

AddEvent ( "OnPlayerJoin" ,  function(player) 
	SetPlayerSpawnLocation ( player ,  125773.000000 ,  80246.000000 ,  1645.000000 ,  90.0 )
end)