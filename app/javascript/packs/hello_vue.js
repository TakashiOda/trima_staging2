import Vue from 'vue'
import Vuetify from 'vuetify'
import "vuetify/dist/vuetify.min.css"
import App from '../app.vue'

Vue.use(Vuetify) //追加

const vuetify = new Vuetify(); //追加

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    vuetify,
    render: h => h(App)
  }).$mount()
  document.body.appendChild(app.$el)

  console.log(app)
})
