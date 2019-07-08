App.messages = App.cable.subscriptions.create { channel: 'MessagesChannel' },
  received: (data) ->
    @[data.action](data)

  create: (data) ->
    $(data.html).insertAfter($('#new_item'))
  
  update: (data) ->
    console.log('update action method')

  destroy: (data) ->
    $("#message_#{data.id}").remove()
