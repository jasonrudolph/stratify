Stratify =
  setup: ->
    Stratify.setupLayers()

  setupLayers: ->
    $('#layers input[type=checkbox]').click ->
      dataSourceName = @name
      activitySelectorForDataSource = '.' + dataSourceName
      $(activitySelectorForDataSource).toggle()

jQuery ->
  Stratify.setup()
