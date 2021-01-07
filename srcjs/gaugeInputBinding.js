// Input binding
var f7GaugeBinding = new Shiny.InputBinding();

$.extend(f7GaugeBinding, {

  initialize: function(el) {
    // recover the inputId passed in the R function
    var id = $(el).attr("id");

    // extract all data attributes binded to the gauge HTML tag
    // put them in camelCase since and store them in an array.
    // Camel case is used since Framework7 only accepts this
    // format to configure widgets!
    // See below for instance:
    //
    // var demoGauge = app.gauge.create({
    //   el: '.demo-gauge',
    //   type: 'circle',
    //   value: 0.5,
    //   size: 250,
    //   borderColor: '#2196f3',
    //   borderWidth: 10,
    //   valueText: '50%',
    //   valueFontSize: 41,
    //   valueTextColor: '#2196f3',
    //   labelText: 'amount of something',
    // });

    // https://stackoverflow.com/questions/4187032/get-list-of-data-attributes-using-javascript-jquery
    var data = {};
    [].forEach.call(el.attributes, function(attr) {
      if (/^data-/.test(attr.name)) {
        var camelCaseName = attr.name.substr(5).replace(/-(.)/g, function ($0, $1) {
          return $1.toUpperCase();
        });
        data[camelCaseName] = attr.value;
      }
    });

    // valueText should not be let as a free parameter since it does not make sense
    // that the value is different from the displayed text.
    data.valueText = 100 * data.value + '%';
    // add the id
    data.el = '#' + id;

    // feed the create method
    var g = app.gauge.create(data);
  },

  find: function(scope) {
    return $(scope).find(".gauge");
  },

  getValue: function(el) {

  },

  // see updateF7Gauge
  receiveMessage: function(el, data) {
    var g = app.gauge.get($(el));
    g.update({
      value: data.value / 100,
      valueText: data.value + '%',
      labelText: data.text,
      size: data.size,
      bgColor: data.bgColor,
      borderBgColor: data.borderBgColor,
      borderColor: data.borderColor,
      borderWidth: data.borderWidth,
      valueTextColor: data.valueTextColor,
      valueFontSize: data.valueFontSize,
      valueFontWeight: data.valueFontWeight,
      labelTextColor: data.labelTextColor,
      labelFontSize: data.labelFontSize,
      labelFontWeight: data.labelFontWeight
    });
  }
});

Shiny.inputBindings.register(f7GaugeBinding, 'f7.gauge');

