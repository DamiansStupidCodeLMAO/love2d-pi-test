function love.load()
    -- luagpio = package.loadlib("./libs/libLua-GPIO.so", "luaopen_luagpio")() was gonna use but probably just gonna rely on keyboard inputs instead, or gptokeyb in worst case scenario
    push = require "./libs/push"
    fullscreentypevar = "desktop" --swap this to "exclusive" once it's, y'know, running on the pi. it needs accurate res
    love.window.setMode(320, 240, {resizable = true, fullscreen = false, fullscreentype = fullscreentypevar})
    push.setupScreen(320, 240, {upscale = "pixel-perfect"})
    love.graphics.setDefaultFilter("linear", "nearest")
    font = love.graphics.newImageFont("assets/font/Damienne8.png", " AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890!?,.:;\"\'()[]<>/\\|~`@#$%^&*-_+=↑→↓←", 1)
    love.graphics.setFont(font)
    bg = love.graphics.newImage("assets/images/bg.png")
    gooby = love.graphics.newImage("assets/images/gooby.png")
    totTime = 0
    goobyx = 0
    goobyy = 0
end

function love.resize(width, height)
	push.resize(width, height)
end

function love.keypressed(key, code, isrepeat)
    if not isrepeat and key == "f11" then
        love.window.setFullscreen(not love.window.getFullscreen())
    end
    if not isrepeat and key == "f4" then
        isfullscreen, fullscreentype = love.window.getFullscreen()
        if fullscreentype == "desktop" then
            love.window.setFullscreen(love.window.getFullscreen(), "exclusive")
            else
            love.window.setFullscreen(love.window.getFullscreen(), "desktop")
        end
    end
end

function bool2int(bool)
    if bool then
        return 1
    else
        return 0
    end
end

function love.update(dt)
    totTime = totTime + dt
    goobyx = math.cos(totTime)
    goobyy = math.sin(totTime*3)
    goobyflip = math.floor(totTime%2)
    upArrow = bool2int(not love.keyboard.isDown("up"))
    downArrow = bool2int(not love.keyboard.isDown("down"))
    leftArrow = bool2int(not love.keyboard.isDown("left"))
    rightArrow = bool2int(not love.keyboard.isDown("right"))
    arrowsTable = {{1,1,upArrow},"↑ ",{1,1,downArrow},"↓ ",{1,1,leftArrow},"← ",{1,1,rightArrow},"→"}
    print(goobyflip)
end

function love.draw()
    push.start()
        love.graphics.setColor(1,1,1)
        love.graphics.draw(bg, 0, 0, 0, 1, 1)
        if goobyflip == 0 then
            love.graphics.draw(gooby, math.floor(((goobyx*138)+138)+0.5), math.floor(((goobyy*100)+100)+0.5), 0, 2, 2)
            else
            love.graphics.draw(gooby, math.floor(((goobyx*138)+138+44)+0.5), math.floor(((goobyy*100)+100)+0.5), 0, -2, 2)
        end
        love.graphics.setColor(0.25,0,0)
        love.graphics.printf("FPS:"..love.timer.getFPS(),1,85,160,"center", 0, 2)
        love.graphics.setColor(1,1,1)
        love.graphics.printf("FPS:"..love.timer.getFPS(),-1,83,160,"center", 0, 2)
        love.graphics.setColor(0.25,0,0)
        love.graphics.printf("Damienne\'s Graphic Test!",1,101,160,"center", 0, 2)
        love.graphics.setColor(1,1,1)
        love.graphics.printf("Damienne\'s Graphic Test!",-1,99,160,"center", 0, 2)
        love.graphics.setColor(0.25,0,0)
        love.graphics.printf("Can you read this? If so, good!",1,121,160,"center", 0, 2)
        love.graphics.setColor(1,1,1)
        love.graphics.printf("Can you read this? If so, good!",-1,119,160,"center", 0, 2)
        love.graphics.setColor(0.25,0,0)
        love.graphics.printf(arrowsTable, 2, 138, 80, "center", 0, 4)
        love.graphics.setColor(1,1,1)
        love.graphics.printf(arrowsTable, -2, 134, 80, "center", 0, 4)
        love.graphics.setColor(0.25,0,0)
        love.graphics.printf("OK!", 2, 170, 80, "center", 0, 4)
        love.graphics.setColor(1,1,bool2int(not love.keyboard.isDown("return")))
        love.graphics.printf("OK!", -2, 166, 80, "center", 0, 4)
        --render code goes here :3c
    push.finish()
end
