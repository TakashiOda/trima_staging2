
require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")
import '../stylesheets/application';
import '@fortawesome/fontawesome-free/js/all'
import "cocoon";

const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)
// $(".notice" ).fadeOut(2000);
// $(".alert" ).fadeOut(2000);
