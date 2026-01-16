--[[
	Simple Space Invaders Game
]]

-- Global 
love.graphics.setDefaultFilter('nearest','nearest')
enemies_con = {}
enemies_con.enemies = {}
enemy = {}
enemies_con.image = love.graphics.newImage('enemy.png')

-- Loaded at the start of the game
function love.load()
  -- Game outcomes
	game_lose = false 
  game_win = false 

  -- Player 
	player = {}
	player.x = 0
	player.y = 89
	player.image = love.graphics.newImage('player.png')
	
	-- Bullets 
	player.bullets = {}
  player.shootCoolDown = 0
	player.shoot = 
	function()
    if player.shootCoolDown <= 0 then 
      player.shootCoolDown = 25
  		bullet = {}
  		bullet.x = player.x + 4
  		bullet.y = player.y + 2
  		table.insert(player.bullets, bullet)
    end
  end
    
  -- Spawns each enemy
  for i=0, 8 do 
    enemies_con:spawner(i * 15, 0)
  end
end
  
  -- Function for the enemy 
  function enemies_con:spawner(x, y)
    enemy = {}
    enemy.x = x
    enemy.y = y
    enemy.height = 10
    enemy.width = 10
    enemy.bullets = {}
    enemy.cooldown = 25
    enemy.speed = .1
    table.insert(self.enemies, enemy)
  end

  -- More functions 
  function enemy:shoot()
    if self.shootCoolDown < 0 then 
      self.shootCoolDown = 25
      bullet = {}
      bullet.x = self.x + 4
      bullet.y = self.y + 2
      table.insert(self.bullets, bullet)
    end
  end 

-- If bullet hits the enemeny, it is removed from the table
function Collisions(enemies, bullets)
  for i,e  in ipairs(enemies) do
    for _, b in pairs(bullets) do
      if b.y <= e.y + e.height and b.x > e.x and b.x < e.x + e.width then
        table.remove(enemies, i)
      end
    end
  end
end

-- Used to update the state of the game every frame 
function love.update(dt)
	-- Right key -> Goes right
  -- Left key - > Goes left
	if love.keyboard.isDown("right") then
		player.x = player.x + 1
	elseif love.keyboard.isDown("left") then
		player.x = player.x - 1
	end

  -- Up key -> Shoots
	if love.keyboard.isDown("up") then
		player.shoot()
	end

  -- Used to shoot upwards
  player.shootCoolDown = player.shootCoolDown - 1

  -- If the bullet is passed y (-5) then it is removed from the table (to save memory)
	for i,b in ipairs(player.bullets) do
		if b.y < -5 then
      table.remove(player.bullets, i)
    end
    b.y = b.y - 1
	end

  -- If the enemies have passed y, you have lost 
  for _,e in pairs(enemies_con.enemies) do
    if e.y >= love.graphics.getHeight()/6 then 
      game_lose = true
    end
    e.y = e.y + enemy.speed
  end

  -- If enemies == 0, you have won!
  if #enemies_con.enemies == 0 then 
    game_win = true 
  end

  -- Collision function is called here
  Collisions(enemies_con.enemies, player.bullets)
end


-- Used to draw on the screen every frame 
function love.draw()
	-- Scales  all graphics by input entered
	love.graphics.scale(6)

	-- Player Style 
	love.graphics.setColor(255, 255, 225)
	love.graphics.draw(player.image, player.x, player.y)

	-- Bullet Styles
	love.graphics.setColor(255, 0, 0)
	for _,b in pairs(player.bullets) do
		love.graphics.rectangle("fill", b.x, b.y, 2, 2)
	end

	-- Enemy Style
	love.graphics.setColor(255, 255, 225)
  for _, e in pairs (enemies_con.enemies) do 
    love.graphics.draw(enemies_con.image, e.x, e.y)
  end

  -- Prints out if you have won or lost
  if game_lose then 
    love.graphics.print("You Lost!")
  elseif game_win then 
    love.graphics.print("You Won!")
  end
end
