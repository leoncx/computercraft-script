wifiCommandId = 44
wifiPos = "top"
redstonePos = "front"

wifi = peripheral.wrap(wifiPos)
wifi.open(wifiCommandId)

status = redstone.getOutput(redstonePos)

function switch()
  status = not status
  redstone.setOutput(redstonePos, status)
end

while true do
  local event, sride, freqId, freqReplyId, message, dist = os.pullEvent("modem_message")
  if message == "obsibian" then
    switch()
  end
end
