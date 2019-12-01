
function rotate(angle, id, without_animation)
	if id == nil then id = "." end
	local q = vmath.quat_rotation_z(angle)
	if without_animation then 
		go.set(id, "rotation", q)
	else
		go.animate(id, "rotation", go.PLAYBACK_ONCE_FORWARD, q,  go.EASING_LINEAR, 0.1) -- 1 is speed
	end
end

function anim(name)
	return function ()
		msg.post("#sprite", "play_animation", {id = hash(name)})
	end
end

function ground_contact(self)
	return self.platypus.has_ground_contact()
end