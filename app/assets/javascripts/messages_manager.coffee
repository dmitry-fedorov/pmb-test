class MessagesManager
  ui:
    addMessageLink: "[data-behavior='new_item_link']"
    cancelButton: "[data-behavior='cancel_button']"
    form: "[data-behavior='form']"

  constructor: ->
    @_bindEvents()

  _bindEvents: =>
    $(document).on "ajax:success", @ui.addMessageLink, @_hideMessageLink
    $(document).on "ajax:success", @ui.cancelButton, @_hideForm
    $(document).on "ajax:success", @ui.form, @_hideForm

  _hideMessageLink: (event) =>
    divAppendTo = $(event.target).closest('div.message-item')
    $(@ui.addMessageLink).closest('div').hide()
    @_showMessageForm(divAppendTo)

  _showMessageForm: (divAppendTo) =>
    form = $(divAppendTo).children('div.message-body-form')
    $(form).show()

  _hideForm: (event) =>
    divToShow = $(event.target).closest('div.message-item').children('div.message-body')
    form = $(event.target).closest('div.message-body-form')
    form.hide()
    form.find('textarea').val('')
    $(divToShow).show()

new MessagesManager
