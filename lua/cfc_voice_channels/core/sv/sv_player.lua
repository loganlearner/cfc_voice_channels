local player = FindMetaTable("Player")

function player:isInChannel()
    for _, channel in pairs(cfc_voice.Channels) do
        for _, ply in pairs(channel.Users) do
            if self == ply then
                return true
            end
        end
    end

    return false
end

function player:getConnectedChannel()
    for _, channel in pairs(cfc_voice.Channels) do
        for _, ply in pairs(channel.Users) do
            if self == ply then
                return channel
            end
        end
    end
end

function player:isInSameChannel(ply)
    if self:isInChannel() and ply:isInChannel() then
        local listenerChannel = self:getConnectedChannel()
        local talkerChannel = self:getConnectedChannel()

        if listenerChannel == talkerChannel then 
            return true
        end

        return false
    end

    return true
end

function player:isPrioritySpeaker()

end

hook.Add("PlayerDisconnected", "cfc_voice_on_disconnect", function(ply)
    if not ply:isInChannel() then return end

    local channel = ply:getConnectedChannel()
    cfc_voice:leaveChannel(ply, channel)
end)

hook.Add("PlayerCanHearPlayersVoice", "cfc_voice_can_hear", function(listener, talker)
    return listener:isInSameChannel() or talker:isPrioritySpeaker()
end)