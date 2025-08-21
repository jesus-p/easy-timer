sub Init()
    print "TimerScene init() starting"

    ' Background
    m.top.backgroundColor = "#a9a9a9"
    m.top.backgroundUri = "pkg:/images/background.jpg"

    ' Nodes
    m.loadingIndicator = m.top.findNode("loadingIndicator")
    m.clockLabel = m.top.findNode("clockLabel")
    m.clockTimer = m.top.findNode("clockTimer")

    m.clockLabel.font.size = m.clockLabel.font.size+160

    if m.clockLabel = invalid then
        print "clockLabel not found"
    end if

    if m.clockTimer <> invalid
        ' Set up timer to tick every 1s
        m.clockTimer.duration = 1.0
        m.clockTimer.repeat = true
        m.clockTimer.control = "start"
        m.clockTimer.observeField("fire", "onClockTick")
    else
        print "clockTimer not found — falling back to one-time update"
    end if

    ' Initial paint
    updateClock()
end sub

sub onClockTick()
    updateClock()
end sub

sub updateClock()
    dt = createObject("roDateTime")
    dt.toLocalTime()

    hh = zeroPadInt(dt.getHours(), 2)
    mm = zeroPadInt(dt.getMinutes(), 2)
    ss = zeroPadInt(dt.getSeconds(), 2)

    if m.clockLabel <> invalid
        m.clockLabel.text = hh + ":" + mm + ":" + ss
    end if
end sub

' Pad a string to length n with leading zeros
function zeroPad(s as string, n as integer) as string
    if s.len() < n then return string(n - s.len(), "0") + s
    return s
end function

' Convenience: pad an integer to length n
function zeroPadInt(v as integer, n as integer) as string
    return zeroPad(v.toStr(), n)
end function
