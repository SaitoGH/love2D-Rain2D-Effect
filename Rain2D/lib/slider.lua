--kinda made this while making rain.lua lol

local slider = {}
slider.__index = slider
function slider:newSlider(x, y, min_l, max_l, h)
    local new_s = {}
    new_s.x = x or 0
    new_s.y = y or 0
    new_s.min_l = min_l 
    new_s.max_l = max_l
    new_s.h = h
    setmetatable(new_s, self)
    return new_s
end
function slider:potentSlider(min, max, isReversed)
    isReversed = isReversed or false
    if (min >= max) then
        error('u cant do shit like that')
    end
    local mouseX = love.mouse.getX()
    local mouseY = love.mouse.getY()
    if love.mouse.isDown(1) and (mouseX) > (self.x) and (mouseX) < (self.x + self.max_l) and (mouseY) > (self.y) and (mouseY) < (self.y + self.h)  then
        self.min_l = (mouseX- self.x)
    end
    love.graphics.rectangle("line", self.x, self.y, self.max_l, self.h)--Border
    love.graphics.rectangle("fill", self.x, self.y, self.min_l, self.h)--Slider
    local value
    if (isReversed==false) then
        value = min + (self.min_l * 0.01)
    else 
        value = (max + min) - ((self.min_l * 0.01))
    end
    --love.graphics.print('value ' .. value, self.x ,self.y + 20)
    return value
end





return slider