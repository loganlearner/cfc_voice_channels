local Panel = {}

local function isConnected()
    for _, ply in pairs(selectedChannel.Users) do
        if LocalPlayer() == ply then
            return true
        end
    end
    return false
end

local function isOwner(ply)
    return selectedChannel.Owner == ply
end

function Panel:Init()
    self.Main = self:GetParent()

    self.MainPanel = vgui.Create("DPanel", self.Main)
    self.MainPanel:Dock(FILL)

    self.List = vgui.Create("DListView", self.MainPanel)
    self.List:Dock(FILL)
    self.List:SetMultiSelect(false)
    self.List:SetSortable(false)
    self.List:AddColumn("")
    self.List:AddColumn("Player")

    for _, ply in pairs(selectedChannel.Users) do
        self.List:AddLine(isOwner(ply) and "L" or "", ply:Name())
    end

    self.Connect = vgui.Create("DButton", self.MainPanel)
    self.Connect:Dock(BOTTOM)
    self.Connect:SetText(isConnected() and "Disconnect" or "Connect")
end

vgui.Register("channel_view", Panel)