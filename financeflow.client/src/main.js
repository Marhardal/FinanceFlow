import './assets/main.css'

import { createApp } from 'vue'
import App from './App.vue'

import router from './Others/Router.js'
import formkitconfig from './Others/formkit.config'

import { plugin, defaultConfig} from "@formkit/vue"

import ToastPlugin from 'vue-toast-notification';
import 'vue-toast-notification/dist/theme-bootstrap.css';

const app = createApp(App);

app.use(plugin, defaultConfig(formkitconfig));
app.use(ToastPlugin);

app.use(router).mount('#app');

