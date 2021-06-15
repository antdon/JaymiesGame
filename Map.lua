require "util"

Map = {}
Map.__index = Map


function Map:drawFloorPiece(x)
    for i = FLOOR_HEIGHT, WINDOW_HEIGHT + WINDOW_SAFETY_LENGTH, FLOOR_PIECE_SIZE do
        love.graphics.rectangle("line", x, i, FLOOR_PIECE_SIZE, FLOOR_PIECE_SIZE)
    end
end

function Map:drawFloor(floorStart)
    for i = floorStart, WINDOW_WIDTH+WINDOW_SAFETY_LENGTH - floorStart, FLOOR_PIECE_SIZE do
        Map:drawFloorPiece(i)
    end
end

