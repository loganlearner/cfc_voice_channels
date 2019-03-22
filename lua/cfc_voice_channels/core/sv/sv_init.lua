
cfc_voice.Channels = {}

function cfc_voice:InitializeVoiceChannels()
    MsgN("Initializing cfcVoiceChannels")
end

hook.Add("Initialize", "initialize_cfc_voice_channels", cfc_voice:InitializeVoiceChannels())