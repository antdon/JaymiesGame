require "util"

Obstacle = {}
Obstacle.__index = Obstacle 

function Obstacle:create(height, width, x)
    local obst = {}
    setmetatable(obst, Obstacle)
    obst.height = height
    obst.width = width
    obst.x = x
    return obst
end


function Obstacle:drawObstacle()
    love.graphics.rectangle("fill", self.x, FLOOR_HEIGHT - self.height, self.height, self.width)
end

function Obstacle:moveObstacle()
    self.x = self.x - 10
end
