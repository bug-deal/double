local action = require('action')
local input = require('input')

local canvas
local scale = 3
local width, height = 320, 240

function love.load()
  canvas = love.graphics.newCanvas(width, height)
  canvas:setFilter('nearest')
  love.window.setMode(width * scale, height * scale)
end

function love.draw()
  love.graphics.setCanvas(canvas)
  love.graphics.clear(0, 0, 0)
  action:draw()

  love.graphics.setCanvas()
  love.graphics.setColor(255, 255, 255)
  love.graphics.draw(canvas, 0, 0, 0, scale, scale)
end

function love.update(dt)
  input:update()
  action:update(dt)
end
