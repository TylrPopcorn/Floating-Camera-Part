task.wait(math.random(1,4))
--This code will allow any part to float up and down and rotate side to side at any angle.
--This can be used for camera manipulation if wanted.
-- 3/5/24
local TweenService = game:GetService("TweenService")
--
local part = script.Parent

------------------------------			----------------------------------------
--
-- MOVE THE PART UP & DOWN
spawn(function()
	-- Define the initial position and the height of the movement
	local initialPosition = part.Position
	local height = 0.2 -- Adjust this value to control the height of the movement

	-- Create a loop to continuously animate the part
	while true do
		task.wait()

		-- Create a TweenInfo object to define the properties of the tween
		local tweenInfo = TweenInfo.new(
			6, -- Duration (in seconds) of the tween
			Enum.EasingStyle.Linear, -- Easing style of the tween
			Enum.EasingDirection.InOut, -- Easing direction of the tween
			-1, -- Number of repetitions (-1 means infinite)
			true -- Whether the tween should repeat automatically
		)

		-- Define the properties to tween
		local properties = {
			Position = initialPosition + Vector3.new(0, height, 0), -- Move the part up by 'height'
		}

		-- Create the tween
		local tween = TweenService:Create(part, tweenInfo, properties)

		-- Start the tween
		tween:Play()

		-- Wait for the tween to complete
		tween.Completed:Wait()

		-- Reverse the direction of movement for the next iteration
		height = -height
	end
end)
--
--

-- MOVE THE PART SIDE TO SIDE
spawn(function()
	local moveNumb = 1 --How far the part will move to the side.
	--[NOTE]: Not sure how well it works when you go below 1.
	
	local function rotatePart(part, angle)
		-- This function will rotate the part smoothly
		local initialRotation = part.Orientation -- original part rotation.
		local targetRotation = initialRotation + Vector3.new(0, angle, 0)

		local tweenInfo = TweenInfo.new(
			6, -- Duration (in seconds) of the tween
			Enum.EasingStyle.Linear,
			Enum.EasingDirection.Out,
			0,
			false
		)

		-- Create the tween
		local tween = TweenService:Create(part, tweenInfo, {Orientation = targetRotation})
		tween:Play() -- Play the tween
		tween.Completed:Wait() -- Wait for the tween to complete
	end

	-- Create a loop to continuously animate the part
	while true do
		task.wait()
		
		-- Rotate rightwards
		rotatePart(part, -moveNumb)

		-- Rotate leftwards
		local nextVal = -moveNumb + (moveNumb * 3)
		rotatePart(part, nextVal)

		-- Rotate rightwards again
		rotatePart(part, -moveNumb)
	end
end)
--
--
