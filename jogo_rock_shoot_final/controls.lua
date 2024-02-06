backBox = {
  mouseOverBox = true,
  alpha = 0.5,
  position = vector2.new(0, 0),
  width =  110,
  height =  50
}

local back
local menuControl

function loadControls()
  love.graphics.setBackgroundColor(1,1,1)
  menuControl = love.graphics.newImage("controls_menu.png")
  back = love.graphics.newImage("back.png")
end

function checkCollisionWithMouse(box)
  
  local collisiondir = getcollisiondirection(love.mouse.getX(), love.mouse.getY(), 1, 1, box.position.x, box.position.y, box.width, box.height)

  if (collisiondir.x ~= 0 or collisiondir.y~=0) then
    box.mouseOverBox = true
  else 
    box.mouseOverBox = false
  end
end

function updateControls(dt)
  music:stop()
  
  checkCollisionWithMouse(backBox)
  
  if backBox.mouseOverBox == true then
    backBox.alpha = 1
  else
    backBox.alpha = 0.5
  end
  
end

function drawControls()
  
 love.graphics.setColor(1,1,1,1)
 love.graphics.draw( menuControl, 0, 0)
 love.graphics.setColor(1,1,1,backBox.alpha)
 love.graphics.draw( back, 0, 0)
end