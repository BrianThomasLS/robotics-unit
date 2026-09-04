local orenMode = true

local rotateMode = false
local rotateOffset = .25
local boomOffset = -11

local scaryMode = false

function onCreate()
    if not orenMode then
        close(false)
    end
end

function onCreatePost()
    makeLuaSprite("yu", "yu")
    setObjectCamera("yu", "other")
    screenCenter("yu")
    addLuaSprite("yu")
    setProperty("yu.visible", false)

    setProperty("uiGroup.alpha", .0)

    setProperty("camZooming", false)
end

function onBeatHit()
    if curBeat == 36 then
        doTweenAlpha("uGAlTw" .. curBeat, "uiGroup", 1, 1.0, "linear")
    elseif curBeat == 100 then
        doTweenAlpha("cHAlTw" .. curBeat, "camHUD", 1, 1.0, "linear")
        doTweenAlpha("cmUAlTw" .. curBeat, "UpperBar(With HUD)", 1, .5, "linear")
        doTweenAlpha("cmLAlTw" .. curBeat, "LowerBar(With HUD)", 1, .5, "linear")
        rotateMode = true
    elseif curBeat == 163 then
        setProperty("camHUD.alpha", .0)
        setProperty("UpperBar(With HUD).alpha", .0)
        setProperty("LowerBar(With HUD).alpha", .0)
        setProperty("yu.visible", true)
    elseif curBeat == 164 then
        doTweenAlpha("cHAlTw" .. curBeat, "camHUD", 1, 1.0, "linear")
        doTweenAlpha("cmUAlTw" .. curBeat, "UpperBar(With HUD)", 1, .5, "linear")
        doTweenAlpha("cmLAlTw" .. curBeat, "LowerBar(With HUD)", 1, .5, "linear")
        removeLuaSprite("yu")
        rotateMode = false
    elseif curBeat == 180 then
        setProperty("uiGroup.alpha", .0)
    elseif curBeat == 181 then
        setProperty("uiGroup.alpha", 1.0)
    elseif curBeat == 194 then
        setProperty("uiGroup.alpha", .0)
    elseif curBeat == 196 then
        setPropertyFromClass("openfl.Lib", "application.window.title", "")
        scaryMode = true
    elseif curBeat == 211 then
        setPropertyFromClass("openfl.Lib", "application.window.title", "GET")
    elseif curBeat == 212 then
        setPropertyFromClass("openfl.Lib", "application.window.title", "GET DOWN")
    elseif curBeat == 220 then
        setPropertyFromClass("openfl.Lib", "application.window.title", "")
    elseif curBeat == 228 then
        setPropertyFromClass("openfl.Lib", "application.window.title", "A")
        scaryMode = false
    elseif curBeat == 229 then
        setPropertyFromClass("openfl.Lib", "application.window.title", "AKA")
    elseif curBeat == 230 then
        setPropertyFromClass("openfl.Lib", "application.window.title", "AKAGE")
    elseif curBeat == 232 then
        doTweenAlpha("uGAlTw" .. curBeat, "uiGroup", 1, 1.0, "linear")
    elseif curBeat == 260 then
        doTweenAlpha("uGAlTw" .. curBeat, "uiGroup", .0, 1.0, "linear")
    elseif curBeat == 284 then
        doTweenAlpha("uGAlTw" .. curBeat, "uiGroup", 1, 1.0, "linear")
    elseif curBeat == 356 then
        doTweenAlpha("uGAlTw" .. curBeat, "uiGroup", .0, 1.0, "linear")
    elseif curBeat == 371 then
        doTweenAlpha("uGAlTw" .. curBeat, "uiGroup", 1, 1.0, "linear")
        rotateMode = true
    elseif curBeat == 403 then
        setProperty("camHUD.alpha", .0)
        setProperty("UpperBar(With HUD).alpha", .0)
        setProperty("LowerBar(With HUD).alpha", .0)
        rotateMode = false
    elseif curBeat == 406 then
        doTweenAlpha("cHAlTw" .. curBeat, "camHUD", 1, .2, "linear")
    elseif curBeat == 411 then
        doTweenAlpha("cmUAlTw" .. curBeat, "UpperBar(With HUD)", 1, .5, "linear")
        doTweenAlpha("cmLAlTw" .. curBeat, "LowerBar(With HUD)", 1, .5, "linear")
        rotateMode = true
    elseif curBeat == 435 then
        doTweenAlpha("uGAlTw" .. curBeat, "uiGroup", .0, 1.0, "linear")
    elseif curBeat == 439 then
        doTweenAlpha("cHAlTw" .. curBeat, "camHUD", .0, 1.0, "linear")
    end

    if rotateMode then
        cancelTween("cHAgTw")
        cancelTween("cHScYTw")
        rotateOffset = -rotateOffset
        setProperty("camHUD.angle", rotateOffset)
        if scaryMode then
            setProperty("camHUD.scroll.y", boomOffset + 10)
        else
            setProperty("camHUD.scroll.y", boomOffset)
        end
        doTweenAngle("cHAgTw", "camHUD", 0, 0.2, "linear")
        doTweenY("cHScYTw", "camHUD.scroll", 0, 0.2, "linear")
    end
end

function onStepHit()
    if curStep == 384 then
        setProperty("camHUD.alpha", .0)
        setProperty("UpperBar(With HUD).alpha", .0)
        setProperty("LowerBar(With HUD).alpha", .0)
    end
end

---
--- @param elapsed float
---
function onUpdate(elapsed)
    if scaryMode then
        cameraShake("game", 0.0075, 0.1)
        cameraShake("hud", 0.007, 0.1)
    end
end