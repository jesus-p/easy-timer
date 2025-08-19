sub main()
    print "main() started"
    m.port = createObject("roMessagePort")
    screen = createObject("roSGScreen")
    screen.setMessagePort(m.port)

    m.scene = screen.createScene("TimerScene")
    print "Scene created"
    screen.show()
    print "Screen shown"

    while true
        msg = wait(0, m.port)
        if type(msg) = "roSGScreenEvent"
            if msg.isScreenClosed() then return
        end if
    end while
end sub