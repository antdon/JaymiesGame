require "util"

Obstacle = {}
Obstacle.__index = Obstacle 

function Obstacle:create(height, width, x)
    local obst = {}
    setmetatable(obst, Obstacle)
    obst.height = height
    obst.width = width
    obst.x = x
    obst.y = FLOOR_HEIGHT - obst.height
    return obst
end


function Obstacle:drawObstacle()
    love.graphics.rectangle("fill", self.x, self.y, self.height, self.width)
end


function Obstacle:generateObstacle(obstacles)
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
end

function Obstacle:moveObstacles(obstacles, speed, dt)
    for i,obst in ipairs(obstacles) do
        obst:moveObstacle(speed, dt)
    end
    return obstacles
end

function Obstacle:moveObstacle(speed, dt)
    self.x = self.x - speed * dt
end

function Obstacle:deleteUsedObstacle(obstacles)
    removed = false
    for i,obst in ipairs(obstacles) do
        if obst.x < -WINDOW_SAFETY_LENGTH then 
            table.remove(obstacles, i)
            removed = true
        end
    end
    return removed
end

function Obstacle:checkPassed(playerX)
    if playerX > self.x then
        return true
    else
        return false
    end
end
