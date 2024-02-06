local floor 

function loadFloor()
  floor = love.graphics.newImage("chão_jogo.png")
end

function drawFloor()
  love.graphics.setColor(1,1,1)
  love.graphics.draw(floor, 0, 0)
end
