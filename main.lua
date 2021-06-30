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
controls.up = "up"
controls.down = "down"

function love.draw()
    love.graphics.setColor(1,1,1)
    Map:drawFloor(floorStart)
    love.graphics.setColor(0,0.5,0.5)
    Player:drawPlayer()
    for i, obst in ipairs(obstacles) do
        love.graphics.setColor(1,0,0)
        obst:drawObstacle()
    end
    for i = 10, 1, 1 do
        love.graphics.translate(1, 0)
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
            hit = true
        end
    end
    score = Score:updateScore(obstacles, deletedObstCount, player.x)
    print(score)
    floorStart = Map:moveFloor(floorStart, player.speed, dt)
    Obstacle:generateObstacle(obstacles)
    obstacles = Obstacle:moveObstacle(obstacles, player.speed, dt)
    if obstacles ~= Obstacle:deleteUsedObstacle(obstacles) then
        obstacles = Obstacle:deleteUsedObstacle(obstacles)
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
    else
        player.cancelled = false
    end

end

function love.keypressed(key)
    if key == controls.up then 
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
    elseif key == controls.down then
        player.cancelled = true 
    end

end


function drawObstacles()
    for i,obst in ipairs(obstacles) do
        obst:drawObstacle()
    end
end



