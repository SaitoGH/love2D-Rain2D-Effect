local slider = require 'lib/slider'
local anim = require 'lib/anim8'
math.randomseed(os.time())

local winWidth = love.graphics.getWidth()
local global_cd_drop_rate = 0.005
local rain = {
    cooldown_per_drop = global_cd_drop_rate,
    grav=9.81
}
local droplets = {}
droplets.main = {x,y,w,h,vel,opacity}
droplets.mt = {}
droplets.mt.__index = droplets.main
droplets.table = {}
 --not required for the rain to work, its only for controlling the rain drop cd --> Controls rain drop rate
 local r_s = {x=winWidth-100,y=10,w=100,h=20}
 rainSlider = slider:newSlider(r_s.x, r_s.y, 0, r_s.w, r_s.h)--rainSlider

--Rain background audio
local rain_sound = love.audio.newSource("lightrain.mp3", "stream")

--Splash animation and settings and tables
local splash_table = {}
function splash_vfx(x, y)
    local splash_vfx = {}
    splash_vfx.image = love.graphics.newImage("splash-spreadsheet.png")
    splash_vfx.grid =  anim.newGrid(32, 32, splash_vfx.image:getWidth(), splash_vfx.image:getHeight())
    splash_vfx.frame = splash_vfx.grid('1-5', 1 )
    splash_vfx.animation = anim.newAnimation(splash_vfx.frame, 0.1, false)
    splash_vfx.x = x or nil
    splash_vfx.y = y or nil
    return splash_vfx
end
function droplets:new(o)
    setmetatable(o, droplets.mt)
    table.insert(droplets.table, o)
    return o
end
--Draw spawned droplets
function droplets:Draw()
    for k,v in pairs(droplets.table) do
        love.graphics.setColor( 255, 255, 255,v.opacity )
        love.graphics.rectangle('fill', v.x, v.y, v.w, v.h)
    end
end


function rain:splashCollide(x,y,w,h)
    --Detects collision with objects for each droplets
    for k,v in pairs(droplets.table) do
        if (v.x + v.w) > (x) and (v.x) < (x+w) and (v.y + v.h) > (y) and (v.y) < (y+h) then
            newSplash = splash_vfx(v.x, y-25)
            table.insert(splash_table, newSplash)
            table.remove(droplets.table, k)
        end
    end
end

--This only instantiate the rain but does not draw the rain
function rain:beginRain(dt, noRandom)
    noRandom = noRandom or false
    --Remove Splash VFX
    for s_k,s_v in ipairs(splash_table) do
        s_v.animation:update(dt)
        if s_v.animation.position == 5 then
            table.remove(splash_table,s_k)
        end
    end
    --Run rain background audio
    rain_sound:play()
    --rain drop cooldown
    rain.cooldown_per_drop = rain.cooldown_per_drop - dt
    if rain.cooldown_per_drop <= 0  then
        local randWidth = math.random(1,2)
        local randHeight = math.random(15,40)
        local randX = math.random(0,winWidth - randWidth)
        local randOp = math.random() * .45
        local newDroplet = droplets:new{x=randX,y=-10-randHeight,w=randWidth,h=randHeight, vel=0,opacity=randOp}
        rain.cooldown_per_drop = global_cd_drop_rate --CD Rain must be the same
    end
    --If droplets passes the screen
    for k,v in pairs(droplets.table) do
        if (noRandom==false) then 
            local rand_splash_chance = math.random()
            if rand_splash_chance > 0.9 and v.y > winHeight/2 then
                newSplash = splash_vfx(v.x, v.y)
                table.insert(splash_table, newSplash)
                table.remove(droplets.table, k)
            end 
        end
        --Rain Logic 
        v.vel = v.vel + rain.grav
        v.y = v.y + v.vel * dt 
        --If goes past screen
        if (v.y+v.h) >= winHeight then
            newSplash = splash_vfx(v.x, winHeight-20)
            table.insert(splash_table, newSplash)
            table.remove(droplets.table, k)
        end
        
    end
end
function rain:rainDraw()
    droplets:Draw()
     --Splash effect occurs when collides with an object
    love.graphics.setColor( 255, 255, 255, 1 )
    global_cd_drop_rate=rainSlider:potentSlider(0.005, 1, true)--rainSlider
    for _,s_v in ipairs(splash_table) do
        s_v.animation:draw(newSplash.image, s_v.x, s_v.y)
    end
end

function rain:dropletsInfo(check_pos)
    --c_pos gets position of all droplets and  prints out to screen and is automatically set to false 
    local c_pos = check_pos or false
    love.graphics.setColor( 255, 255, 255,1 )
    love.graphics.print("rain_droplet_count "..#droplets.table, 0, 0)
    if c_pos then 
        for _,v in ipairs(droplets.table) do
            font = love.graphics.newFont(12)
            love.graphics.setFont(font)
            love.graphics.print('x=' .. v.x, v.x + 10, v.y -10)
            love.graphics.print('y=' .. v.x, v.x + 10, v.y +10)
        end
    end
end


return rain
