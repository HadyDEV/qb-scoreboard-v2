local QBCore = exports['qb-core']:GetCoreObject()

RegisterFontFile('out')
fontId = RegisterFontId('Arb')

local segundos = 0
local minutos = 0
local horas = 0
local dias = 0
local timechecked = true

function DrawText2(text, x, y)
    SetTextFont(fontId)
    SetTextProportional(1)
    SetTextScale(0.0, 0.30)
    SetTextDropshadow(1, 0, 0, 0, 255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x+0.80, y+0.967)
end

-- Code

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    isLoggedIn = true

    QBCore.Functions.TriggerCallback('qb-scoreboard:server:GetConfig', function(config)
        Config.IllegalActions = config
    end)
end)

local scoreboardOpen = false

local PlayerOptin = {}

DrawText3D = function(x, y, z, text)
    SetTextScale(0.85, 0.85)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255,255,255, 255)
    SetTextDropshadow(0, 0, 0, 0, 255)
    SetTextEdge(2, 0, 0, 0, 150)
    
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    ClearDrawOrigin()
end

GetClosestPlayer = function()
    local closestPlayers = QBCore.Functions.GetPlayersFromCoords()
    local closestDistance = -1
    local closestPlayer = -1
    local coords = GetEntityCoords(GetPlayerPed(-1))

    for i=1, #closestPlayers, 1 do
        if closestPlayers[i] ~= PlayerId() then
            local pos = GetEntityCoords(GetPlayerPed(closestPlayers[i]))
            local distance = GetDistanceBetweenCoords(pos.x, pos.y, pos.z, coords.x, coords.y, coords.z, true)

            if closestDistance == -1 or closestDistance > distance then
                closestPlayer = closestPlayers[i]
                closestDistance = distance
            end
        end
	end

	return closestPlayer, closestDistance
end

GetPlayers = function()
    local players = {}
    for _, player in ipairs(GetActivePlayers()) do
        local ped = GetPlayerPed(player)
        if DoesEntityExist(ped) then
            table.insert(players, player)
        end
    end
    return players
end

GetPlayersFromCoords = function(coords, distance)
    local players = GetPlayers()
    local closePlayers = {}

    if coords == nil then
		coords = GetEntityCoords(GetPlayerPed(-1))
    end
    if distance == nil then
        distance = 5.0
    end
    for _, player in pairs(players) do
		local target = GetPlayerPed(player)
		local targetCoords = GetEntityCoords(target)
		local targetdistance = GetDistanceBetweenCoords(targetCoords, coords.x, coords.y, coords.z, true)
		if targetdistance <= distance then
			table.insert(closePlayers, player)
		end
    end
    
    return closePlayers
end

local deadAnimDict = "dead"
local deadAnim = "dead_a"
local deadCarAnimDict = "veh@low@front_ps@idle_duck"
local deadCarAnim = "sit"
local dict = "missheistdockssetup1clipboard@base"


Citizen.CreateThread(function()
    while true do
        if scoreboardOpen then
            for _, player in pairs(GetPlayersFromCoords(GetEntityCoords(GetPlayerPed(-1)), 8.0)) do
                local PlayerId = GetPlayerServerId(player)
                local PlayerPed = GetPlayerPed(player)
                local PlayerName = GetPlayerName(player)
                local PlayerCoords = GetEntityCoords(PlayerPed)
				if not IsEntityVisible(GetPlayerPed(player)) and not IsEntityPlayingAnim(GetPlayerPed(player), 'timetable@floyd@cryingonbed@base', 'base', 3) then
				
				else
					DrawText3D(PlayerCoords.x, PlayerCoords.y, PlayerCoords.z + 1.1, ''..PlayerId..'')
				end
            end
        end

        Citizen.Wait(3)
    end
end)



Citizen.CreateThread(function()
    RegisterKeyMapping("+homebutton","Toggle Scoreboard", "keyboard", "HOME")
    RegisterCommand('+homebutton', ScoreboardShow, false)
    RegisterCommand('-homebutton',  function() end, false)
end)

function ScoreboardShow()
	if not scoreboardOpen  then
        QBCore.Functions.TriggerCallback('qb-scoreboard:server:GetPlayersArrays', function(playerList)
            QBCore.Functions.TriggerCallback('qb-scoreboard:server:GetActivity', function(cops, ambulance, rests, theme)
                PlayerOptin = playerList
                Config.CurrentCops = cops
                SendNUIMessage({
                    action = "open",
                    players = GetCurrentPlayers(),
                    maxPlayers = Config.MaxPlayers,
                    requiredCops = Config.IllegalActions,
                    currentCops = Config.CurrentCops,
                    currentAmbulance = ambulance,
                    currentrests = rests,
                    timehour = horas,
                    timemenu = minutos,
                    theme = theme
                })
                scoreboardOpen = true
            end)
        end)
		Citizen.Wait(250)
	else
        if clipboardEntity ~= nil then
            DeleteEntity(clipboardEntity)
            clipboardEntity = nil
        end
        if scoreboardOpen then
            SendNUIMessage({
                action = "close",
            })
            scoreboardOpen = false
        end
    end
end


function GetCurrentPlayers()
    local TotalPlayers = 0

    for _, player in ipairs(GetActivePlayers()) do
        TotalPlayers = TotalPlayers + 1
    end

    return TotalPlayers
end

local Totalm = 0
local Totalh = 0
local Totalt = 0

Citizen.CreateThread(function()
  
    while true do
       
        Citizen.Wait(60000)
        -- Citizen.Wait(100)

        if Totalm < 61 then 
            Totalm = Totalm + 1
        else 
            Totalm = 0 
            Totalh = Totalh + 1
        end 
              
    end 
end)


RegisterNetEvent('qb-scoreboard:client:SetActivityBusy')
AddEventHandler('qb-scoreboard:client:SetActivityBusy', function(activity, busy)
    Config.IllegalActions[activity].busy = busy
end)


RegisterCommand("home", function()
    SendNUIMessage({
        action = "close",
    })
    scoreboardOpen = false
end,false)

CreateThread(function()
    Wait(1000)
    local actions = {}
    for k, v in pairs(Config.IllegalActions) do
        actions[k] = v.label
    end
    SendNUIMessage({
        action = "setup",
        items = actions
    })
end)
