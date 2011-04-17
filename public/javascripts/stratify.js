var Stratify = {};

Stratify.setup = function() {
  Stratify.setupLayers();
};

Stratify.setupLayers = function() {
  $('#layers input[type=checkbox]').click(function() {
    var dataSourceName = this.name;
    var activitySelectorForDataSource = '.' + dataSourceName;
    $(activitySelectorForDataSource).toggle();
  });
}