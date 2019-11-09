-- типы труб
function getType(t)
	if t == hash("L") then
		return "L"
	elseif t == hash("I") then
		return "I"
	elseif t == hash("T") then
		return "T"
	elseif t == hash("X") then
		return "X"
	end
end

-- вот место этого нужна функа в которой по радианам можно получить куда повернут объект
-- это полная муть
function getRadianDirection(dir)
	if dir == hash("top") then
		return 1.57
	elseif dir == hash("down") then
		return -1.57
	elseif dir == hash("right") then
		return 0
	elseif dir == hash("left") then
		return 3.14
	end
end

function rotate(angle, without_animation)
	local q = vmath.quat_rotation_z(angle)
	if without_animation then 
		go.set(".", "rotation", q)
	else
		go.animate(".", "rotation", go.PLAYBACK_ONCE_FORWARD, q,  go.EASING_LINEAR, 0.1) -- 1 is speed
	end
end