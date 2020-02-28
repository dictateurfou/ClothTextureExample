local textureLoad = {}

function loadTexture(textureList)
    for k,v in pairs(textureList) do
        textureLoad[v] = UTexture2D.LoadFromFile(v)
    end
end
AddRemoteEvent("LoadTextures", loadTexture)

function OnPackageStart()
	local pakname = "Materials2"
	local res = LoadPak("Materials2", "/Materials2/", "../../../OnsetModding/Plugins/Materials2/Content/")
end
AddEvent("OnPackageStart", OnPackageStart)

AddRemoteEvent("texturetest:setPart", function(part,clothInfo,model)
    local SkeletalMeshComponent = GetPlayerSkeletalMeshComponent(GetPlayerId(), "Body")
    SkeletalMeshComponent:SetSkeletalMesh(USkeletalMesh.LoadFromAsset(model))
    if part == "shirt" then
        SkeletalMeshComponent = GetPlayerSkeletalMeshComponent(GetPlayerId(), "Clothing1")
        --load model
        SkeletalMeshComponent:SetSkeletalMesh(USkeletalMesh.LoadFromAsset(clothInfo.model))

    elseif part == "pants" then
        SkeletalMeshComponent = GetPlayerSkeletalMeshComponent(GetPlayerId(), "Clothing4")
        SkeletalMeshComponent:SetSkeletalMesh(USkeletalMesh.LoadFromAsset(clothInfo.model))
    end


     --add texture
     if clothInfo.type == "texture" then
        --SET the materials
        
        if clothInfo.materials ~= nil then
            SkeletalMeshComponent:SetMaterial(0, UMaterialInterface.LoadFromAsset(clothInfo.materials))
        elseif clothInfo.normal ~= nil then
            SkeletalMeshComponent:SetMaterial(0, UMaterialInterface.LoadFromAsset("/Materials2/MI_ClothMaterialsWithNormal"))
        else
            SkeletalMeshComponent:SetMaterial(0, UMaterialInterface.LoadFromAsset("/Materials2/MI_ClothMaterials"))
        end
        --create dynamic instance of material instance
        local DynamicMaterialInstance = SkeletalMeshComponent:CreateDynamicMaterialInstance(0)
        DynamicMaterialInstance:SetTextureParameter("BaseColorTexture", textureLoad[clothInfo.texture])

        if clothInfo.roughness ~= nil then
            DynamicMaterialInstance:SetFloatParameter("Roughness", 0.75)
        end
        
        --SET panner if defined
        if clothInfo.panner ~= nil then
            DynamicMaterialInstance:SetColorParameter("Panner", FLinearColor(clothInfo.panner.x,clothInfo.panner.y,0.0,0.0))
        end
        --Set normal map if defined
        if clothInfo.normal ~= nil then
            DynamicMaterialInstance:SetTextureParameter("NormalMap", textureLoad[clothInfo.normal])
        end
    end
end)

AddRemoteEvent("texturetest:vehicleStyle", function(vehicleId,style,materialSlot)
    local SkeletalMeshComponent = GetVehicleSkeletalMeshComponent(vehicleId)
     --add texture
     if style.type == "texture" then
        --SET the materials
        
        if style.materials ~= nil then
            SkeletalMeshComponent:SetMaterial(materialSlot, UMaterialInterface.LoadFromAsset(style.materials))
        elseif style.normal ~= nil then
            SkeletalMeshComponent:SetMaterial(materialSlot, UMaterialInterface.LoadFromAsset("/Materials2/MI_ClothMaterialsWithNormal"))
        else
            SkeletalMeshComponent:SetMaterial(materialSlot, UMaterialInterface.LoadFromAsset("/Materials2/MI_ClothMaterials"))
        end
        --create dynamic instance of material instance
        local DynamicMaterialInstance = SkeletalMeshComponent:CreateDynamicMaterialInstance(materialSlot)
        DynamicMaterialInstance:SetTextureParameter("BaseColorTexture", textureLoad[style.texture])

        if style.roughness ~= nil then
            DynamicMaterialInstance:SetFloatParameter("Roughness", 0.75)
        end
        
        --SET panner if defined
        if style.panner ~= nil then
            DynamicMaterialInstance:SetColorParameter("Panner", FLinearColor(style.panner.x,style.panner.y,0.0,0.0))
        end
        --Set normal map if defined
        if style.normal ~= nil then
            DynamicMaterialInstance:SetTextureParameter("NormalMap", textureLoad[style.normal])
        end
    end

end)