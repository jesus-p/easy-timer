sub Main()
    ShowChannelRSGScreen()
end sub

sub ShowChannelRSGScreen()
    print "ShowChannelRSGScreen() called"
    ' Create the screen and message port
    screen = CreateObject("roSGScreen")
    m.port = CreateObject("roMessagePort")
    screen.SetMessagePort(m.port)
    
    ' Set the scene to TimerScene
    ' This will load the scene and call its Init() method
    scene = screen.CreateScene("TimerScene")
    screen.Show()
    ' vscode_rdb_on_device_component_entry


    while(true)
        ' waiting for events from screen
        msg = wait(0, m.port)
        msgType = type(msg)
        if msgType = "roSGScreenEvent"
            if msg.IsScreenClosed() then return
        end if
    end while
end sub
