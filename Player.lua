require "util"
Player = {}
Player.__index = Player

player = {}
player.x = WINDOW_WIDTH/2 - 4*FLOOR_PIECE_SIZE 
player.y = FLOOR_HEIGHT - FLOOR_PIECE_SIZE
player.speed = 100
player.jump = 120
player.jumpHeight = FLOOR_HEIGHT - FLOOR_PIECE_SIZE
player.jumping = false
player.doubleJumping = false
player.initialJumpSpeed  = 400
player.jumpSpeed = player.initialJumpSpeed
player.cancelled = false
player.width = 50
player.height = 50


function Player:drawPlayer()
      love.graphics.rectangle("fill", player.x, player.y, player.width, player.height)
      
end
