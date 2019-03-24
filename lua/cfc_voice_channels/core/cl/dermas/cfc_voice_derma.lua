local Panel = {}

function Panel:Init()
    self.Main = vgui.Create("DFrame", Panel)
    self.Main:SetSize(300, 500)
    self.Main:SetTitle("Voice Channels")
    self.Main:Center()
    self.Main:MakePopup()

    vgui.Create("channel_list", self.Main)
end

vgui.Register("cfc_voice_main_derma", Panel)