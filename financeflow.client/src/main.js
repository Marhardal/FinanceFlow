import './assets/main.css'

import { createApp } from 'vue'
import App from './App.vue'

import { createPinia } from 'pinia'

import router from './Others/Router.js'
import formkitconfig from './Others/formkit.config'

import { plugin, defaultConfig} from "@formkit/vue"

import ToastPlugin from 'vue-toast-notification';
import 'vue-toast-notification/dist/theme-bootstrap.css';

const app = createApp(App);

const pinia = createPinia();
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

