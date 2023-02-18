local rain = require 'rain'
winHeight = love.graphics.getHeight()
winWidth = love.graphics.getWidth()
function love.load()
    
    --collision testing
    ground = {x=winWidth/4,y=(winHeight*3/4),w=winWidth/2, h=2}
    
end
function love.update(dt)

    --function rain:beginRain(dt, noRandom) noRandom means you wont get the illusion of rain much
    rain:beginRain(dt)

end

function love.draw()
    --function rain:rainDraw() Draws the rain
    rain:rainDraw()

    rain:dropletsInfo() --optional, ONLY SET TRUE IF YOU TEST WITH SMALL AMOUNT OF RAIN

    --function rain:splashCollide(x,y,w,h) set collision for different objects
    rain:splashCollide(ground.x, ground.y, ground.w,ground.h)  --optional

    love.graphics.setColor( 255, 255, 255, 0.4 )
    love.graphics.rectangle('fill', ground.x, ground.y, ground.w, ground.h)
end