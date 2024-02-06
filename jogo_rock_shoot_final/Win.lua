require "Jack"
require "Skeleton"

local win

function loadWin()
  win = love.graphics.newImage("win.png")
end

function updateWin()
  music:stop()
end

function drawWin()
  love.graphics.setColor(1,1,1)
  love.graphics.draw(win,0,0)
  love.graphics.print(' '.. jack.score, 655,90,0,2.3,2.3)
end