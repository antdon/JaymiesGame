require "Map"
require "Player"
require "util"


function love.load()
    floorStart = 0
    playerSpeed = 60
    jumpCount = 0
    gravity = 300
end

function love.draw()
    Map:drawFloor(floorStart)
    Player:drawPlayer()
    for i = 10, 1, 1 do
        love.graphics.translate(1, 0)
        Player:drawPlayer()
    end
end


function love.update(dt)
    floorStart = floorStart - playerSpeed * dt
    if player.jumping then
        if love.keyboard.isDown("space") and jumpCount == 2 then
            gravity = 50
            print("small")
        else
            gravity = 300
            print("big")
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




