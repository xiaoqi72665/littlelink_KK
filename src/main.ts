import { createApp } from 'vue'
import './style.css'
import App from './App.vue'

// Unregister any stale service workers that might be causing errors
if ('serviceWorker' in navigator) {
    navigator.serviceWorker.getRegistrations().then(registrations => {
        for (const registration of registrations) {
            registration.unregister();
        }
    });
}

createApp(App).mount('#app')
