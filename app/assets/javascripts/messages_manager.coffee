class MessagesManager
  ui:
    addMessageLink: "[data-behavior='new_item_link']"
    cancelButton: "[data-behavior='cancel_button']"

  constructor: ->
    @_bindEvents()

  _bindEvents: =>
    $(document).on "ajax:success", @ui.addMessageLink, @_hideMessageLink
    $(document).on "ajax:success", @ui.cancelButton, @_hideForm

  _hideMessageLink: (event) =>
    divAppendTo = $(event.target).closest('div.message-item')
    $(@ui.addMessageLink).closest('div').hide()
    @_showMessageForm(divAppendTo)

  _showMessageForm: (divAppendTo) =>
    form = $(divAppendTo).children('div.message-body-form')
    $(form).show()

  _hideForm: (event) =>
    divToShow = $(event.target).closest('div.message-item').children('div.message-body')
    $(event.target).closest('div.message-body-form').hide()
    $(divToShow).show()

new MessagesManager
