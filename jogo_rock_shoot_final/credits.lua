backBox2 = {
  mouseOverBox = true,
  alpha = 0.5,
  position = vector2.new(0, 0),
  width =  110,
  height =  50
}

local back
local credits
 
function loadCredits()  
  love.graphics.setBackgroundColor(1,1,1)
  back = love.graphics.newImage("back.png")
  credits = love.graphics.newImage("credits.png")
end

function checkCollisionWithMouse(box)
  
  local collisiondir = getcollisiondirection(love.mouse.getX(), love.mouse.getY(), 1, 1, box.position.x, box.position.y, box.width, box.height)

  if (collisiondir.x ~= 0 or collisiondir.y~=0) then
    box.mouseOverBox = true
  else 
    box.mouseOverBox = false
  end
end

function updateCredits(dt)
  music:stop()
  
  checkCollisionWithMouse(backBox2)
  
  if backBox2.mouseOverBox == true then
    backBox2.alpha = 1
  else
    backBox2.alpha = 0.5
  end
end

function drawCredits()
  
  love.graphics.setColor(1,1,1,backBox2.alpha)
  love.graphics.draw( back, 0, 0)
  love.graphics.setColor(1,1,1)
  love.graphics.draw( credits, 250, 0)
  love.graphics.print('Pedro Silva', 300, 100, 0,2,2)
  love.graphics.print('José Gil', 300, 150, 0,2,2)
  
end
