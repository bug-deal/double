local input = require('input')

local action = {
  acceleration = 500,
  maxSpeed = 250,
  x = 160, y = 200,
  vx = 0, vy = 0,
}

function action:update(dt)
  local accel = dt * self.acceleration * (
    (input.left and -1 or 0) + (input.right and 1 or 0)
  )

  if accel == 0 then -- no input, start braking
    self.vx = 0.9 * self.vx
  else
    self.vx = self.vx + accel
  end

  if self.vx > self.maxSpeed then self.vx = self.maxSpeed end
  if self.vx < -self.maxSpeed then self.vx = -self.maxSpeed end

  local dx = self.vx * dt
  self.x = self.x + dx
end

function action:draw()
  local radius = 5
  local diameter = radius * 2
  love.graphics.setColor(128, 128, 128)
  love.graphics.rectangle('fill',
    self.x - radius, self.y - radius,
    diameter, diameter)
end

return action
