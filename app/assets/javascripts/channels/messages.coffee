App.messages = App.cable.subscriptions.create { channel: 'MessagesChannel' },
  received: (data) ->
    @[data.action](data)

  create: (data) ->
    $(data.html).insertAfter($('#new_item'))
  
  update: (data) ->
    $("#message_#{data.id}").replaceWith(data.html)

  destroy: (data) ->
    $("#message_#{data.id}").remove()
