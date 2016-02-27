local input = require('input')
local uppercut = require('move')

local action = {
  acceleration = 1000,
  maxSpeed = 300,
  x = 160, y = 200,
  vx = 0, vy = 0,
  facingRight = true,

  gravity = 800,
  takeoff = 352,
  overshoot = 96,
  minjump = 5,

  grounded = true,
  airframes = 0,

  currentMove = nil,
  moveTime = 0
}

function action:update(dt)
  local ground = 200

  if self.currentMove then
    self.currentMove.update(self, dt)
    self.moveTime = self.moveTime + dt
    if self.moveTime > self.currentMove.duration then
      self.currentMove = nil
    end
  else
    if input.uppercut == 1 then
      self.currentMove = uppercut
      self.moveTime = 0
      return
    end

    -- horizontal
    local accel = dt * self.acceleration * (
      (input.left and -1 or 0) + (input.right and 1 or 0)
    )

    if accel < 0 then self.facingRight = false end
    if accel > 0 then self.facingRight = true end

    if not self.grounded then accel = accel / 3 end

    if accel * self.vx < 0 then
      if math.abs(self.vx) < 50 then
        self.vx = 0
      else
        self.vx = 0.9 * self.vx
      end
    end

    if accel == 0 and self.grounded then -- no input, start braking
      self.vx = 0.9 * self.vx
    else
      self.vx = self.vx + accel
    end

    if self.vx > self.maxSpeed then self.vx = self.maxSpeed end
    if self.vx < -self.maxSpeed then self.vx = -self.maxSpeed end

    -- vertical
    if self.grounded and input.jump == 1 then
      self.vy = -self.takeoff
      self.grounded = false
      self.airframes = 0
    elseif not self.grounded then
      self.airframes = self.airframes + 1
      self.vy = self.vy + self.gravity * dt

      if input.jump == 0
      and self.vy < -self.overshoot
      and self.airframes > self.minjump then
        self.vy = -self.overshoot
      end
    end
  end

  local dx = self.vx * dt
  local dy = self.vy * dt
  self.x = self.x + dx
  self.y = self.y + dy

  -- "collision"
  if self.y >= ground then
    self.grounded = true
    self.vy = 0
    self.y = ground
  end
end

function action:draw()
  local radius = 10
  local diameter = radius * 2
  love.graphics.setColor(128, 128, 128)
  love.graphics.rectangle('fill',
    self.x - radius, self.y - diameter,
    diameter, diameter)

  love.graphics.setColor(0, 0, 128)
  local sign = self.facingRight and 1 or -1
  love.graphics.rectangle('fill',
    self.x + (radius - 2) * sign, self.y - (diameter - 2),
    sign * -3, 3)
end

return action
