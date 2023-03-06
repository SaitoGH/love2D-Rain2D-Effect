# love2D-Rain2D
My short project on recreating rain on Love2D using Lua.<br>
Sprite By <b>Me</b>.<br>

## Code Example 
```lua
--main.lua
local rain = require 'rain'

function love.update(dt)

    --function rain:beginRain(dt, noRandom) noRandom means you wont get the illusion of rain much and 
    --droplets fall into edge of screen/collision
    rain:beginRain(dt)
    
end

function love.draw()
    --function rain:rainDraw() Draws the rain
    rain:rainDraw()

    rain:dropletsInfo() --optional, ONLY SET TRUE IF YOU TEST WITH SMALL AMOUNT OF RAIN

    --function rain:splashCollide(x,y,w,h) set collision for different objects
    rain:splashCollide(ground.x, ground.y, ground.w,ground.h)  --optional
end
```
Rate Of Droplets Falling is determined by 
```lua
--rain.lua
local global_cd_drop_rate = 0.005 -- The lower, the higher the rate
grav = 9.81 -- determines the velocity at which the droplets are falling
```
## Libraries Used
  * Anim8 
    - https://github.com/kikito/anim8
  * Slider
    - (Not required,I made it for <ins>testing purposes</ins>).

## Rain Examples 
Rain Demo(with Random)<br>
![ezgif com-video-to-gif](https://user-images.githubusercontent.com/42116722/219879746-40dcb82b-e7d0-4d0c-9047-954a51435ca8.gif)

Rain Demo With Collision + No Random<br>
![ezgif com-video-to-gif](https://user-images.githubusercontent.com/42116722/219880510-05de5051-8648-4952-b779-9d4d6f9cc302.gif)
