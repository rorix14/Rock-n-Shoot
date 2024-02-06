require "vector2"

function getcollisiondirection(x1,y1,w1,h1,x2,y2,w2,h2)
  local xdist = math.abs((x1+(w1/2)) - (x2+(w2/2)))
  local ydist = math.abs((y1+(h1/2)) - (y2+(h2/2)))
  local combinedwidth = ((w1/2) + (w2/2))
  local combinedheight = ((h1/2) + (h2/2))
  
  if xdist > combinedwidth or ydist > combinedheight then
    return vector2.new(0,0)
  end
  
  local overlapx = math.abs(xdist - combinedwidth)
  local overlapy = math.abs(ydist - combinedheight)
  local characterdir = vector2.normalize(vector2.sub(vector2.new(x1,y1), vector2.new(x2,y2)))
  local colisiondirection
  if overlapx > overlapy then
    colisiondirection = vector2.normalize(vector2.new(0,characterdir.y*overlapy))
  elseif overlapx < overlapy then
    colisiondirection = vector2.normalize(vector2.new(characterdir.x*overlapx,0))
  else
    colisiondirection = vector2.normalize(vector2.new(characterdir.x * overlapx, characterdir.y*overlapy))
  end
  
  return colisiondirection
end