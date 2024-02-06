require "vector2"
exLife = {}

life_array = {20, 30, 40,45, 50, 60,65, 70, 80,85, 90, 100,105, 110, 120,125, 130, 140,145, 150, 160,165, 170,175, 180, 190, 200, 210, 1000}

local heartCount = 0
local CurrentTime = 0
local Index = 1
local heart

function loadLife()
  heart = love.graphics.newImage("life+1.png")
end

function checkCollisionWithLife(jack, exLife)
  for i = 1, table.getn(exLife) do
    if exLife[i] then
      local collisiondir = getcollisiondirection(jack.position.x, jack.position.y, jack.width, jack.height, exLife[i].position.x, exLife[i].position.y, exLife[i].width, exLife[i].height)
      
      if (collisiondir.x ~= 0 or collisiondir.y~=0) then
        exLife.gainLife = true
        table.remove(exLife,i)
        
        if jack.life < 12 then
          jack.life = jack.life + 1
        end
        
         return
       end
    end
  end
end

function updateLife(dt)
  
  if CurrentTime >= life_array[Index] and Index <= 1000 then
    heartCount = heartCount +1
    
    table.insert( exLife,{
    position = vector2.new(love.math.random(15, 760) ,love.math.random(15, 560)),
    rotation = 0,
    width = 26,
    height = 23,
    gainLife = true
    })
    
    Index = Index + 1
  end
  
  CurrentTime = CurrentTime + dt
  
  checkCollisionWithLife(jack, exLife)
   
  end

function ResetExLives()
  heartCount = 0
  CurrentTime = 0
  Index = 1
  
  for i = 1, table.getn(exLife) do
    table.remove(exLife, 1)
  end
  
end

function drawLife()
   for i = 1, heartCount do
      if exLife[i] then
        love.graphics.setColor(1,1,1)
        love.graphics.draw(heart, exLife[i].position.x, exLife[i].position.y, exLife[i].rotation, 1, 1, heart:getWidth() / 2 , heart:getHeight() / 2)
      end
    end
  end