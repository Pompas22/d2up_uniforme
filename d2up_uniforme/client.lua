local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

vSERVER = Tunnel.getInterface(GetCurrentResourceName())
vCLIENT = {}
Tunnel.bindInterface(GetCurrentResourceName(),vCLIENT)


function vCLIENT.closeMenu()
	SetNuiFocus(false)
	TransitionFromBlurred(1000)
	SendNUIMessage({ hidemenu = true })
end


RegisterNUICallback('fechar',function (data)
	vCLIENT.closeMenu()
end)

RegisterNUICallback('tirar',function (data)
	vSERVER.TirarRoupa()
end)

RegisterNUICallback('vestir',function (data)
	local ped = PlayerPedId()
	local sex = GetEntityModel(ped)
	local roupas = vRP.getCustomization()
	vSERVER.setroupa(cfg.uniformes[data.tipo].presets[sex][tonumber(data.index + 1)].clothe,sex,roupas)
end)

-----------------------------------------------------------------------------------------------------------------------------------------
--[ MENU ]-------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	SetNuiFocus(false,false)
	while true do
		local timedistance = 1000

		for k,v in pairs(cfg.coords) do
			local ped = PlayerPedId()
			local pedcds = GetEntityCoords(ped)
			local distance = #(pedcds - v.coords)
			
			if distance <= 5 then
				timedistance = 1
				DrawMarker(27, v.coords.x, v.coords.y, v.coords.z-0.99, 0, 0, 0, 0, 0, 0, 0.7, 0.7, 0.5, 255, 255, 255, 150, 0, 1, 0, 1)								
				if distance <= 1.2 then
					if IsControlJustPressed(0,38)then
					   	if vSERVER.checkPermission(cfg.uniformes[v.type].perm) then
							local sex = GetEntityModel(ped)
							SetNuiFocus(true,true)
							TransitionToBlurred(1000)
							SendNUIMessage({ showmenu = true,clothes = cfg.uniformes[v.type].presets[sex],qtd = #cfg.uniformes[v.type].presets[sex],tipo = v.type,clothename = cfg.uniformes[v.type].nameVestiario })
						end
					end
				end
		  	end
		end
		Citizen.Wait(timedistance)
	end
end)
