import './assets/main.css'

import { createApp } from 'vue'
import App from './App.vue'

import { createPinia } from 'pinia'
import piniaPluginPersistedstate from 'pinia-plugin-persistedstate';

import router from './Others/Router.js'
import formkitconfig from './Others/formkit.config'

import { plugin, defaultConfig} from "@formkit/vue"

import ToastPlugin from 'vue-toast-notification';
import 'vue-toast-notification/dist/theme-bootstrap.css';

// import VueAwesomePaginate from "vue-awesome-paginate";
// import "vue-awesome-paginate/dist/style.css";

// createApp(App).use(VueAwesomePaginate).mount("#app");

const app = createApp(App);

const pinia = createPinia();
pinia.use(piniaPluginPersistedstate);

app.use(pinia);

app.use(plugin, defaultConfig(formkitconfig));
app.use(ToastPlugin, {
  duration: 3000,
  position: 'top-right',
  type: 'default',
  width: '400px',
  dismissible: true,
  pauseOnHover: true,
  closeOnClick: true,
  showCloseButtonOnHover: false,
  hideProgressBar: false,
  closeButton: false,
  icon: true,
});

app.use(router).mount('#app');

