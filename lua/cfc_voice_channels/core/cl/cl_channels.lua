function cfc_voice:FetchChannels()
    net.Start("gimmeChannelsPls")
    net.SendToServer()
end