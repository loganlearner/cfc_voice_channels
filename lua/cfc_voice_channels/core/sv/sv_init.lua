util.AddNetworkString("gimmeChannelsPls")
util.AddNetworkString("okiHereYouGo")
util.AddNetworkString("iWannaMakeAChannel")
util.AddNetworkString("iWannaJoinPls")

cfc_voice.Channels = {}

include("cfc_voice_channels/core/sv/sv_channel_control.lua")
include("cfc_voice_channels/core/sv/sv_player.lua")

function cfc_voice:InitializeVoiceChannels()
    MsgN("Initializing cfcVoiceChannels")
end

hook.Add("Initialize", "initialize_cfc_voice_channels", cfc_voice:InitializeVoiceChannels())