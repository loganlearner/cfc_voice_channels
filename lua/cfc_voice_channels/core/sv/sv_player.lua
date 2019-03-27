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