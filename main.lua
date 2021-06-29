require "Map"
require "Player"
require "util"
require "Obstacle"

local floorStart = 0
local playerSpeed = 60
local jumpCount = 0
local gravity = 666
local obstacle = false
local obstacles = {}
local controls = {}
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
--Floor movement logic
    floorStart = floorStart - playerSpeed * dt
--Obstacle generation Logic
    if math.random(200) == 1 then
        --obstaclable represents whether the necessary condidtions for creating a new obstacle are met
        local obstaclable = true
        for i,obst in ipairs(obstacles) do
            --check to see if sufficient space has passed since previous obstacle before generating a new one
            if (obst.x > WINDOW_WIDTH + 150 - 2*obst.width and obst.x < WINDOW_WIDTH + 150) or 
                (obst.x < WINDOW_WIDTH + 150 + 2*obst.width and obst.x > WINDOW_WIDTH + 150) or 
                (obst.x == WINDOW_WIDTH + 150) then
                obstaclable = false
            end
        end
        if obstaclable then
            --create a new obstacle add it to the obstacles table
            local obst = Obstacle:create(50, 50, WINDOW_WIDTH + 150)
            table.insert(obstacles, obst)
        end
    end
--Obstacle movement logic
    for i,obst in ipairs(obstacles) do
        obst.x = obst.x - playerSpeed * dt
    end
--Obstacle deletion logic
    for i,obst in ipairs(obstacles) do
        if obst.x < -WINDOW_SAFETY_LENGTH then 
            table.remove(obstacles, i)
        end
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



