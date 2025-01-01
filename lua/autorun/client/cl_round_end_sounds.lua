if ( CLIENT ) then
    local volume = 50 -- Default music volume for all players who have not set their own value

    -- Hook to detect when a player sends a chat command to adjust volume
    hook.Add( "OnPlayerChat", "MusicVolume", function (ply, strText, bTeam, bDead)
        strText = string.lower( strText ) -- Convert the text to lowercase for easier comparison
        local strText = string.Explode( " ", strText ) -- Split the text into components
        if ( ply != LocalPlayer() ) then return end -- Ignore commands from other players
        if ( strText[1] == "!volume" ) then -- Check if the command is for volume adjustment
            if ( tonumber( strText[2] ) ) then -- Validate that the second part is a number
                volume = ( tonumber( strText[2] ) ) -- Set the volume
                ply:ChatPrint( "You set the volume to: " .. strText[2] ) -- Provide feedback to the player
                return true
            end
        end
    end )

    -- Receive the path of the music file from the server and play it
    net.Receive( "ttt_end_round_music_path", function( byte, Player )
        local _path = net.ReadString( ) -- Read the file path from the network message
        sound.PlayFile(_path, "", function( source ) -- Attempt to play the sound file
            if IsValid(source) then -- Ensure the source is valid
                source:Play() -- Start playback
                source:SetVolume( volume/100 ) -- Adjust volume based on the player's setting
            end
        end )
    end )

    -- Receive the name of the current music and set up a chat hook to display it
    net.Receive( "ttt_end_round_music_name", function( byte, ply )
        local name = net.ReadString(); -- Read the name of the music from the network message
        if (name != "end") then -- Ensure the name is not a special placeholder
            hook.Add( "OnPlayerChat", "ttt_end_round_music_name", function( ply, strText, bTeam, bDead )
                strText = string.lower( strText ) -- Convert text to lowercase for comparison
                if ( strText == "!music" ) then -- Check for the command to display current music
                    chat.AddText( "Music now: " .. name ) -- Display the current music name in chat
                    return true
                end
            end )
        end
    end )
end
