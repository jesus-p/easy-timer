sub Main()
    screen = CreateObject("roSGScreen")
    m.port = CreateObject("roMessagePort")
    scene = screen.CreateScene("TimerScene")
    screen.Show()
    while true
        msg = wait(0, m.port)
        if type(msg) = "roSGScreenEvent"
            if msg.isScreenClosed() then
                exit while
            end if
        end if
    end while
end sub
