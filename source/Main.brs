sub Main()
    screen = createObject("roSGScreen")
    m.port = createObject("roMessagePort")
    screen.setMessagePort(m.port)

    scene = screen.createScene("TimerScene")
    screen.show()

    ' Nudge focus after scene shows
    scene.setFocus(true)

    while true
        msg = wait(0, m.port)
        if type(msg) = "roSGScreenEvent" and msg.isScreenClosed()
            return
        end if
    end while
end sub
