local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

vCLIENT = Tunnel.getInterface(GetCurrentResourceName())

vSERVER = {}
Tunnel.bindInterface(GetCurrentResourceName(),vSERVER)

local idle_copy = {}
local idle_custom = {}

function vSERVER.checkPermission(perm)
	local source = source
	local user_id = vRP.getUserId(source)
	if not perm then return true end
	if type(perm) == "table" then
		for _,dataPerm in pairs(perm) do
			if vRP.hasPermission(user_id,dataPerm) then
				return true
			end
		end
		return false
	end
	return vRP.hasPermission(user_id,perm)
end

function vSERVER.TirarRoupa()
	local source = source
	local user_id = vRP.getUserId(source)
	vCLIENT.closeMenu(source)
	TriggerClientEvent("progress",source,2000,"vestindo")
	TriggerClientEvent('cancelando',source,true)
	vRPclient._playAnim(source,false,{{"clothingshirt","try_shirt_positive_d"}},true)
	SetTimeout(2000,function()
		TriggerClientEvent('cancelando',source,false)
		vRPclient._stopAnim(source,false)
		vRPclient._setCustomization(source,idle_custom[user_id])
	end)
end

function vSERVER.setroupa(table,model,roupas)
	local source = source
	local user_id = vRP.getUserId(source)
	idle_custom[user_id] = roupas
	TriggerClientEvent("progress",source,6000,"vestindo")
	vCLIENT.closeMenu(source)
	TriggerClientEvent('cancelando',source,true)
	vRPclient._playAnim(source,false,{{"clothingshirt","try_shirt_positive_d"}},true)
	SetTimeout(6000,function()
		vRPclient._stopAnim(source,false)
		TriggerClientEvent('cancelando',source,false)
		idle_copy[model] = table
		for l,w in pairs(idle_copy[model]) do
			idle_copy[l] = w
		end
		
		vRPclient._setCustomization(source,idle_copy[model])
		idle_copy = {}
	end)

end
