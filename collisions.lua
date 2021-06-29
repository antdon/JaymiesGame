function checkCollision(a, b)
    local a_left = a.x
    local a_right = a.x + a.width
    local a_top = a.y
    local a_bot = a.y + a.height

    local b_left = b.x
    local b_right = b.x + b.width
    local b_top = b.y
    local b_bot = b.y + b.height

    if a_right > b_left and 
        a_left < b_right and
        a_top < b_bot and
        a_bot > b_top then
        return true
    else
        return false
    end
end


