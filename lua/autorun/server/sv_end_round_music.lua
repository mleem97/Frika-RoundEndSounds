if ( SERVER ) then

    -- Retrieve all sound files for the respective round outcomes
    local traitors = file.Find( "sound/round/traitors/*", "GAME" )
    local innocents = file.Find( "sound/round/innocents/*", "GAME" )
    local timelimit = file.Find( "sound/round/timelimit/*", "GAME" )
    local teams = file.Find( "sound/round/teams/*", "GAME" )
    local extensions = { ".mp3" } -- File extensions to strip from names

    -- Setup network strings for communication
    util.AddNetworkString( "ttt_end_round_music_name" )
    util.AddNetworkString( "ttt_end_round_music_path" )

    -- Ensure sound files are available for clients to download
    for k, v in ipairs( traitors ) do resource.AddFile( "sound/round/traitors/" .. v ) end
    for k, v in ipairs( innocents ) do resource.AddFile( "sound/round/innocents/" .. v ) end
    for k, v in ipairs( timelimit ) do resource.AddFile( "sound/round/timelimit/" .. v ) end
    for k, v in ipairs( teams ) do resource.AddFile( "sound/round/teams/" .. v ) end

    -- Handle round end events to select and broadcast music
    local function endofround( wintype )
        local path = ""
        local name = ""

        -- Select the music path and name based on win type
        if wintype == WIN_INNOCENT then
            path = "round/innocents/" .. innocents[ math.random( #innocents ) ]
            name = string.gsub(path, "round/innocents/", "")
        elseif wintype == TEAM_INNOCENT then
            path = "round/innocents/" .. innocents[ math.random( #innocents ) ]
            name = string.gsub(path, "round/innocents/", "")
        elseif wintype == WIN_TRAITOR then
            path = "round/traitors/" .. traitors[ math.random( #traitors ) ]
            name = string.gsub(path, "round/traitors/", "")
        elseif wintype == TEAM_TRAITOR then
            path = "round/traitors/" .. traitors[ math.random( #traitors ) ]
            name = string.gsub(path, "round/traitors/", "")
        elseif wintype == WIN_TIMELIMIT then
            path = "round/timelimit/" .. timelimit[ math.random( #timelimit ) ]
            name = string.gsub(path, "round/timelimit", "")
        elseif wintype == TEAM_JESTER or TEAM_RESTLESS or TEAM_CULTIST or TEAM_INFECTED or TEAM_NECROMANCER or TEAM_NONE then
            path = "round/teams/" .. teams[ math.random( #teams ) ]
            name = string.gsub(path, "round/teams/", "")
        end

        -- Remove file extensions from the name for display purposes
        for k, v in pairs( extensions ) do 
            name = string.gsub( name, v, "" )
        end

        -- Send the music name and path to all clients
        net.Start( "ttt_end_round_music_name" )
        net.WriteString( string.upper(name) )
        net.Broadcast( )

        net.Start( "ttt_end_round_music_path" )
        net.WriteString( "sound/" .. path )
        net.Broadcast( )
    end

    -- Hook into the round end event in TTT
    hook.Add( "TTTEndRound", "EndRoundMusic", endofround )
end

if ( CLIENT ) then
    local volume = 50 -- Default volume for end round music

    -- Chat command to adjust music volume
    hook.Add( "OnPlayerChat", "MusicVolume", function (ply, strText, bTeam, bDead)
        strText = string.lower( strText ) -- Normalize chat text
        local strText = string.Explode( " ", strText ) -- Split the text for command parsing
        if ( ply != LocalPlayer() ) then return end -- Only process commands from the local player
        if ( strText[1] == "!volume" ) then
            if ( tonumber( strText[2] ) ) then
                volume = ( tonumber( strText[2] ) ) -- Set the volume
                ply:ChatPrint( "You set the volume to: " .. strText[2] )
                return true
            end
        end
    end )

    -- Receive and play end round music
    net.Receive( "ttt_end_round_music_path", function( byte, Player )
        local _path = net.ReadString( ) -- Read the path of the music file
        sound.PlayFile(_path, "", function( source )
            if IsValid(source) then
                source:Play() -- Play the music
                source:SetVolume( volume / 100 ) -- Adjust the volume
            end
        end )
    end )

    -- Display the name of the current music on command
    net.Receive( "ttt_end_round_music_name", function( byte, ply )
        local name = net.ReadString() -- Get the music name from the server
        if (name != "end") then
            hook.Add( "OnPlayerChat", "ttt_end_round_music_name", function( ply, strText, bTeam, bDead )
                strText = string.lower( strText ) -- Normalize text
                if ( strText == "!music" ) then
                    chat.AddText( "Music now: " .. name ) -- Display the music name
                    return true
                end
            end )
        end
    end )
end
