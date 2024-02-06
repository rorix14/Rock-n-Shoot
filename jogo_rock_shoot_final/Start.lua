require "Jack"
require "Skeleton"

startBox = {
  mouseOverBox = true,
  alpha = 0.5,
  position = vector2.new(275,350),
  width =  250,
  height =  100
}

controlsBox = {
  mouseOverBox = true,
  alpha = 0.5,
  position = vector2.new(135,490),
  width =  250,
  height =  100
}

creditsBox = {
  mouseOverBox = true,
  alpha = 0.5,
  position = vector2.new(425,490),
  width =  250,
  height =  100
}

local logo 
local start
local controls
local credits

function checkCollisionWithMouse(box)
  
  local collisiondir = getcollisiondirection(love.mouse.getX(), love.mouse.getY(), 1, 1, box.position.x, box.position.y, box.width, box.height)

    if (collisiondir.x ~= 0 or collisiondir.y~=0) then
      box.mouseOverBox = true
    else 
      box.mouseOverBox = false
    end
end


function loadStart()
  love.graphics.setBackgroundColor(1,1,1)
  logo = love.graphics.newImage("logo_game.png")
  start = love.graphics.newImage("start.png")
  controls = love.graphics.newImage("controls.png")
  credits = love.graphics.newImage("credits.png")
end




function updateStart(dt)
  music:stop()
  checkCollisionWithMouse(startBox)
  checkCollisionWithMouse(controlsBox)
  checkCollisionWithMouse(creditsBox)
  
  if  startBox.mouseOverBox == true then
    startBox.alpha = 1
  else
    startBox.alpha = 0.5
  end

  if  controlsBox.mouseOverBox == true then
    controlsBox.alpha = 1
  else
    controlsBox.alpha = 0.5
  end

  if creditsBox.mouseOverBox == true then
    creditsBox.alpha = 1
  else
    creditsBox.alpha = 0.5
  end
end


function drawStart()
  love.graphics.setColor(1,1,1)
  love.graphics.draw(logo,-30,0)
  
  love.graphics.setColor(1,1,1, startBox.alpha)
  love.graphics.setLineWidth(10)
  love.graphics.draw( start, 275, 350)
  love.graphics.setColor(1,1,1, controlsBox.alpha)
  love.graphics.draw( controls, controlsBox.position.x, controlsBox.position.y-5)
  love.graphics.setColor(1,1,1, creditsBox.alpha)
  love.graphics.draw( credits, creditsBox.position.x,creditsBox.position.y)
end