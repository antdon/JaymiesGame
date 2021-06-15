require "Map"
require "Player"
require "util"


function love.load()
    floorStart = 0
    playerSpeed = 60
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
        if player.y > player.jumpHeight then
            player.y = player.y - player.jumpSpeed * dt
            player.jumpSpeed = player.jumpSpeed - gravity * dt
            if player.y > FLOOR_HEIGHT - FLOOR_PIECE_SIZE and falling then
                player.y = FLOOR_HEIGHT - FLOOR_PIECE_SIZE
                player.jumping = false
                falling = false
                player.jumpSpeed = player.initialJumpSpeed
            end
        else
            player.jumpSpeed = 0
            player.y = player.y + 1
            falling = true
        end

    end

end

function love.keypressed(key)
    if key == "space" then 
        player.jumping = true
    end
end


