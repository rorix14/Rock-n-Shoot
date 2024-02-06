require "vector2"
require "Jack"

local circle_array = {}
sweet_spot_circle = {}

sweet_spot_array = {9.031,9.532,10.031,10.523,11.014,11.514,12.014,12.498,12.990,13.464,13.916,14.431,14.914,15.414,15.914,16.372,16.839,17.330,17.822,18.297,18.763,19.255,19.755,20.239,20.697,21.164,21.663,22.138,22.605,23.073,23.588,24.038,24.512,24.962,25.454,25.912,26.396,26.879,27.371,27.804,28.304,28.763,29.305,29.762,30.245,30.737,31.212,31.671,32.162,32.629,33.154,33.611,34.119,34.587,35.086,35.569,36.028,36.528,37.011,37.461,37.952,38.436,38.910,39.394,39.869,40.344,40.836,41.336,41.835,42.277,42.769,43.235,43.719,44.202,44.693,45.144,45.643,46.127,46.618,47.109,47.594,48.101,48.617,49.134,49.642,50.167,50.667,51.192,51.685,52.185,52.686,53.135,53.661,54.144,54.658,55.108,55.592,56.075,56.542,57.017,57.526,58.058,58.575,59.024,59.483,59.983,60.482,60.974,61.442,61.958,62.441,62.940,63.407,63.891,64.390,64.857,65.349,65.874,66.365,66.832,67.323,67.824,68.315,68.824,69.307,69.773,70.282,70.831,71.323,79.455,80.022,80.538,81.013,81.522,82.013,82.496,82.971,83.480,83.938,84.388,84.938,85.455,85.921,86.396,86.904,87.396,87.896,88.379,88.871,89.346,89.854,90.346,90.853,91.312,91.787,92.261,92.729,93.195,93.719,94.204,94.703,95.161,95.645,96.144,96.636,97.161,97.636,98.111,98.586,99.061,99.536,100.002,100.519,100.994,101.469,101.927,102.435,102.927,103.418,103.902,104.410,104.877,105.426,105.885,106.360,106.843,107.310,107.792,108.276,108.776,109.243,109.745,110.184,110.685,111.134,111.634,112.134,112.584,113.067,113.550,114.050,114.526,114.983,115.467,115.941,116.408,116.883,117.367,117.859,118.341,118.599,118.841,119.083,119.359,119.591,119.849,120.091,120.349,120.575,120.858,121.099,121.359,121.591,121.832,122.124,122.382,123.082,123.316,123.691,124.016,124.316,125.333,126.265,127.007,127.282,127.649,127.982,128.257,128.590,128.949,129.257,129.757,130.298,130.973,131.239,131.582,131.915,132.173,133.165,134.214,134.864,135.106,135.472,135.839,136.114,136.497,136.830,137.122,137.630,138.139,138.815,139.055,139.447,139.763,140.072,141.047,142.021,142.738,142.963,143.314,143.688,143.963,144.313,144.655,144.988,145.479,146.004,146.671,146.896,147.279,147.587,147.904,148.887,149.854,150.529,150.787,151.161,151.521,151.770,152.637,152.845,153.328,153.778,154.020,154.278,154.529,154.803,155.028,155.278,155.520,155.787,156.003,156.261,156.51,156.803,157.061,157.286,157.594,157.861,162.011,166.060,166.777,167.002,167.384,167.710,168.043,168.977,169.977,170.684,170.909,171.276,171.651,171.926,172.875,173.834,174.559,174.759,175.142,175.451,175.783,176.708,177.701,178.449,178.675,179.033,179.383,179.666,180.591,181.600,182.308,182.566,182.882,183.258,183.533,184.516,185.465,186.199,186.457,186.815,187.132,187.457,188.423,189.390,190.124,190.365,190.731,191.115,191.389,192.332,193.314,194.032,194.256,194.597,194.930,195.231,196.364,197.164,197.881,198.122,198.481,198.764,199.072,200.030,200.964,201.721,201.955,202.330,202.647,202.904,203.830,204.854,205.088,205.330,205.571,205.830,206.063,206.338,206.562,206.838,207.088,207.330,207.571,207.845,208.054,208.346,208.579,208.854,209.571,209.788,210.153,210.454,210.762,211.754,212.720,213.428,213.670,214.028,214.370,214.670,215.294,215.603,216.129,216.644,217.303,217.561,217.911,218.236,218.537,219.569,220.519,221.219,221.494,221.835,222.135,222.444,222.794,223.152,223.476,223.943,224.469,228.543, 1000}

local radius = 400
local circleCount = 0
local CurrentTime = 0
local sweet_spot_index = 1
local index = 1

function updateTempo(dt)
  
  if CurrentTime >= sweet_spot_array[sweet_spot_index] and sweet_spot_index <= 1000 then
  
    table.insert( sweet_spot_circle,{
      alpha = 1
    })
    sweet_spot_index = sweet_spot_index + 1
  end

  if CurrentTime >= sweet_spot_array[index] - 5 and index <= 1000 then
    circleCount = circleCount +1
    table.insert( circle_array,{
      velocity = 0,
      alpha = 0,
      shape = radius,
      remove = false
    })
    index = index + 1
  end
  
  CurrentTime = CurrentTime + dt
  
  for i = 1, table.getn(sweet_spot_circle), 1 do
    sweet_spot_circle[i].alpha =  sweet_spot_circle[i].alpha - 3.2*dt
    if sweet_spot_circle[i].alpha <= 0.2 then
      sweet_spot_circle[i].alpha = 0.2
    end
  end

  for i = 1, circleCount, 1 do
    if circle_array[i].shape > 0 then
      circle_array[i].shape = circle_array[i].shape - 64*dt 
    end
   
    circle_array[i].alpha = circle_array[i].alpha + 0.05*dt
    if circle_array[i].alpha > 0.5 then
      circle_array[i].alpha = 0.5
    end
  end
  
  for i = 1, circleCount do
    if circle_array[i].shape < radius/5 then
      circle_array[i].remove = true
    end
  end
 
  local i = 1;
  while (i <= table.getn(circle_array)) do
    if circle_array[i].remove == true then 
      table.remove(circle_array,i)
      circleCount = circleCount - 1
      if circleCount < 0 then
        circleCount = 0
      end
    end
    i = i +1
  end
  
end

function ResetTempo()
  radius = 400
  circleCount = 0
  CurrentTime = 0
  sweet_spot_index = 1
  index = 1
  circle_array = {}
  
  for i = 1, table.getn(circle_array),1 do
    table.remove(circle_array,i)
  end
  
  for i = 1, table.getn(sweet_spot_circle),1 do
    table.remove(sweet_spot_circle,i)
  end
 
end

function drawTempo()

  for i = 1, circleCount do
    if circle_array[i] then
      love.graphics.setColor(1, 0, 0, 0.05)
      love.graphics.circle("fill", jack.position.x, jack.position.y, circle_array[i].shape)
    end
  end
  
  love.graphics.setLineWidth(1)
  for i = 1, circleCount do
    if circle_array[i] then
      love.graphics.setColor(1, 0, 0, circle_array[i].alpha)
      love.graphics.circle("line", jack.position.x, jack.position.y, circle_array[i].shape)
    end
  end
 
  love.graphics.setLineWidth(10)
  love.graphics.setColor(1, 1, 1, 0.2)
  for i = 1, table.getn(sweet_spot_circle), 1 do
    love.graphics.setColor(1, 1, 1, sweet_spot_circle[i].alpha)
  end
  
    love.graphics.circle( "line", jack.position.x, jack.position.y ,radius/5)
    
end