$(document).ready ->
  new GameSetup()

class GameSetup
  constructor: ->
    $("#introModal #playButton").click ->
      $(@).parents("#introModal").removeClass("active")
      $("#playerModal").addClass("active")

    $("#playerModal button").click ->
      $(@).parents("#playerModal").removeClass("active")
      playerTurn = $(@).val()
      game = new TicTacToeGame(playerTurn)
      game.play()

    $(".modal .playAgainButton").click ->
      location.reload()

class TicTacToeGame

  constructor: (playerTurn) ->
    @board = [[null, null, null], [null, null, null], [null, null, null]]
    @constants =
      playerTurn: parseInt(playerTurn)
      mDimensions: 3
      nDimensions: 3
      computerKey: 0
      playerKey: 1

  setupListeners: ->
    for i in [1..3]
      for j in [1..3]
        that = @
        ((a,b) ->
          $('.row-' + i + ' .col-' + j).click (event) ->
            $(@).html("X")
            that.board[a-1][b-1] = that.constants.playerKey
            that.updateBoard()

            if that.status()
              that.makeCpuMove()
            else
              that.executeModal("tieModal", 500)

        )(i,j)

  makeCpuMove: ->
    that = @
    $.ajax
      url: "/api/board_games/tic_tac_toe/cpu_makes_move"
      method: "POST"
      dataType: "JSON"
      data: "board_field=" + JSON.stringify(that.board),
      success: (message) ->
        message.data
        if message.data.status.game_over

          if message.data.status.winner_key is that.constants.computerKey
            that.board = message.data.board
            that.updateBoard()
            that.executeModal("loserModal", 1000)
          else
            that.executeModal("winnerModal", 1000)

          that.turnOff()
          that.showTicTacToe(message.data.status.tic_tac_toe_array)

        else
          that.board = message.data.board
          that.updateBoard()
          that.executeModal("tieModal", 500) unless that.status()

      error: (message) ->
        that.executeModal("errorModal", 0)

  updateBoard: ->
    for i in [1..@constants.mDimensions]
      for j in [1..@constants.nDimensions]
        if @board[i-1][j-1] is @constants.computerKey
          $('.row-' + i + ' .col-' + j).html("X")
          $('.row-' + i + ' .col-' + j).off()
          $('.row-' + i + ' .col-' + j).addClass("active")
        else if @board[i-1][j-1] is @constants.playerKey
          $('.row-' + i + ' .col-' + j).html("O")
          $('.row-' + i + ' .col-' + j).off()
          $('.row-' + i + ' .col-' + j).addClass("active")

  status: ->
    status = false
    for i in [1..@constants.mDimensions]
      for j in [1..@constants.nDimensions]
        if (@board[i-1][j-1] is null && status is false)
          status = true
    return status

  showTicTacToe: (array) ->
    for index in [0..array.length-1]
      i = (parseInt(array[index][0]) + 1).toString()
      j = (parseInt(array[index][1]) + 1).toString()
      $('.row-' + i + ' .col-' + j).addClass("tic-tac-toe")

  executeModal: (modalId, time) ->
    setTimeout ->
      $("#" + modalId).addClass("active")
    , time

  turnOff: ->
    for i in [1..@constants.mDimensions]
      for j in [1..@constants.nDimensions]
          $('.row-' + i + ' .col-' + j).off()

  play: =>
    @.setupListeners()

    if @.constants.playerTurn is 2
      @.makeCpuMove()
