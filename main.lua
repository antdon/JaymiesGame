require "Map"
require "Player"
require "util"
require "Obstacle"


function love.load()
    floorStart = 0
    playerSpeed = 60
    jumpCount = 0
    gravity = 666
    obstacle = false
    obstacles = {}
end

function love.draw()
    Map:drawFloor(floorStart)
    Player:drawPlayer()
    for i, obst in ipairs(obstacles) do
        obst:drawObstacle()
        print(obst.x)
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
    print(player.jumpHeight)
--Floor movement logic
    floorStart = floorStart - playerSpeed * dt
--Obstacle generation Logic
    if math.random(200) == 1 then
        local obst = Obstacle:create(50, 50, WINDOW_WIDTH + 150)
        table.insert(obstacles, obst)
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
        if love.keyboard.isDown("space") and jumpCount == 2 then
            gravity = 50
        else
            gravity = 666
        end
        if player.y > player.jumpHeight then
            player.y = player.y - player.jumpSpeed * dt
            player.jumpSpeed = player.jumpSpeed - gravity * dt
            if player.y > FLOOR_HEIGHT - FLOOR_PIECE_SIZE and falling then
                player.y = FLOOR_HEIGHT - FLOOR_PIECE_SIZE
                player.jumping = false
                local falling = false
                player.jumpHeight = FLOOR_HEIGHT - FLOOR_PIECE_SIZE  
                jumpCount = 0
                maxHeightReached = false
            end

        else
            maxHeightReached = true
            player.jumpSpeed = 0
            player.y = player.y + 1
            falling = true
        end

    end

end

function love.keypressed(key)
    if key == "space" then 
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
    end
end

function drawObstacles()
    for i,obst in ipairs(obstacles) do
        obst:drawObstacle()
    end
end



