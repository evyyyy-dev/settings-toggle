# Dynamic Settings Toggle System
> An easily expandable settings system featuring toggleable switches.
---

## Features

**Settings System**
- Toggleable switches using TweenService
- Debounces (to avoid spamming buttons breaking anything)
- Easily expandable

**Current Toggles**
- Main switch (reflects the state of its sub-switches)
- SFX Toggle
- Music Toggle

---

## Showcase
[![Watch showcase](https://img.youtube.com/vi/SDhJ6cuWIA8/0.jpg)](https://www.youtube.com/watch?v=SDhJ6cuWIA8)

---

## Architecture

```
Workspace
 ├─ Songs
 │   └─ (list of songs)
 └─ (objects with Sounds tagged "SFX")    │ For example, a cricket playing a chirping sound which has the tag "SFX".


ReplicatedStorage
 └─ Modules
     ├─ Settings                          │ Handles switch state logic, synchronization between main and sub-switches, and calls Animation and Sound modules when state changes.
     ├─ Sound                             │ Manages music playlists and toggles sound effects by controlling sounds tagged "SFX".
     └─ Animation                         │ Handles UI tweening for switches and sliders.


 StarterGui
 └─ SettingsUI
     ├─ MainFrame
     │   └─ SwitchesContainer
     │       ├─ MainSwitch                │ Reflects the state of its sub-switches, so if all are off it turns them on, otherwise it turns them all off.
     │       │    └─ Switch               │ The clickable button that triggers toggle behavior and communicates state changes to the Settings module.
     │       │        └─ Slider           │ The visual element that smoothly transitions using TweenService when the switch is toggled.
     │       ├─ MusicSwitch               │ One of the sub-switches. Toggles just like the main switch, but has a different function.
     │       │    └─ Switch
     │       │        └─ Slider
     │       └─ EffectsSwitch
     │            └─ Switch
     │                └─ Slider
     └─ ToggleButton


StarterPlayerScripts
 └─ SettingsController
```

#### System flow

- When a player presses the ToggleButton, the SettingsController opens/closes the SettingsUI.

- When a player clicks a switch, the Settings module updates the state and runs the behavior defined in the `bindings` table.

- The Animation module is called by the Settings module to tween the Switch and Slider to their correct visual state.

- Toggling the MusicSwitch will mute or restore the playlist located in Workspace.Songs.

- The EffectsSwitch determines the mute state of  all sounds tagged "SFX".

- When the MainSwitch is toggled, it updates the staste of all sub-switches and triggers their respective sound behavior.

---

## Code snippets

Check out [code-snippets.lua](code-snippets.lua) for code examples.

---

## Why I Made This

This was my third big Roblox system, which I built to improve my understanding of modular system design and UI interaction.

Like some of my earlier projects, it was also inspired by a friend’s project, but I wanted to take the concept further with cleaner structure and better user experience. I planned on creating something smooth to use and visually responsive through tweens and clear UI.

## What I Learned

With this project, I deepened my understanding of dictionaries and gained experience in structuring code across multiple ModuleScripts instead of one big LocalScript and ServerScript.

I also improved in using TweenService for UI animation by a bit, and learned how to format my scripts with comments to make them easier to scan.

## What I'd Improve

In future versions, I’d refactor the main switch into its own dedicated module for better scalability, since it handles a lot at once.

I'd also consider expanding the system beyond simple toggle switches, for example by adding sliders, text input, or categorizing them, basically turning it from a basic toggle-system into a full settings framework.

---

> **Status:** Completed, but plans for future improvement exist. I’d like to revisit and expand it when I have time.
