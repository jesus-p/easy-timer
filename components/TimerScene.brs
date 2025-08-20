sub init()
    print "TimerScene init() starting"

    ' Nodes
    m.clockLabel = m.top.findNode("clockLabel")
    m.fiveMinButton = m.top.findNode("fiveMinButton")
    if m.fiveMinButton = invalid then
        print "ERROR: fiveMinButton not found"
    else
        print "fiveMinButton found"
    end if

    ' Give the scene initial focus on the button so navigation works immediately
    ' This is critical: without setting focus, OK won’t fire buttonAction
    m.top.setFocus(true)
    if m.fiveMinButton <> invalid then
        m.fiveMinButton.setFocus(true)
    end if

    ' Listen for button presses
    if m.fiveMinButton <> invalid then
        m.fiveMinButton.observeField("buttonAction", "onFiveMinClicked")
        m.fiveMinButton.observeField("focusedChild", "onFocusChanged") ' debug
    end if

    ' 1-second heartbeat timer
    m.timer = createObject("roSGNode", "Timer")
    m.timer.duration = 1
    m.timer.repeat = true
    m.timer.observeField("fire", "onTick")
    m.timer.control = "start"

    ' State
    m.remainingSeconds = 0
    m.clockRunning = true

    updateClock()
end sub

' Debug: see focus moves
sub onFocusChanged()
    print "focus changed: button focused? "; m.fiveMinButton.hasFocus()
end sub

' Button pressed (OK)
sub onFiveMinClicked()
    print "Start 5-minute timer pressed"
    m.remainingSeconds = 300
    m.clockRunning = false
    ' Ensure timer is running
    m.timer.control = "start"
end sub

' Timer tick each second
sub onTick()
    if m.remainingSeconds > 0
        m.remainingSeconds = m.remainingSeconds - 1
        updateCountdownClock()
        print "tick: remaining="; m.remainingSeconds
        if m.remainingSeconds = 0
            m.clockLabel.text = "Time's up!"
            print "Timer ended"
            ' Optionally keep heartbeat to resume clock after a second
            m.clockRunning = true
        end if
    else
        if m.clockRunning
            updateClock()
        end if
    end if
end sub

sub updateClock()
    dt = createObject("roDateTime")
    dt.toLocalTime()
    hh = zeroPad(dt.getHours().toStr(), 2)
    mm = zeroPad(dt.getMinutes().toStr(), 2)
    ss = zeroPad(dt.getSeconds().toStr(), 2)
    m.clockLabel.text = hh + ":" + mm + ":" + ss
end sub

sub updateCountdownClock()
    min = (m.remainingSeconds / 60).toInt()
    sec = (m.remainingSeconds mod 60).toInt()
    mm = zeroPad(min.toStr(), 2)
    ss = zeroPad(sec.toStr(), 2)
    m.clockLabel.text = mm + ":" + ss
end sub

function zeroPad(s as string, n as integer) as string
    if s.len() < n
        return string(n - s.len(), "0") + s
    end if
    return s
end function
