local QBCore = exports['qb-core']:GetCoreObject()
cooldown = 0
ispriority = false
ishold = false
-- Code

QBCore.Functions.CreateCallback('qb-scoreboard:server:GetActivity', function(source, cb)
    local PoliceCount = 0
    local AmbulanceCount = 0
    local RestCount = 0
    local Police2Count = 0
    local lawyer2Count = 0
    local taxt2Count = 0
    local realestate2Count = 0
    local judge2Count = 0

    local sui = 'rounded'

    for k, v in pairs(QBCore.Functions.GetPlayers()) do
        local Player = QBCore.Functions.GetPlayer(v)
        if Player ~= nil then
            if (Player.PlayerData.job.name == "police") and Player.PlayerData.job.onduty then
                PoliceCount = PoliceCount + 1
            end

            if (Player.PlayerData.job.name == "rest") and Player.PlayerData.job.onduty then
                RestCount = RestCount + 1
            end

            if (Player.PlayerData.job.name == "tuner") and Player.PlayerData.job.onduty then
                Police2Count = Police2Count + 1
            end

            if (Player.PlayerData.job.name == "lawyer") and Player.PlayerData.job.onduty then
                lawyer2Count = lawyer2Count + 1
            end

            if (Player.PlayerData.job.name == "taxi") and Player.PlayerData.job.onduty then
                taxt2Count = taxt2Count + 1
            end

            if (Player.PlayerData.job.name == "realestate") and Player.PlayerData.job.onduty then
                realestate2Count = realestate2Count + 1
            end

            if (Player.PlayerData.job.name == "judge") and Player.PlayerData.job.onduty then
                judge2Count = judge2Count + 1
            end

            if (Player.PlayerData.job.name == "ambulance" or Player.PlayerData.job.name == "doctor") and Player.PlayerData.job.onduty then
                AmbulanceCount = AmbulanceCount + 1
            end
            sui = Player.PlayerData.metadata['scoreboardtheme']
        end
    end

    cb(PoliceCount, AmbulanceCount, RestCount, sui)
end)

QBCore.Functions.CreateCallback('qb-scoreboard:server:GetConfig', function(source, cb)
    cb(Config.IllegalActions)
end)

QBCore.Functions.CreateCallback('qb-scoreboard:server:GetPlayersArrays', function(source, cb)
    local players = {}
    for k, v in pairs(QBCore.Functions.GetPlayers()) do
        local Player = QBCore.Functions.GetPlayer(v)
        if Player ~= nil then
            players[Player.PlayerData.source] = {}
            players[Player.PlayerData.source].permission = QBCore.Functions.IsOptin(Player.PlayerData.source)
        end
    end
    cb(players)
end)

RegisterServerEvent('qb-scoreboard:server:SetActivityBusy')
AddEventHandler('qb-scoreboard:server:SetActivityBusy', function(activity, bool)
    Config.IllegalActions[activity].busy = bool
    TriggerClientEvent('qb-scoreboard:client:SetActivityBusy', -1, activity, bool)
end)


QBCore.Commands.Add('homeui', 'Change ScoreBoard Ui', {}, false, function(source, args)
    local Player = QBCore.Functions.GetPlayer(source)

    if Player.PlayerData.metadata['scoreboardtheme'] == 'rounded' then

        Player.Functions.SetMetaData('scoreboardtheme', 'square')

    else
        Player.Functions.SetMetaData('scoreboardtheme', 'rounded')
    end

end)