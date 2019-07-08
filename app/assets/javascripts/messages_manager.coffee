class MessagesManager
  ui:
    addMessageLink: "[data-behavior='new_item_link']"
    cancelButton: "[data-behavior='cancel_button']"
    form: "[data-behavior='form']"

  constructor: ->
    @_bindEvents()

  _bindEvents: =>
    $(document).on "ajax:success", @ui.addMessageLink, @_hideMessageLink
    $(document).on "ajax:success", @ui.cancelButton, @_removeForm
    $(document).on "ajax:success", @ui.form, @_removeForm

  _hideMessageLink: (event) =>
    divAppendTo = $(event.target).closest('div.message-item')
    $(@ui.addMessageLink).closest('div').hide()

  _removeForm: (event) =>
    divToShow = $(event.target).closest('div.message-item').children('div.message-body')
    form = $(event.target).closest('div.message-body').remove()
    $(divToShow).show()

new MessagesManager
