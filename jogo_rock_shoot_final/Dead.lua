require "Jack"
require "Skeleton"

local deadimage

function loadDead()
  love.graphics.setBackgroundColor(0,0,0)
  deadimage = love.graphics.newImage("dead.png")
end

function updateDead(dt)
music:stop()
end

function drawDead()
  
  love.graphics.draw(deadimage, love.graphics.getWidth()/2,280,0,1.5,1.5,deadimage:getWidth()/2,deadimage:getHeight()/2)
  love.graphics.setColor(1,1,1)
  love.graphics.print('Final Score: '.. jack.score, 320, 430, 0, 2, 2)
  
end