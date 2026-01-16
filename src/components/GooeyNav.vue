<template>
  <div>
    <div class="relative w-full max-w-md mx-auto" ref="containerRef">
      <!-- SVG Filter Definition -->
      <svg class="absolute w-0 h-0 pointer-events-none" xmlns="http://www.w3.org/2000/svg">
        <defs>
          <filter id="gooey-filter">
            <feGaussianBlur in="SourceGraphic" stdDeviation="10" result="blur" />
            <feColorMatrix in="blur" mode="matrix" values="1 0 0 0 0  0 1 0 0 0  0 0 1 0 0  0 0 0 19 -9" result="goo" />
            <feComposite in="SourceGraphic" in2="goo" operator="atop"/>
          </filter>
        </defs>
      </svg>

      <!-- Navigation Container with Filter -->
      <!-- We apply the filter to the logic container, but we need to be careful. 
           The original component applied filter to the container of the particles and the text.
           Here we try to replicate that structure. -->
      <nav class="flex flex-col relative" :style="{ filter: 'url(#gooey-filter)' }">
        <ul
          ref="navRef"
          class="flex flex-col gap-4 list-none p-0 m-0 relative z-[3] w-full"
        >
          <li
            v-for="(item, index) in items"
            :key="index"
            :class="[
              'rounded-2xl relative cursor-pointer transition-[transform] duration-300 ease w-full overflow-hidden'
            ]"
            style="background: #000; border: 1px solid rgba(255,255,255,0.2);"
          >
            <a
              :href="item.href || undefined"
              @click="e => handleClick(e, index)"
              @keydown="e => handleKeyDown(e, index)"
              target="_blank"
              rel="noopener"
              class="outline-none py-4 px-6 flex items-center w-full relative z-10 text-white"
            >
              <span v-if="item.icon" class="mr-3 text-xl">{{ item.icon }}</span>
              <span class="font-medium tracking-wide">{{ item.label }}</span>
              <!-- Arrow animation -->
              <span 
                class="ml-auto opacity-0 -translate-x-2 transition-all duration-300 group-hover:opacity-100" 
                :class="{ 'opacity-100 translate-x-0': activeIndex === index }"
              >→</span>
            </a>
          </li>
        </ul>
      </nav>

      <!-- Particles Container -->
      <!-- This container sits on top/behind the nav but renders the gooey particles -->
      <div 
        class="effect-container pointer-events-none absolute inset-0 overflow-hidden" 
        :style="{ filter: 'url(#gooey-filter)' }"
      >
          <!-- The overlay text (black) when active -->
          <span class="effect text" ref="textRef" />
          
          <!-- The particles themselves -->
          <div ref="filterRef" class="absolute inset-0"></div>
      </div>

    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted, onUnmounted, useTemplateRef } from 'vue';

export interface GooeyNavItem {
  label: string;
  href: string | null;
  icon?: string;
}

interface GooeyNavProps {
  items: GooeyNavItem[];
  animationTime?: number;
  particleCount?: number;
  particleDistances?: [number, number];
  particleR?: number;
  timeVariance?: number;
  colors?: string[];
  initialActiveIndex?: number | null;
}

const props = withDefaults(defineProps<GooeyNavProps>(), {
  animationTime: 600,
  particleCount: 15,
  particleDistances: () => [90, 10],
  particleR: 100,
  timeVariance: 300,
  colors: () => ['#ec4899', '#8b5cf6', '#3b82f6', '#10b981'],
  initialActiveIndex: null
});

const containerRef = useTemplateRef<HTMLDivElement>('containerRef');
const navRef = useTemplateRef<HTMLUListElement>('navRef');
const filterRef = useTemplateRef<HTMLDivElement>('filterRef'); 
const textRef = useTemplateRef<HTMLSpanElement>('textRef');
const activeIndex = ref<number | null>(props.initialActiveIndex);

let resizeObserver: ResizeObserver | null = null;

const noise = (n = 1) => n / 2 - Math.random() * n;

const getXY = (distance: number, pointIndex: number, totalPoints: number): [number, number] => {
  const angle = ((360 + noise(8)) / totalPoints) * pointIndex * (Math.PI / 180);
  return [distance * Math.cos(angle), distance * Math.sin(angle)];
};

const createParticle = (i: number, t: number, d: [number, number], r: number) => {
  const rotate = noise(r / 10);
  return {
    start: getXY(d[0], props.particleCount - i, props.particleCount),
    end: getXY(d[1] + noise(7), props.particleCount - i, props.particleCount),
    time: t,
    scale: 1 + noise(0.2),
    color: props.colors[Math.floor(Math.random() * props.colors.length)],
    rotate: rotate > 0 ? (rotate + r / 20) * 10 : (rotate - r / 20) * 10
  };
};

const makeParticles = (element: HTMLElement) => {
  const d: [number, number] = props.particleDistances;
  const r = props.particleR;
  const bubbleTime = props.animationTime * 2 + props.timeVariance;
  element.style.setProperty('--time', `${bubbleTime}ms`);
  for (let i = 0; i < props.particleCount; i++) {
    const t = props.animationTime * 2 + noise(props.timeVariance * 2);
    const p = createParticle(i, t, d, r);
    element.classList.remove('active');
    setTimeout(() => {
      const particle = document.createElement('span');
      particle.classList.add('particle');
      particle.style.setProperty('--start-x', `${p.start[0]}px`);
      particle.style.setProperty('--start-y', `${p.start[1]}px`);
      particle.style.setProperty('--end-x', `${p.end[0]}px`);
      particle.style.setProperty('--end-y', `${p.end[1]}px`);
      particle.style.setProperty('--time', `${p.time}ms`);
      particle.style.setProperty('--scale', `${p.scale}`);
      particle.style.setProperty('--color', p.color || '#fff');
      particle.style.setProperty('--rotate', `${p.rotate}deg`);
      
      const point = document.createElement('span');
      point.classList.add('point');
      particle.appendChild(point);
      
      element.appendChild(particle);
      requestAnimationFrame(() => {
        element.classList.add('active');
      });
      setTimeout(() => {
        try {
          element.removeChild(particle);
        } catch {}
      }, t);
    }, 30);
  }
};

const updateEffectPosition = (element: HTMLElement) => {
  if (!containerRef.value || !filterRef.value) return;
  const containerRect = containerRef.value.getBoundingClientRect();
  const pos = element.getBoundingClientRect();
  
  const styles = {
    left: `${pos.x - containerRect.x}px`,
    top: `${pos.y - containerRect.y}px`,
    width: `${pos.width}px`,
    height: `${pos.height}px`
  };
  Object.assign(filterRef.value.style, styles);
  
  if (textRef.value) {
      Object.assign(textRef.value.style, styles);
      // Copy innerHTML to preserve icon + text structure for the overlay
      textRef.value.innerHTML = element.innerHTML;
  }
};

const handleClick = (e: Event, index: number) => {
  const target = e.currentTarget as HTMLElement;
  const liEl = target.closest('li') as HTMLElement;
  
  if (activeIndex.value === index) return;
  activeIndex.value = index;
  updateEffectPosition(liEl);
  if (filterRef.value) {
    const particles = filterRef.value.querySelectorAll('.particle');
    particles.forEach(p => filterRef.value!.removeChild(p));
    makeParticles(filterRef.value);
  }
};

const handleKeyDown = (e: KeyboardEvent, index: number) => {
  if (e.key === 'Enter' || e.key === ' ') {
    const liEl = (e.currentTarget as HTMLElement).closest('li');
    if (liEl) {
      handleClick(
        {
          currentTarget: e.currentTarget
        } as unknown as Event,
        index
      );
    }
  }
};

onMounted(() => {
  if (!navRef.value || !containerRef.value) return;
  resizeObserver = new ResizeObserver(() => {
    // Only update position if we have an active index
    if (activeIndex.value !== null && navRef.value) {
      const currentActiveLi = navRef.value.querySelectorAll('li')[activeIndex.value] as HTMLElement;
      if (currentActiveLi) {
        updateEffectPosition(currentActiveLi);
      }
    }
  });
  resizeObserver.observe(containerRef.value);
});

onUnmounted(() => {
  if (resizeObserver) {
    resizeObserver.disconnect();
  }
});
</script>

<style scoped>
/* Global particles style */
.particle {
  --time: 5s;
  position: absolute;
  top: 50%;
  left: 50%;
  width: 0;
  height: 0;
  animation: particle calc(var(--time)) ease-out forwards;
  pointer-events: none;
}

.point {
  display: block;
  width: 40px; 
  height: 40px;
  background: var(--color);
  border-radius: 50%;
  transform: translate(-50%, -50%) scale(0);
  animation: point calc(var(--time)) ease-out forwards;
}

/* Animations */
@keyframes particle {
  0% { transform: translate(0,0) rotate(0deg); opacity: 1; }
  100% { 
    transform: translate(calc(var(--end-x) * 1px), calc(var(--end-y) * 1px)) rotate(calc(var(--rotate) * 1deg)); 
    opacity: 0;
  }
}

@keyframes point {
  0% { transform: translate(-50%, -50%) scale(0); }
  20% { transform: translate(-50%, -50%) scale(var(--scale)); }
  80% { transform: translate(-50%, -50%) scale(var(--scale)); opacity: 1; }
  100% { transform: translate(-50%, -50%) scale(0); opacity: 0; }
}

/* Text overlay style to match the link content */
.effect.text {
  position: absolute;
  pointer-events: none;
  display: flex;
  align-items: center;
  padding: 1rem 1.5rem; /* Match anchor padding */
  z-index: 10;
  box-sizing: border-box;
  color: black; /* Active text color */
  font-weight: 500;
  letter-spacing: 0.025em;
  opacity: 0; 
  transition: opacity 0.2s;
}

/* Only show the overlay text when we have active particles or selection? 
   Actually, the original component fades text color. 
   Here we can just keep it simple: The underlying text is white. 
   If we want "black" text on top of the "goo", we show this overlay. 
*/
 li.active ~ .effect-container .effect.text,
 .effect-container .effect.text:not(:empty) {
    opacity: 1; 
 }
</style>
