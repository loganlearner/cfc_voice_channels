local Panel = {}

local function isConnected()
    for _, ply in pairs(cfc_voice.selectedChannel.Users) do
        if LocalPlayer() == ply then
            return true
        end
    end
    return false
end

local function isOwner(ply)
    return cfc_voice.selectedChannel.Owner == ply
end

function Panel:Init()
    self.Main = self:GetParent()

    self.MainPanel = vgui.Create("DPanel", self.Main)
    self.MainPanel:Dock(FILL)
    self.MainPanel:SetBackgroundColor(Color(255, 255, 255, 0))

    self.List = vgui.Create("DListView", self.MainPanel)
    self.List:Dock(FILL)
    self.List:SetMultiSelect(false)
    self.List:SetSortable(false)
    self.List:AddColumn(""):SetWide(1)
    self.List:AddColumn("Player"):SetWide(200)
    self.List:AddColumn("Rank"):SetWide(50)

    for _, ply in pairs(cfc_voice.selectedChannel.Users) do
        self.List:AddLine(isOwner(ply) and "L" or "", ply:Name(), team.GetName(ply:Team()))
    end

    self.SubPanel = vgui.Create("DPanel", self.MainPanel)
    self.SubPanel:Dock(BOTTOM)

    self.BackBut = vgui.Create("DButton", self.SubPanel)
    self.BackBut:Dock(LEFT)
    self.BackBut:SetText("< Back")

    self.BackBut.DoClick = function()
        cfc_voice.selectedChannel = nil
        vgui.Create("channel_list", self:GetParent())
        self :Remove()
    end

    self.Connect = vgui.Create("DButton", self.SubPanel)
    self.Connect:Dock(RIGHT)
    self.Connect:SetText(isConnected() and "Disconnect" or "Connect")
end

vgui.Register("channel_view", Panel)