require "Map"
require "Score"
require "Player"
require "util"
require "Obstacle"
require "collisions"

local floorStart = 0
local jumpCount = 0
local deletedObstCount = 0
local score = 0
local gravity = 666
local obstacle = false
local obstacles = {}
local controls = {}
local hit = false
local pause = false
controls.up = "up"
controls.down = "down"
controls.pause = "p"

function love.load()
    font = love.graphics.newFont("VertigoFLF-Bold.ttf", 200)
    love.graphics.setFont(font)
end

function love.draw()
    love.graphics.setColor(1,1,1)
    love.graphics.print(score, 1/26 * WINDOW_WIDTH, 1/26 * WINDOW_HEIGHT)
    love.graphics.setColor(1,1,1)
    Map:drawFloor(floorStart)
    love.graphics.setColor(0,0.5,0.5)
    Player:drawPlayer()
    for i, obst in ipairs(obstacles) do
        love.graphics.setColor(1,0,0)
        obst:drawObstacle()
    end
    for i = 10, 1, 1 do
        Player:drawPlayer()
    end
    for i,v in ipairs(obstacles) do
        if v == 1 then

        end
    end
end

function love.update(dt)
    for i,obst in ipairs(obstacles) do
        if checkCollision(player, obst) then
            pause = true
        end
    end
    score = Score:updateScore(obstacles, deletedObstCount, player.x)
    print(score)
    if not pause then
        floorStart = Map:moveFloor(floorStart, player.speed, dt)
        Obstacle:generateObstacle(obstacles)
        obstacles = Obstacle:moveObstacles(obstacles, player.speed, dt)
    end
    if Obstacle:deleteUsedObstacle(obstacles) then
        deletedObstCount = deletedObstCount + 1
    end
--Jump Logic
    if player.jumping then
        if love.keyboard.isDown(controls.up) and jumpCount == 2 then
            gravity = 50
        else
            gravity = 666
        end
        if player.cancelled then
            gravity = 10000
        end
        if not pause then
            if player.y > player.jumpHeight then
                player.y = player.y - player.jumpSpeed * dt
                player.jumpSpeed = player.jumpSpeed - gravity * dt
                if player.y >= FLOOR_HEIGHT - FLOOR_PIECE_SIZE then 
                    player.y = FLOOR_HEIGHT - FLOOR_PIECE_SIZE
                    player.jumping = false
                    falling = false
                    player.jumpHeight = FLOOR_HEIGHT - FLOOR_PIECE_SIZE  
                    jumpCount = 0
                    maxHeightReached = false
                    player.cancelled = false
                end

            else
                maxHeightReached = true
                player.jumpSpeed = 0
                player.y = player.y + 1
            end
        end
    else
        player.cancelled = false
    end

end

function love.keypressed(key)
    if key == controls.up and not pause then 
        if jumpCount == 0 then
            jumpCount = jumpCount + 1
            player.jumpHeight = player.jumpHeight - player.jump
            player.jumpSpeed = player.initialJumpSpeed

        elseif jumpCount == 1  and maxHeightReached then
            jumpCount = jumpCount + 1
            player.jumpHeight = player.jumpHeight - player.jump
            player.jumpSpeed = player.initialJumpSpeed
        end

        player.jumping = true
    elseif key == controls.down and not pause then
        player.cancelled = true 
    elseif key == controls.pause then
        pause = not pause
    end

end


function drawObstacles()
    for i,obst in ipairs(obstacles) do
        obst:drawObstacle()
    end
end



