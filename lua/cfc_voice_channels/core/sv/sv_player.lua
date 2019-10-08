local player = FindMetaTable( "Player" )

function player:isInChannel()
    for _, channel in pairs( cfc_voice.Channels ) do
        for _, ply in pairs( channel.Users ) do
            if self == ply then
                return true
            end
        end
    end

    return false
end

function player:getConnectedChannel()
    for _, channel in pairs( cfc_voice.Channels ) do
        for _, ply in pairs( channel.Users ) do
            if self == ply then
                return channel
            end
        end
    end
end

function player:isPrioritySpeaker()

end

hook.Remove( "PlayerDisconnected", "CFC_Voice_onDisconnect" )
hook.Add( "PlayerDisconnected", "CFC_Voice_onDisconnect", function( ply )
    if not ply:isInChannel() then return end

    local channel = ply:getConnectedChannel()
    cfc_voice:leaveChannel( ply, channel )
end )

hook.Remove( "PlayerCanHearPlayersVoice", "CFC_Voice_PlayerCanHearPlayer" )
hook.Add( "PlayerCanHearPlayersVoice", "CFC_Voice_PlayerCanHearPlayer", function( listener, talker )
    if not ( IsValid( listener ) and listener:IsPlayer() ) then return end
    if not ( IsValid( talker ) and talker:IsPlayer() ) then return end

    return cfc_voice:isInSameCFCVoiceChannel( listener, talker ) -- or talker:isPrioritySpeaker()
end )