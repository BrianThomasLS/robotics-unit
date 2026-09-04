local BGscaleX = -700
local BGscaleY = -270
local BGsize = 3500
local BGsizeY = 2000
local akageTxtsize = 250
local dropit_scale = 1.6

function onCreate()
    setProperty('skipCountdown', true)
	setProperty('showRating', false)
	setProperty('showComboNum', false)
	setPropertyFromClass('openfl.Lib', 'application.window.title', 'AKAGE')
	
	makeLuaSprite('BG', nil, BGscaleX - 200,BGscaleY)
	makeGraphic('BG', BGsize, BGsize, '51c7e3')
	addLuaSprite('BG')
	setProperty("BG.alpha", 0)

	makeLuaSprite('whitee', nil, BGscaleX, BGscaleY)
	makeGraphic('whitee', BGsize, BGsizeY, 'FFFFFF')
	addLuaSprite('whitee')
	setScrollFactor('whitee', 0, 0)
	setProperty("whitee.visible", false)

	makeAnimatedLuaSprite('fuckya', 'reed', 71, -180)
	addAnimationByPrefix('fuckya', 'red', 'reed', 30, false)
	scaleObject('fuckya', 1.3, 1.8)
	setObjectCamera("fuckya", "game")
	setScrollFactor('fuckya', 1, 0)
	addLuaSprite('fuckya')
	setProperty("fuckya.visible", false)

	makeLuaSprite('mikuBG', nil, BGscaleX - 200, BGscaleY)
	makeGraphic('mikuBG', BGsize, BGsizeY, '245466')
	addLuaSprite('mikuBG')
	setProperty("mikuBG.alpha", 0)

	makeLuaSprite('black', nil, BGscaleX, BGscaleY)
	makeGraphic('black', BGsize, BGsizeY, 'BE2B44')
	addLuaSprite('black', true)
	setProperty("black.visible", false)

	makeLuaSprite('dark', nil, BGscaleX, BGscaleY)
	makeGraphic('dark', BGsize, BGsizeY, '000000')
	screenCenter("dark")
	addLuaSprite('dark')
	setProperty("dark.visible", false)

	makeLuaSprite('white', nil, BGscaleX, BGscaleY)
	makeGraphic('white', BGsize, BGsizeY, 'FFFFFF')
	setObjectCamera("white", "other")
	addLuaSprite('white')
	setProperty("white.visible", false)

	makeLuaText('akageTxt', 'AKAGE', akageTxtsize * 3)
	setTextFont('akageTxt', 'NovaMono-Regular.ttf')
	setObjectCamera("akageTxt", "other")
	setTextColor('akageTxt', 'cc6a75')
	setTextBorder('akageTxt', 0, "")
	setTextSize('akageTxt', akageTxtsize)
	screenCenter('akageTxt')
	addLuaText('akageTxt')
	setProperty("akageTxt.visible", false)

    makeLuaSprite('ahhh', 'ahhh')
	screenCenter('ahhh')
	setObjectCamera("ahhh", "other")
	setObjectOrder('ahhh', 0)
    addLuaSprite('ahhh')
	setProperty("ahhh.visible", false)

	makeLuaSprite('pearto', 'pearto')
	screenCenter('pearto')
	setObjectCamera("pearto", "other")
	setObjectOrder('pearto', 0) 
    addLuaSprite('pearto')
	setProperty("pearto.visible", false)

	makeLuaSprite('dropit2', 'dropit', 50, -60)
	setObjectCamera("dropit2", "game")
    scaleObject('dropit2', dropit_scale - 0.2, dropit_scale)
    addLuaSprite('dropit2', true)
	setScrollFactor('dropit2', 0.1, 0.2)
	setProperty("dropit2.visible", false)

	makeAnimatedLuaSprite('getdown', 'getdown', -150, -80)
	addAnimationByPrefix('getdown', 'get', 'get0', 24)
	addAnimationByPrefix('getdown', 'getdown', 'getdown0', 24)
	scaleObject('getdown', 1.4, 1.7)
	setObjectCamera("getdown", "game")
	setScrollFactor('getdown', 0, 0)
	addLuaSprite('getdown')
	setProperty("getdown.visible", false)
end

function onStepHit()
	if curStep == 1 then
		objectPlayAnimation('get', 'getdown', true)
		setProperty('boyfriend.color', getColorFromHex('000000'))
		setProperty('dad.color', getColorFromHex('000000')) 
	elseif curStep == 144 then
		setProperty('boyfriend.color', getColorFromHex('FFFFFF'))
		setProperty('dad.color', getColorFromHex('FFFFFF')) 
	elseif curStep == 384 then
		setProperty("black.visible", true)
		setProperty("ahhh.visible", true)
	elseif curStep == 400 then
		removeLuaSprite('ahhh', true)
		setProperty("black.visible", false)
		setProperty("whitee.visible", true)
		setProperty("fuckya.visible", true)
	elseif curStep == 524 then
		setProperty("dropit2.visible", true)
	elseif curStep == 528 then
		setProperty("dropit2.visible", false)
		--setProperty("fuckya.x", 790)
	elseif curStep == 654 then
		setProperty("whitee.visible", false)
		setProperty("fuckya.visible", false)
	elseif curStep == 720 then
		setProperty("black.visible", true)
		setProperty("pearto.visible", true)
	elseif curStep == 725 then
		--removeLuaSprite('pearto', true)
	elseif curStep == 726 then
		setProperty("black.visible", false)
		removeLuaSprite('pearto', true)
	elseif curStep == 780 then
		setProperty("dropit2.visible", true)
	elseif curStep == 784 then
		setProperty("dark.visible", true)
		setProperty("boyfriend.visible",false)
		setProperty("dropit2.visible", false)
	elseif curStep == 844 then
		setProperty("getdown.visible", true)
	elseif curStep == 848 then
		objectPlayAnimation('getdown', 'getdown', true)
		doTweenX('getdown', 'getdown.scale', 1.7, 1.5, 'ExpoOut')
		doTweenY('getdown1', 'getdown.scale', 0.9, 1.5, 'ExpoOut')
	elseif curStep == 850 then
		doTweenAlpha("getdown2", "getdown", 0, 0.5, "QuadOut")
	elseif curStep == 908 then
		removeLuaSprite('dark', true)
		setProperty("boyfriend.visible",true)
	elseif curStep == 1040 then
		setProperty("boyfriend.visible", false)
		doTweenAlpha("aquaBG", "BG", 4, 10, "cubeOut")
		setProperty("defaultCamZoom", 0.9)
		if middlescroll or getPropertyFromClass('backend.ClientPrefs', 'data.middleScroll') then
            noteTweenAlpha('outtaHere1Tween', 0, 0, 0.4, 'linear')
            noteTweenAlpha('outtaHere2Tween', 1, 0, 0.4, 'linear')
            noteTweenAlpha('outtaHere3Tween', 2, 0, 0.4, 'linear')
            noteTweenAlpha('outtaHere4Tween', 3, 0, 0.4, 'linear')
		end
    elseif curStep == 1231 then
		setProperty('dropit2.x', -13)
		setProperty('dropit2.y', 8)
		setObjectCamera("dropit2", "hud")
		setObjectOrder('dropit2', 0) 
		scaleObject('dropit2', 1.5, 1.3)

		doTweenAlpha("mikuBG", "mikuBG", 1, 1, "cubeOut")
		doTweenAlpha("mikuBG", "mikuBG", 1, 200.0, "cubeOut")

		doTweenAlpha("hud_hiding1", "healthBar", 0, 3, "quadIn")
		doTweenAlpha("hud_hiding2", "iconP1", 0, 3, "quadIn")
		doTweenAlpha("hud_hiding3", "iconP2", 0, 3, "quadIn")
		doTweenAlpha("hud_hiding4", "scoreTxt", 0, 3, "quadIn")
		doTweenAlpha("hud_hiding5", "timeBar", 0, 3, "quadIn")
		doTweenAlpha("hud_hiding6", "timeTxt", 0, 3, "quadIn")

		runHaxeCode([[
    		for (note in game.playerStrums)
        		FlxTween.tween(note, {alpha: 0}, 3, {ease: FlxEase.quadIn});
		]]);
    elseif curStep == 1480 then
		setProperty("dropit2.visible", true)
	elseif curStep == 1484 then
		setProperty("dropit2.visible", false)
		setProperty('mikuBG.visible', false)
		setProperty("whitee.visible", true)
		setProperty("fuckya.visible", true)

		setProperty("healthBar.alpha", 1)
		setProperty("iconP1.alpha", 1)
		setProperty("iconP2.alpha", 1)
		setProperty("scoreTxt.alpha", 1)
		setProperty("timeBar.alpha", 1)
		setProperty("timeTxt.alpha", 1)

		setProperty("boyfriend.visible",true)
		removeLuaSprite('BG', true)
		setProperty("defaultCamZoom", 0.7)

		runHaxeCode([[
    		for (note in game.playerStrums)
        		FlxTween.tween(note, {alpha: 1}, 1.0, {ease: FlxEase.quadIn});
		]]);

		if middlescroll or getPropertyFromClass('backend.ClientPrefs', 'data.middleScroll') then
            noteTweenAlpha('outtaMyWay1Tween', 0, 0.4, 0.4, 'linear')
            noteTweenAlpha('outtaMyWay2Tween', 1, 0.4, 0.4, 'linear')
            noteTweenAlpha('outtaMyWay3Tween', 2, 0.4, 0.4, 'linear')
            noteTweenAlpha('outtaMyWay4Tween', 3, 0.4, 0.4, 'linear')
		end
	elseif curStep == 1612 then
		setProperty("whitee.visible", false)
		setProperty("fuckya.visible", false)
	elseif curStep == 1645 then
		setProperty("whitee.visible", true)
		setProperty("fuckya.visible", true)
    elseif curStep == 1763 then
		setProperty("white.visible", true)
		setProperty("akageTxt.visible", true)
    end
end

function onBeatHit()
	if curStep >= 1484 then
		playAnim("fuckya", "red", true)
	end

	if curBeat == 360 then
		doTweenAlpha("lTAlTw", "lyric", .0, 3.0 / playbackRate, "linear")
	end
end

function onDestroy()
    setPropertyFromClass('openfl.Lib', 'application.window.title', 'Friday Night Funkin\': Psych Engine')
end