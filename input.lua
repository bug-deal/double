local input = {
  left = false,
  right = false
}

function input:update()
  input.left = love.keyboard.isDown('left')
  input.right = love.keyboard.isDown('right')
end

return input
