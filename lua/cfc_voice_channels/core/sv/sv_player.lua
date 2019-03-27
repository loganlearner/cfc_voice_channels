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

hook.Add("PlayerDisconnected", "cfc_voice_on_disconnect", function(ply)
    if not ply:isInChannel() then return end

    local channel = ply:getConnectedChannel()
    cfc_voice:leaveChannel(ply, channel)
end)