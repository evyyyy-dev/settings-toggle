-- ============================= --
-- Settings Toggle System (Snippet)
-- This snippet demonstrates animation debounce handling, the syncing of the main switch and the toggling itself.
-- =========================================================================================================== --

-- Plays animations and handles its debounces.
function Animation.PlayAnimation(switchButton, state)
	local name = switchButton.Name
	pendingStates[name] = state
	if Animation.switchDebounces[name] then return end
	Animation.switchDebounces[name] = true

	task.spawn(function()
		while pendingStates[name] ~= nil do
			local targetState = pendingStates[name]
			pendingStates[name] = nil

			local button = switchButton:FindFirstChild("Switch")
			local slider = button:FindFirstChild("Slider")

			if not button then warn("[Animation] Button not found!") return end
			if not slider then warn("[Animation] Slider not found!") return end

			playToggleTweens(button, slider, targetState)
		end
		Animation.switchDebounces[name] = false
	end)
end

-- Syncs the main switch to reflect its sub-switches' state.
local function syncMainSwitch()
	local shouldBeOn = anyChildOn()
	if switchedOptions.MainSwitch == shouldBeOn then return end

	switchedOptions.MainSwitch = shouldBeOn
	task.spawn(function()
		while Animation.switchDebounces.MainSwitch do
			task.wait()
		end
		Animation.PlayAnimation(switches.MainSwitch, shouldBeOn)
	end)
end

-- Toggles each clicked switch, with special functionality for the main switch.
function Settings.SwitchPanel(switchButton)
	local name = switchButton.Name

	if name == "MainSwitch" then
		local turnOn = not anyChildOn()
		for key in pairs(switchedOptions) do
			if key == "MainSwitch" then continue end
			setSingle(key, turnOn)
		end
		syncMainSwitch()
	else
		setSingle(name, not switchedOptions[name])
		syncMainSwitch()
	end
end
