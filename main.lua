function love.load()
    FLOOR_PIECE_SIZE = 50
    WINDOW_HEIGHT, WINDOW_WIDTH, WINDOW_FLAGS = love.window.getMode()
    WINDOW_SAFETY_LENGTH = 500
    FLOOR_HEIGHT = WINDOW_HEIGHT/2 + 100
    

end

function drawFloorPiece(x)
    for i = FLOOR_HEIGHT, WINDOW_HEIGHT + WINDOW_SAFETY_LENGTH, FLOOR_PIECE_SIZE do
        love.graphics.rectangle("line", x, i, FLOOR_PIECE_SIZE, FLOOR_PIECE_SIZE)
    end
end

function love.update()
end

function love.draw()
    initialiseFloor()

end

function initialiseFloor()
    for i = 0, WINDOW_WIDTH+WINDOW_SAFETY_LENGTH, FLOOR_PIECE_SIZE do
        drawFloorPiece(i)
    end
end

function love.keypressed(key)
    if key == "space" then
    end
end



