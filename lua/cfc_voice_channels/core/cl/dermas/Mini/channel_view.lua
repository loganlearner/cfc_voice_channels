local Panel = {}

local function isConnected()
    for _, ply in pairs( cfc_voice.selectedChannel.Users ) do
        if LocalPlayer() == ply then
            return true
        end
    end
    return false
end

local function isOwner( ply )
    return cfc_voice.selectedChannel.Owner == ply
end

local function isMuted(ply)
    if table.HasValue(cfc_voice.selectedChannel.Muted, ply) then return true end

    return false
end

function Panel:Init()
    self.Main = self:GetParent()

    self.MainPanel = vgui.Create( "DPanel", self.Main )
    self.MainPanel:Dock( FILL )
    self.MainPanel:SetBackgroundColor( Color( 255, 255, 255, 0 ) )

    self.List = vgui.Create( "DListView", self.MainPanel )
    self.List:Dock( FILL )
    self.List:SetMultiSelect( false )
    self.List:SetSortable( false )
    self.List:AddColumn( "" ):SetWide( 1 )
    self.List:AddColumn( "Player" ):SetWide( 200 )
    self.List:AddColumn( "Rank" ):SetWide( 50 )

    self.List.OnRowRightClick = function( panel, index, row )
        local menu = DermaMenu()
        menu:SetPos( gui.MouseX(), gui.MouseY() )

        if isOwner( LocalPlayer() ) or LocalPlayer():isAdmin() then
            if not isMuted( cfc_voice.selectedChannel.Users[index] ) then
                menu:AddOption( "Mute", function()  end ):SetIcon( "icon16/sound_delete.png" )
            else
                menu:AddOption( "Unmute", function() end ):SetIcon( "icon16/sound.png" )
            end

            menu:AddOption( "Kick", function() end ):SetIcon( "icon16/user_gray.png" )
            menu:AddOption( "Ban", function() end ):SetIcon( "icon16/user_delete.png" )
            menu:AddOption( "Promote To Leader", function() end ):SetIcon( "icon16/award_star_gold_1.png" )
        end

        menu:AddOption( "Close" ):SetIcon( "icon16/cross.png" )
        menu:Open()
    end

    for _, ply in pairs( cfc_voice.selectedChannel.Users ) do
        self.List:AddLine( isOwner( ply ) and "L" or "", ply:Name(), team.GetName( ply:Team() ) )
    end

    self.SubPanel = vgui.Create( "DPanel", self.MainPanel )
    self.SubPanel:Dock( BOTTOM )

    self.BackBut = vgui.Create( "DButton", self.SubPanel )
    self.BackBut:Dock( LEFT )
    self.BackBut:SetText( "< Back" )

    self.BackBut.DoClick = function()
        cfc_voice.selectedChannel = nil
        vgui.Create( "channel_list", self:GetParent() )
        self :Remove()
    end

    self.Connect = vgui.Create( "DButton", self.SubPanel )
    self.Connect:Dock( RIGHT )
    self.Connect:SetText( isConnected() and "Disconnect" or "Connect" )
end

vgui.Register( "channel_view", Panel )
