local fog 

function loadFog()
  fog = love.graphics.newImage("fog_completo.png")
end

function drawFog()
  love.graphics.setColor(1,1,1)
  love.graphics.draw(fog,0,0)
end
