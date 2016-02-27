local input = {
  left = false,
  right = false,

  jump = 0,
  uppercut = 0
}

function input:update()
  input.left = love.keyboard.isDown('a')
  input.right = love.keyboard.isDown('d')
  input.jump = love.keyboard.isDown('j') and (input.jump + 1) or 0
  input.uppercut = love.keyboard.isDown('k') and (input.uppercut + 1) or 0
end

return input
