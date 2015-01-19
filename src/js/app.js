var UI = require('ui')

var card = new UI.Card({
  title:'Weather',
  subtitle:'Fetching...'
})

Pebble.addEventListener("ready", function(e) {
  console.log("Hello world! - Sent from your javascript application.")
  card.show()
});
