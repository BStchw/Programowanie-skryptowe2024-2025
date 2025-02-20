BLACK = {0, 0, 0}
GREEN = {0, 255, 0}

blocks = {
    -- I
    {{{1, 1, 1, 1}, {0, 0, 0, 0}, {0, 0, 0, 0}, {0, 0, 0, 0}}},  

    -- O (kwadrat)
    {{{1, 1, 0, 0}, {1, 1, 0, 0}, {0, 0, 0, 0}, {0, 0, 0, 0}}},  

    -- L
    {{{1, 0, 0, 0}, {1, 1, 1, 0}, {0, 0, 0, 0}, {0, 0, 0, 0}}},  

    -- Odwrócone L
    {{{0, 0, 1, 0}, {1, 1, 1, 0}, {0, 0, 0, 0}, {0, 0, 0, 0}}}  
}

board = {}
block = nil
block_x = nil
block_y = nil
rotation = nil
state = "GAME"
score = 0

WIDTH = 10 
HEIGHT = 18     
SIZE = 30 

function love.load()
    love.window.setMode(WIDTH * SIZE, HEIGHT * SIZE)
    math.randomseed(os.time())
    init()
end

function love.draw()
    love.graphics.setBackgroundColor(love.math.colorFromBytes(BLACK))

    love.graphics.setColor(love.math.colorFromBytes(GREEN))
    for i = 1, 4 do
        for j = 1, 4 do
            if block[i][j] == 1 then
                love.graphics.rectangle("fill", (block_x + j - 1) * SIZE, (block_y + i - 1) * SIZE, SIZE, SIZE)
            end
        end
    end

    love.graphics.setColor(love.math.colorFromBytes(GREEN))
    for i = 0, HEIGHT - 1 do
        for j = 0, WIDTH - 1 do
            if board[i][j] == "BLOCK" then
                love.graphics.rectangle("fill", j * SIZE, i * SIZE, SIZE, SIZE)
            end
        end
    end

    love.graphics.setColor(love.math.colorFromBytes(GREEN))
    for i = 0, HEIGHT do
        love.graphics.line(0, i * SIZE, WIDTH * SIZE, i * SIZE)
    end
    for i = 0, WIDTH do
        love.graphics.line(i * SIZE, 0, i * SIZE, HEIGHT * SIZE)
    end

    if state == "GAME OVER" then
        love.graphics.setColor(love.math.colorFromBytes(255, 0, 0))
        love.graphics.printf("GAME OVER", 0, HEIGHT * SIZE / 2 - 15, WIDTH * SIZE, "center")
    end
end

fall_speed = 0.7 
fall_timer = 0  

function love.update(dt)
    if state == "GAME" then
        fall_timer = fall_timer + dt  
        
        if fall_timer >= fall_speed then
            move_down() 
            fall_timer = 0
        end
    end
end

function love.keypressed(key)
    if key == "left" then
        move_left()
    elseif key == "right" then
        move_right()
    elseif key == "down" then
        move_down()
    elseif key == "space" then
        rotate()
    elseif key == "escape" then
        love.event.quit()
    end
end


function init()
    board = {}
    for i = 0, HEIGHT - 1 do
        board[i] = {}
        for j = 0, WIDTH - 1 do
            if i == 0 or i == HEIGHT - 1 or j == 0 or j == WIDTH - 1 then
                board[i][j] = "BLOCK"
            else
                board[i][j] = "FREE"
            end
        end
    end
    generate_block()
end

function generate_block()
    block_x = 4
    block_y = 0
    rotation = 1
    block = blocks[math.random(4)][rotation]
end

function move_down()
    local collison = check_collision(block_x, block_y + 1, block)
    if collison == false then
        block_y = block_y + 1
    else
        add_block()
        if block_y <= 1 then
            state = "GAME OVER"
        else
            generate_block()
        end
    end
end

function move_left()
    local collison = check_collision(block_x - 1, block_y, block)
    if collison == false then
        block_x = block_x - 1
    end
end

function move_right()
    local collison = check_collision(block_x + 1, block_y, block)
    if collison == false then
        block_x = block_x + 1
    end
end

function move_down()
    local collision = check_collision(block_x, block_y + 1, block)
    if collision == false then
        block_y = block_y + 1
    else
        add_block()
        if block_y <= 1 then
            state = "GAME OVER" 
        else
            generate_block()
        end
    end
end



function rotate()
    if block == blocks[2][1] then
        return
    end
    
    local new_rotation = (rotation % 4) + 1 

    local new_block = {}
    for i = 1, 4 do
        new_block[i] = {}
        for j = 1, 4 do
            new_block[i][j] = block[5 - j][i]
        end
    end

    if not check_collision(block_x, block_y, new_block) then
        block = new_block
        rotation = new_rotation 
    end
end

function check_collision(x, y, candidate)
    for i = 1, 4 do
        for j = 1, 4 do
            if candidate[i][j] == 1 then
                local board_x = x + j - 1
                local board_y = y + i - 1

                if board[board_y] and board[board_y][board_x] and board[board_y][board_x] == "BLOCK" then
                    return true
                end
            end
        end
    end
    return false
end

function add_block()
    for i = 1, 4 do
        for j = 1, 4 do
            if block[i][j] == 1 then
                local board_x = block_x + j - 1
                local board_y = block_y + i - 1
                if board[board_y] and board[board_y][board_x] then
                    board[board_y][board_x] = "BLOCK"
                end
            end
        end
    end
end
