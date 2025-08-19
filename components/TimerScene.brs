sub init()
    m.timerLabel = m.top.findNode("timerLabel")
    m.timer = CreateObject("roSGNode", "Timer")
    m.timer.duration = 1 'Update every second
    m.timer.repeat = true
    m.timer.control = "start"
    m.top.appendChild(m.timer)
    m.timer.ObserveField("fire", "updateTime")
    updateTime()
end sub

sub updateTime()
    now = CreateObject("roDateTime")
    m.timerLabel.text = now.AsLocaleString("en-US")
end sub
