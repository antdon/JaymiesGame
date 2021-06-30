require "Obstacle"

Score = {}
Score.__index = Obstacle 


function Score:updateScore(obstacles, deletedObst, playerX)
    local score = 0
    for i,obst in ipairs(obstacles) do
        if obst:checkPassed(playerX) then
            score = score + 1
        end
    end
    for i = 1, deletedObst do
        score = score + 1
    end
    return score

end
