Stratify =
  setup: ->
    Stratify.setupLayers()
    Stratify.setTimeZoneCookie()

  setupLayers: ->
    $('#layers input[type=checkbox]').click ->
      dataSourceName = @name
      activitySelectorForDataSource = '.' + dataSourceName
      $(activitySelectorForDataSource).toggle()

  setTimeZoneCookie: ->
    timeZoneName = jstz.determine().name();
    document.cookie = 'time_zone=' + timeZoneName + ';'

jQuery ->
  Stratify.setup()
