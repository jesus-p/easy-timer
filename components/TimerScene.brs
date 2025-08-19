sub init()
    print "TimerScene init started"
    m.clockLabel = m.top.findNode("clockLabel")
    print "Label found: " + type(m.clockLabel)

    m.timer = createObject("roSGNode", "Timer")
    m.timer.repeat = true
    m.timer.duration = 1
    m.timer.observeField("fire", "onTick")
    m.timer.control = "start"
    print "Timer started"

    updateClock()
end sub

sub updateClock()
    dt = createObject("roDateTime")
    dt.toLocalTime()

    hh = zeroPad(dt.getHours().toStr(), 2)
    mm = zeroPad(dt.getMinutes().toStr(), 2)
    ss = zeroPad(dt.getSeconds().toStr(), 2)

    m.clockLabel.text = hh + ":" + mm + ":" + ss
    print "Updated time: " + m.clockLabel.text
end sub

' Pads a string with leading zeros to the specified length
function zeroPad(str as String, length as Integer) as String
    padded = str
    while len(padded) < length
        padded = "0" + padded
    end while
    return padded
end function