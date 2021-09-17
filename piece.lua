local _m = {}

local popupLayer

function _m.new( options )
    local group = display.newGroup()

    local x = options.x
    local y = options.y
    local size = options.size
    local colors = options.colors or { 244/255, 244/255, 244/255 }
    local isCurrent = options.isCurrent

    local rect = display.newRect( group, x, y, size, size )
    rect:setFillColor( unpack( colors ) )
    if isCurrent then
        local currentColors = {}
        for i, _ in pairs( colors ) do
            -- TODO: レベルに応じて色の変化具合を変える
            currentColors[i] = colors[i] - 0.05
        end
        rect:setFillColor( unpack( currentColors ) )
    end

    if options.parent then
        options.parent:insert( group )
    end

    rect:addEventListener( "tap", function( event )
        if popupLayer then
            return
        end

        popupLayer = display.newGroup()
        popupLayer:addEventListener( "tap", function(e)
            return true
        end )

        local popupFilter = display.newRect( popupLayer, constants._W * 0.5, constants._H * 0.5, constants._W, constants._H )
        popupFilter:setFillColor( 0, 0.8 )

        display.newRect( popupLayer, constants._W * 0.5, constants._H * 0.5, 300, 150 )

        display.newText {
            parent = popupLayer,
            text = isCurrent and "正解です" or "不正解です",
            x = constants._W * 0.5,
            y = constants._H * 0.5,
            fontSize = 20,
        }:setFillColor( 0.3 )

        local function onClose()
            if popupLayer then
                display.remove( popupLayer )
                popupLayer = nil
            end
        end

        local closeBtn = widget.newButton{
            x = constants._W * 0.5,
            y = constants._H * 0.5 + 100,
            label = "閉じる",
            onEvent = onClose
        }
        popupLayer:insert( closeBtn )

        if options.parent then
            options.parent:insert( popupLayer )
        end

        return true
    end )

    return group
end

return _m