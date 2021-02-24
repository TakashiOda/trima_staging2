require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")
require("chartkick")
require("chart.js")
require("jquery")
// require("test.js")
import '../stylesheets/application';
import '@fortawesome/fontawesome-free/js/all'
import "cocoon";

const images = require.context('../images', true)
