function newTimer(cb, max)
	local min = 0
	return function(dt)
		min = min + dt
		if min > max then
			min = 0
			cb(dt)
		end
	end
end

function newRandomVector(vMin, vMax)
	return function()
		return vmath.vector3(
			math.random(vMin.x, vMax.x),
			math.random(vMin.y, vMax.y),
			math.random(vMin.z, vMax.z)
		)
	end
end

function router(matcher)
	local listeners = {}
	local r = {}
	if matcher == nil then 
		matcher = function (h, id)
			if id == nil then return nil end
			return h[id]
		end
	end
	r = {
		on = function(msg_id, cb)
			listeners[msg_id] = cb
			return r
		end,
		proc = function(message_id, message, sender)
			local cb = matcher(listeners, message_id, message, sender)
			if cb ~= nil then cb(message, sender) end
			return r
		end
	}
	return r
end

function finiteStateMachine(startState)
	local states = {}
	local newState = startState
	local activeState = startState
	local changeState = function (state)
		newState = state
	end
	local fsm = {}
	fsm = {
		changeState = changeState,
		add = function (name, init, update, final)
			states[name] = {
				name = name,
				init = init,
				update = update,
				final = final,
			}
			if activeState == name then
				init(changeState)
			end
			return fsm
		end,
		proc = function (...)
			print(activeState)
			local state = states[activeState]
			if state.update ~= nil then
				state.update(changeState, ...)
			end
			if newState ~= activeState then
				if state.final ~= nil then
					state.final(...)
				end
				state = states[newState]
				if state.init ~= nil then
					state.init(changeState, ...)
				end
				activeState = newState
			end
			return fsm
		end
	}
	return fsm
end

function head(table)
	return table[0]
end
function tail(table)
	return table[#table]
end
function quaterion_to_radians(quat)
	return 2 * math.acos(quat.w)
end
function kek(x, a, b, c, d, e)
	return function ()
		return x(a, b, c, d, e)
	end
end
function circular_shift_char(char, n)
	n = n % 4
	local c = bit.lshift(char, n)
	local d = bit.rshift(char, (4 - n))
	return bit.band(bit.bor(c, d), 0xF)
end
-- находится ли точка x y над объектом по селектору.
-- Если у объекта какое-то кастомное имя спрайта
-- нужно указать селектор спрайта этого объекта
-- по дефолту берется объект из которого вызывается функция
-- а имя спрайта sprite
function pick_node(x, y, selector, sprite_selector)
	if selector == nil then
		selector = "."
	end
	if sprite_selector == nil then
		sprite_selector = "#sprite"
	end
	local spritePos = go.get_world_position(selector)
	local scale = go.get_scale(selector)
	local size = go.get(sprite_selector, "size")
	local rightBoundary = spritePos.x - (size.x * scale.x) / 2
	local leftBoundary = spritePos.x + (size.x * scale.x) / 2
	local upperBoundary = spritePos.y + (size.y * scale.y) / 2
	local downBoundary = spritePos.y - (size.y * scale.y) / 2
	if x >= rightBoundary and x <= leftBoundary and y >= downBoundary and y <= upperBoundary then
		return true
	end
	return false
end

function ring(...)
	local t = {...}
	local cur = 1
	return {
		ring = t,
		cur = function() return t[cur] end,
		hash = function() return hash(t[cur]) end,
		prev = function()
			cur = cur - 1
			if cur <= 0 then
				cur = #t
			end
			return t[cur]
		end,
		next = function()
			cur = cur + 1
			if cur > #t then
				cur = 1
			end
			return t[cur]
		end
	}
end