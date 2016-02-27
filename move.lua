local uppercut = {
  duration = 25 / 60,
  update = function(character, dt)
    local frame = character.moveTime * 60
    local sign = character.facingRight and 1 or -1

    if frame < 7 then
      -- scoot horizontally
      character.vx = sign * 1000
      character.vy = -30
    else
      -- go up and a little horizontally
      character.vx = sign * 20
      character.vy = -350
      character.grounded = false
    end
  end
}

return uppercut
