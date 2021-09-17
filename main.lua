display.setStatusBar( display.HiddenStatusBar )

widget = require('widget')
constants = require('constants')

local piece = require('piece')

local gameLayer = display.newGroup()

local bg = display.newRect( gameLayer, constants._W * 0.5, constants._H * 0.5, constants._W, constants._H )
bg:setFillColor( 0.8 )

local title = display.newText {
    parent = gameLayer,
    text = "脳トレ！色間違い探しゲーム",
    x = constants._W * 0.5,
    y = 50,
    font = native.systemFontBold,
    fontSize = 20,
}
title:setFillColor( 0.2 )

local btnLayer = display.newGroup()
gameLayer:insert( btnLayer )


-- TODO: pieceの位置を自動計算する方式に直す
local piecePositions = {}
piecePositions[1] = { x = 100, y = 200 }
piecePositions[2] = { x = 200, y = 200 }
piecePositions[3] = { x = 100, y = 300 }
piecePositions[4] = { x = 200, y = 300 }

-- TODO: レベルに応じてpieceの数を変える
local pieceNum = 4

local playLayer
local function createGame()
    if playLayer then
        display.remove(playLayer)
        playLayer = nil
    end

    playLayer = display.newGroup()
    gameLayer:insert( playLayer )

    local description = display.newText {
        parent = playLayer,
        text = "色が違うところをあててね",
        x = constants._W * 0.5,
        y = 100,
        fontSize = 16,
    }
    description:setFillColor( 0.2 )

    local answerIndex = math.random( 1, pieceNum )
    local colors = { math.random(), math.random(), math.random() }
    for i = 1, pieceNum do
        local piecePosition = piecePositions[i]
        piece.new {
            parent = playLayer,
            x = piecePosition.x,
            y = piecePosition.y,
            size = 50,
            colors = colors,
            isCurrent = i == answerIndex,
        }
    end
end

local start = widget.newButton {
    x = constants._W * 0.5,
    y = constants._H - 150,
    label = "スタート",
    onEvent = createGame,
}
btnLayer:insert( start )
