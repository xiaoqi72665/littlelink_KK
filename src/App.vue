<script setup lang="ts">
import { onMounted, ref } from 'vue';
import Galaxy from './components/Galaxy.vue';
import CircularText from './components/CircularText.vue';
import StarBorder from './components/StarBorder.vue';
import Counter from './components/Counter.vue';
import { NotebookPen, Newspaper, Gamepad2 } from 'lucide-vue-next';
import { siAfdian, siXiaohongshu, siBilibili } from 'simple-icons';

// Helper to get SVG path from Simple Icons
const getSimpleIconPath = (icon: any) => icon.path;

const mainLinks = [
  { label: 'Personal Blog', href: 'https://blog.jisuk.top/', iconComponent: NotebookPen },
  { label: 'News Stream', href: 'https://news.jisuk.top/', iconComponent: Newspaper },
  { label: 'Sims4 Mods', href: 'https://sims.jisuk.top/', iconComponent: Gamepad2 }
];

onMounted(() => {
  // --- Console Easter Egg (Simplified) ---
  console.log(
    "%c HELLO WORLD // KK_LINK %c V.3.0.0 ",
    "background:#3b82f6; color:#ffffff; font-weight:bold; padding:4px 8px; border-radius:4px 0 0 4px;",
    "background:#1e293b; color:#3b82f6; padding:4px 8px; border-radius:0 4px 4px 0;"
  );

  // --- Google Analytics ---
  const gaScript = document.createElement('script');
  gaScript.async = true;
  gaScript.src = "https://www.googletagmanager.com/gtag/js?id=G-5Z5QX8DD2V";
  document.head.appendChild(gaScript);

  window.dataLayer = window.dataLayer || [];
  function gtag(...args: any[]) { (window.dataLayer as any[]).push(args); }
  gtag('js', new Date());
  gtag('config', 'G-5Z5QX8DD2V');

  // --- Busuanzi ---
  const busuanziScript = document.createElement('script');
  busuanziScript.async = true;
  busuanziScript.src = "https://busuanzi.ibruce.info/busuanzi/2.3/busuanzi.pure.mini.js";
  document.body.appendChild(busuanziScript);
  busuanziScript.src = "https://busuanzi.ibruce.info/busuanzi/2.3/busuanzi.pure.mini.js";
  document.body.appendChild(busuanziScript);

  // --- Real Busuanzi Data Sync ---
  const syncBusuanziData = () => {
    const uvSpan = document.getElementById('busuanzi_value_site_uv');
    const pvSpan = document.getElementById('busuanzi_value_site_pv');
    
    if (!uvSpan || !pvSpan) return;

    // Check every 500ms for data
    const checkInterval = setInterval(() => {
      const uvText = uvSpan.innerText.trim();
      const pvText = pvSpan.innerText.trim();
      
      // Busuanzi usually returns empty or '...' initially
      if (uvText && uvText !== '...' && !isNaN(Number(uvText))) {
        // Found real data! Update baseline
        const realVisitors = Number(uvText);
        const realHits = Number(pvText);
        
        // Only update if differ significantly or logic dictates (here we take real as truth)
        if (realVisitors > 0) visitorCount.value = realVisitors;
        if (realHits > 0) hitCount.value = realHits;
        
        // We can clear interval after successful fetch, OR keep checking to sync periodically
        // For "simulation" effect, we fetch once as baseline, then let simulation take over
        clearInterval(checkInterval);
        
        // Update local storage with real baseline immediately
        localStorage.setItem('site_visitors', visitorCount.value.toString());
        localStorage.setItem('site_hits', hitCount.value.toString());
      }
    }, 500);
  };
  
  // Wait a bit for DOM to be ready then start syncing
  setTimeout(syncBusuanziData, 1000);

  // --- Simulated Live Stats (Counter) ---
  const simulateLiveStats = () => {
    // Random increment every 2-4 seconds
    const delay = Math.floor(Math.random() * 2000) + 2000;
    setTimeout(() => {
      // Visitors: +0 to 2
      visitorCount.value += Math.floor(Math.random() * 3);
      // Hits: +1 to 5
      hitCount.value += Math.floor(Math.random() * 5) + 1;
      
      // Persist to localStorage
      localStorage.setItem('site_visitors', visitorCount.value.toString());
      localStorage.setItem('site_hits', hitCount.value.toString());
      
      simulateLiveStats();
    }, delay);
  };
  simulateLiveStats();
});

// Initial stats (High baseline for cool effect)
// Visitors: ~54M, Hits: ~77M
const storedVisitors = typeof localStorage !== 'undefined' ? localStorage.getItem('site_visitors') : null;
const storedHits = typeof localStorage !== 'undefined' ? localStorage.getItem('site_hits') : null;

// Default start low if no storage, or use stored
const visitorCount = ref(storedVisitors ? Number(storedVisitors) : 0);
const hitCount = ref(storedHits ? Number(storedHits) : 0);

// Dynamic places calculation to avoid leading zeros
const getPlaces = (num: number) => {
  if (num === 0) return [1];
  const digits = Math.floor(Math.log10(num)) + 1;
  const places = [];
  for (let i = digits - 1; i >= 0; i--) {
    places.push(Math.pow(10, i));
  }
  return places;
};


</script>

<template>
  <div class="fixed inset-0 z-0 bg-black">
    <Galaxy />
  </div>

  <!-- Hidden Busuanzi Spans (Source of Truth) -->
  <div style="display: none;">
    <span id="busuanzi_value_site_uv"></span>
    <span id="busuanzi_value_site_pv"></span>
  </div>

  <!-- Stats (Top Right) -->
  <div class="fixed top-2 right-2 md:top-4 md:right-4 z-20 pointer-events-auto flex flex-col items-end gap-2 origin-top-right scale-75 md:scale-100">
    <div class="flex items-center gap-2">
      <span class="text-xs text-white/40 font-bold uppercase tracking-wider">Visitors</span>
      <Counter
        :value="visitorCount"
        :places="getPlaces(visitorCount)"
        :fontSize="14"
        :padding="0"
        :gap="2"
        textColor="rgba(255,255,255,0.9)"
        fontWeight="bold"
        :gradientHeight="4"
      />
    </div>
    <div class="flex items-center gap-2">
      <span class="text-xs text-white/40 font-bold uppercase tracking-wider">Hits</span>
      <Counter
        :value="hitCount"
        :places="getPlaces(hitCount)"
        :fontSize="14"
        :padding="0"
        :gap="2"
        textColor="rgba(255,255,255,0.9)"
        fontWeight="bold"
        :gradientHeight="4"
      />
    </div>
  </div>

  <main class="container mx-auto px-4 py-20 min-h-screen flex flex-col items-center justify-center relative z-10 pointer-events-none">
    
    <div class="w-full max-w-md text-center">
      
      <!-- Avatar -->
      <div class="relative w-40 h-40 mx-auto mb-8 pointer-events-auto flex items-center justify-center">
        <!-- Circular Text Wrapper -->
        <div class="absolute inset-0 z-0">
          <CircularText
             text="不鹤 * DEVELOPER * GAMER * "
             :spin-duration="20"
             on-hover="slowDown"
             class-name="custom-class"
          />
        </div>
        
        <!-- Inner Avatar Image -->
        <div class="relative w-28 h-28 z-10">
          <img class="w-full h-full object-cover rounded-full border-4 border-white/20 shadow-xl" 
               src="/images/avatar2.jpg" 
               alt="Avatar">
        </div>
      </div>

      <!-- Title -->
      <h1 class="text-4xl md:text-5xl font-extrabold mb-2 tracking-tight bg-clip-text text-transparent bg-gradient-to-r from-white to-white/70 pointer-events-auto">
        不鹤
      </h1>
      <p class="text-white/60 text-sm md:text-base mb-10 font-medium tracking-wide">
        VISUAL DESIGNER / DEVELOPER / GAMER
      </p>

      <!-- Main Buttons (Simple & Elegant) -->
      <div class="mt-8 mb-8 space-y-4 pointer-events-auto">
        <StarBorder
          v-for="(item, index) in mainLinks" 
          :key="index"
          as="a"
          :href="item.href"
          target="_blank"
          rel="noopener"
          class="block w-full py-4 px-6 rounded-2xl bg-black border border-white/20 text-white font-medium tracking-wide transition-all duration-300 hover:scale-[1.02] hover:bg-white/10 hover:border-white/40 group text-left flex items-center"
          color="white"
          speed="6s"
        >
          <div class="flex items-center w-full">
            <component :is="item.iconComponent" class="mr-3 w-6 h-6" />
            <span>{{ item.label }}</span>
            <span class="ml-auto opacity-0 -translate-x-2 transition-all duration-300 group-hover:opacity-100 group-hover:translate-x-0">→</span>
          </div>
        </StarBorder>
      </div>

      <!-- Icon Grid -->
      <div class="grid grid-cols-3 gap-3 mb-10 pointer-events-auto">
        <a href="https://afdian.com/a/kkhyw?tab=shop" target="_blank" rel="noopener"
           class="glass-btn flex flex-col items-center justify-center p-3 rounded-2xl hover:bg-violet-500/20 text-white transition-all">
           <svg role="img" viewBox="0 0 24 24" class="w-6 h-6 mb-2 fill-current" xmlns="http://www.w3.org/2000/svg">
             <path :d="getSimpleIconPath(siAfdian)" />
           </svg>
           <span class="text-xs">Afdian</span>
        </a>
        
        <a href="https://www.xiaohongshu.com/user/profile/62c356c600000000150179c3" target="_blank" rel="noopener"
           class="glass-btn flex flex-col items-center justify-center p-3 rounded-2xl hover:bg-red-500/20 text-white transition-all">
           <svg role="img" viewBox="0 0 24 24" class="w-6 h-6 mb-2 fill-current" xmlns="http://www.w3.org/2000/svg">
             <path :d="getSimpleIconPath(siXiaohongshu)" />
           </svg>
           <span class="text-xs">RedNote</span>
        </a>

        <a href="https://space.bilibili.com/99592906" target="_blank" rel="noopener"
           class="glass-btn flex flex-col items-center justify-center p-3 rounded-2xl hover:bg-pink-400/20 text-white transition-all">
           <svg role="img" viewBox="0 0 24 24" class="w-6 h-6 mb-2 fill-current" xmlns="http://www.w3.org/2000/svg">
             <path :d="getSimpleIconPath(siBilibili)" />
           </svg>
           <span class="text-xs">Bilibili</span>
        </a>
      </div>

      <!-- Footer Info -->
      <div class="pt-6 border-t border-white/10 text-xs text-white/40 space-y-2 pointer-events-auto pb-8">
        <div class="flex flex-col items-center gap-2">
           <a href="https://beian.miit.gov.cn/#/Integrated/index" target="_blank" class="hover:text-white transition-colors">
             苏ICP备2025193833号-1
           </a>
           <div class="flex items-center gap-1 justify-center flex-wrap">
             <span>本网站由</span>
             <a href="https://www.upyun.com/?utm_source=lianmeng&utm_medium=referral" target="_blank" class="opacity-70 hover:opacity-100 transition-opacity inline-flex items-center">
               <img src="/images/icons/又拍云_logo5.png" alt="又拍云" class="h-4 brightness-0 invert opacity-60 mx-1">
             </a>
             <span>提供 CDN 加速与云存储服务</span>
           </div>
        </div>
      </div>

    </div>
  </main>
</template>

<style>
/* CSS in src/style.css */
</style>
