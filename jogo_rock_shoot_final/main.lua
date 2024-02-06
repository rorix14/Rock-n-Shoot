require "Jack"
require "Skeleton"
require "collisions"
require "Dead"
require "extralives"
require "Start"
require "tempo"
require "Win"
require "floor"
require "fog"
require "controls"
require "credits"
local CScreen = require "cscreen"
local finishTime = 0
local START, CONTROLS, CREDITS, GAME, WIN, DEAD = 1, 2, 3, 4, 5, 6
local state = START

function love.load()
  love.window.setTitle( "Rock 'n' Shoot" )
  CScreen.init(800,600,true)
  paused = false
  loadFloor()
  loadFog()
  loadJack()
  loadSkeleton()
  loadDead()
  loadLife()
  loadStart()
  loadWin()
  loadControls()
  loadCredits()
end

function love.update(dt)
  if paused == false then
    
    if state == START then 
      updateStart(dt)
    end
    
    if state == CONTROLS then
      updateControls(dt)
     end
     
    if state == CREDITS then
      updateCredits(dt)
     end

    if state == GAME then 
      updateTempo(dt)
      updateJack(dt)
      updateSkeleton(dt, getJack())
      updateLife(dt)
      finishTime = finishTime + dt
    
      if jack.life == 0 then
        state = DEAD
      end
    
      if finishTime >= 235 then
        state = WIN
      end
    end

    if state == DEAD  then
      updateDead(dt)
    end

    if state == WIN then
      updateWin(dt)
    end
  
  end

end

function love.mousepressed(x, y, button, istouch)
  
  if state == GAME then
    jackMousePressed(x, y, button, istouch)
  end
  
  if button == 1 and state == CONTROLS then
   if backBox.mouseOverBox == true then
     state = START
   end
  end
  if button == 1 and state == CREDITS then
   if backBox2.mouseOverBox == true then
     state = START
   end
  end
  
  if button == 1 and state == START then
    if startBox.mouseOverBox == true then
      state = GAME
      ResetJack()
      ResetSkeleton()
      ResetExLives()
      ResetTempo()
      inishTime = 0
    end
      
    if controlsBox.mouseOverBox == true then
      state = CONTROLS
    end
      
    if creditsBox.mouseOverBox == true then
      state = CREDITS
    end
    
  end
  
  controlsBox.mouseOverBox = false
  creditsBox.mouseOverBox = false
  startBox.mouseOverBox = false
  backBox.mouseOverBox = false
  backBox2.mouseOverBox = false
  
end


function love.keyreleased(key,scancode)
  
  if key == "p" then
    music:pause()
		paused = not paused
	end
  
  if state == GAME or state == DEAD or state == WIN then
    if key == "r" then
      state = GAME
      ResetJack()
      ResetSkeleton()
      ResetExLives()
      ResetTempo()
      finishTime = 0
    end
 end

  if state == START then 
    if key == "s" then
      state = GAME
      ResetJack()
      ResetSkeleton()
      ResetExLives()
      ResetTempo()
      finishTime = 0
    end
    
     if key == "c" then
        state = CONTROLS
     end
     
     if key == "v" then
       state = CREDITS
     end
  end
  if key == "q" then
    state = START
  end
  
  if key == "escape" then
    love.event.quit()
  end
  
end

function love.draw()
  CScreen.apply()
  love.graphics.setBackgroundColor(0,0,0)
  
  if state == START then
     drawStart()
  end
  
  if state == CONTROLS then
    drawControls()
  end
   
  if state == CREDITS then
    drawCredits()
  end
  
  if state == GAME then
    drawFloor()
    drawTempo()
    drawLife()
    drawSkeleton()
    drawFog()
    drawJack()
  end

  if state == DEAD then
    drawDead()
  end
  
  if state == WIN then
    drawWin()
  end
  
  CScreen.cease()
 end
 
function love.resize(width, height)
  CScreen.update(width, height)
end