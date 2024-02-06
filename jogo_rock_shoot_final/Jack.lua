require "vector2"

 jack = {
  animation = {},
  frameTime = 0,
  frame = 1,
  heartFrame = 15,
  position = vector2.new(400,300),
  velocity = vector2.new(0,0),
  width =  30,
  height =  30,
  mass = 1,
  maxspeed = 300,
  frictionfactor = 3000,
  rotation = 0,
  life = 12,
  invtimer = 1,
  bullet = {},
  score = 0,
  totalBullets = 0
} 

local bullet = jack.bullet
local heart = {}
local fireball

function loadJack()
  for i = 1, 8, 1 do
    jack.animation[i] = love.graphics.newImage("jack_0" .. i .. ".png")
  end
  
  for i =1, 12, 1 do
    heart[i] = love.graphics.newImage("life".. i.. ".png")
  end

  fireball = love.graphics.newImage("fireball.png")
end

function getJack()
  return jack
end

function updateJack(dt)
  
  jack.frameTime = jack.frameTime + dt
  if jack.frameTime > 0.2 then
    jack.frame = jack.frame + 1
    if jack.frame > 8 or  jack.frame < 1 then
      jack.frame = 1
    end
    jack.frameTime = 0
  end
  
  
  
  local mouseposition = vector2.new(love.mouse.getX(),love.mouse.getY())
  local mousedirection = vector2.sub(mouseposition,jack.position)
  mousedirection = vector2.normalize(mousedirection)
  jack.rotation = math.atan2(mousedirection.y,mousedirection.x)

  if vector2.magnitude(jack.velocity) < 500 * dt then
    jack.velocity = vector2.new (0,0)
    acceleration = vector2.new(0,0)
  end
  


  for i = 1, table.getn(bullet), 1 do
    if bullet[i] ~= nil then
    bullet[i].position.x = bullet[i].position.x + ( 5 * bullet[i].velocity.x * dt)
    bullet[i].position.y = bullet[i].position.y + ( 5 * bullet[i].velocity.y * dt)
    
      if bullet[i].position.x > love.graphics.getWidth() or bullet[i].position.y > love.graphics.getHeight() or bullet[i].position.x < 0 or bullet[i].position.y < 0  then
        table.remove(bullet, i)
      end
    end
  end

  
  
  local acceleration = vector2.new(0,0)
  local friction = vector2.mult(jack.velocity, -1)
  friction = vector2.normalize(friction)
  friction = vector2.mult(friction,jack.frictionfactor)
  acceleration = vector2.applyForce(friction, jack.mass, acceleration)
  

  
  if love.keyboard.isDown("w") then
    local movementforce = vector2.new(0,-5000)
    acceleration = vector2.applyForce(movementforce,jack.mass,acceleration)
  end

  if love.keyboard.isDown("d") then
    local movementforce = vector2.new(5000,0)
    acceleration = vector2.applyForce(movementforce,jack.mass,acceleration)
  end
  
  if love.keyboard.isDown("a") then
    local movementforce = vector2.new(-5000,0)
    acceleration = vector2.applyForce(movementforce,jack.mass,acceleration)
  end
  
  if love.keyboard.isDown("s") then
    local movementforce = vector2.new(0,5000)
    acceleration = vector2.applyForce(movementforce,jack.mass,acceleration)
  end
  
  
  jack.velocity = vector2.add(jack.velocity, vector2.mult(acceleration,dt))
  jack.velocity = vector2.limit(jack.velocity,jack.maxspeed)
  jack.position = vector2.add(jack.position, vector2.mult(jack.velocity,dt))
  
  if jack.position.x > love.graphics.getWidth() - jack.width then
    jack.position.x = love.graphics.getWidth() - jack.width
  end
  
  if jack.position.y > love.graphics.getHeight() - jack.height then
    jack.position.y = love.graphics.getHeight() - jack.height
  end
  
  if jack.position.x < 0 then
    jack.position.x = 0
  end
  
  if jack.position.y < 0 then
    jack.position.y = 0
  end
end

function ResetJack()
  jack.invtime = 1
  jack.life = 12
  jack.position = vector2.new(400,300)
  jack.velocity = vector2.new (0,0)
  acceleration = vector2.new(0,0)
  jack.score = 0
  jack.totalBullets = 0
  jack.frame = 1
end

function jackMousePressed(x, y, button, istouch)
  if paused == false then
    if button == 1 then
      local speed = 800
      local angle = math.atan2(y - (jack.position.y), x - (jack.position.x))
      local mvx = math.cos(angle) * speed
      local mvy = math.sin(angle) * speed
      local radius = 8
      local currentBullet = {
      rotation = jack.rotation,
      position = vector2.new(jack.position.x , jack.position.y),
      velocity = vector2.new(mvx, mvy),
      shapeRadius = radius,
      bodySize = 2 * radius
      }
      table.insert(bullet, currentBullet)
      jack.totalBullets = jack.totalBullets + 1
    end
  end
end
  
  function drawJack()
    if paused then
      --love.graphics.print('Paused' , 350, 250, 0, 2, 2)
    end
   
    if jack.invtimer > 1 then
      love.graphics.setColor(1,1,1)
    else
      love.graphics.setColor(1,1,1, 0.5)
    end
    love.graphics.draw(jack.animation[jack.frame], jack.position.x,jack.position.y, jack.rotation,1,1, jack.animation[jack.frame]:getWidth()/2,jack.animation[jack.frame]:getHeight()/2)
    
    love.graphics.setColor(1,1,1)
    if jack.life >= 1 then
      love.graphics.draw(heart[jack.life], 24,22,0,1,1, heart[jack.life]:getWidth()/2, heart[jack.life]:getHeight()/2)
    end
     
    for i = 1, table.getn(bullet), 1 do
      love.graphics.setColor(1,1,1)
      love.graphics.draw(fireball, bullet[i].position.x , bullet[i].position.y, bullet[i].rotation,1,1, (fireball:getWidth()+8)/2, fireball:getHeight()/2)
    end
  end