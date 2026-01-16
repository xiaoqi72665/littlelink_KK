<script setup lang="ts">
import { Play, Pause, Music, SkipBack, SkipForward } from 'lucide-vue-next';
import { computed } from 'vue';

interface Song {
  name: string;
  artist: string;
  url: string;
  pic: string;
  lrc: string;
}

const props = defineProps<{
  songs: Song[];
  currentSongIndex: number;
  isPlaying: boolean;
  currentTime?: number;
  duration?: number;
}>();

const emit = defineEmits<{
  (e: 'select', index: number): void;
  (e: 'prev'): void;
  (e: 'next'): void;
  (e: 'togglePlay'): void;
  (e: 'seek', time: number): void;
}>();

const formatTime = (seconds: number = 0) => {
  if (isNaN(seconds)) return '0:00';
  const mins = Math.floor(seconds / 60);
  const secs = Math.floor(seconds % 60);
  return `${mins}:${secs.toString().padStart(2, '0')}`;
};

const progress = computed({
  get: () => props.currentTime || 0,
  set: (val) => emit('seek', val)
});
</script>

<template>
  <div class="bg-black/80 backdrop-blur-xl border border-white/10 rounded-2xl overflow-hidden shadow-2xl flex flex-col w-full h-full max-h-[50vh] md:max-h-96 md:w-80">
    <!-- Header -->
    <div class="px-4 py-3 border-b border-white/10 bg-white/5 flex items-center justify-between flex-shrink-0">
      <h3 class="text-white text-xs font-bold uppercase tracking-wider flex items-center gap-2">
        <Music class="w-3 h-3" />
        Playlist
      </h3>
      <span class="text-white/40 text-[10px]">{{ songs.length }} Songs</span>
    </div>
    
    <!-- List -->
    <div class="overflow-y-auto custom-scrollbar flex-1 p-2 space-y-1 min-h-0">
      <button
        v-for="(song, index) in songs"
        :key="index"
        @click="emit('select', index)"
        class="w-full text-left p-2 rounded-lg transition-all duration-200 group relative flex items-center gap-3"
        :class="index === currentSongIndex ? 'bg-white/10' : 'hover:bg-white/5'"
      >
        <!-- Cover Art -->
        <div class="relative w-10 h-10 rounded-md overflow-hidden flex-shrink-0 border border-white/10">
          <img :src="song.pic" :alt="song.name" class="w-full h-full object-cover">
          <!-- Overlay for playing state -->
          <div v-if="index === currentSongIndex" class="absolute inset-0 bg-black/40 flex items-center justify-center">
             <div v-if="isPlaying" class="flex gap-[2px] h-3 items-end">
               <div class="w-[2px] bg-white animate-music-bar-1"></div>
               <div class="w-[2px] bg-white animate-music-bar-2"></div>
               <div class="w-[2px] bg-white animate-music-bar-3"></div>
             </div>
             <Pause v-else class="w-4 h-4 text-white fill-current" />
          </div>
        </div>

        <!-- Info -->
        <div class="flex-1 min-w-0">
          <div class="text-white text-xs font-medium truncate" :class="index === currentSongIndex ? 'text-white' : 'text-white/80'">
            {{ song.name }}
          </div>
          <div class="text-white/40 text-[10px] truncate group-hover:text-white/60 transition-colors">
            {{ song.artist }}
          </div>
        </div>
      </button>
    </div>

    <!-- Controls Footer -->
    <div class="p-4 border-t border-white/10 bg-white/5 flex-shrink-0 space-y-3">
        <!-- Progress -->
        <div class="space-y-1">
            <div class="flex justify-between text-[10px] text-white/40 font-mono">
                <span>{{ formatTime(currentTime) }}</span>
                <span>{{ formatTime(duration) }}</span>
            </div>
            <input 
                type="range" 
                min="0" 
                :max="duration || 100" 
                v-model.number="progress"
                class="w-full h-1 bg-white/20 rounded-lg appearance-none cursor-pointer [&::-webkit-slider-thumb]:appearance-none [&::-webkit-slider-thumb]:w-3 [&::-webkit-slider-thumb]:h-3 [&::-webkit-slider-thumb]:rounded-full [&::-webkit-slider-thumb]:bg-white hover:[&::-webkit-slider-thumb]:scale-110 transition-all"
            >
        </div>

        <!-- Buttons -->
        <div class="flex items-center justify-center gap-6">
            <button @click="emit('prev')" class="text-white/70 hover:text-white transition-colors">
                <SkipBack class="w-5 h-5 fill-current" />
            </button>
            
            <button 
                @click="emit('togglePlay')" 
                class="w-10 h-10 rounded-full bg-white text-black flex items-center justify-center hover:scale-105 active:scale-95 transition-all shadow-lg shadow-white/10"
            >
                <Pause v-if="isPlaying" class="w-5 h-5 fill-current" />
                <Play v-else class="w-5 h-5 fill-current ml-0.5" />
            </button>
            
            <button @click="emit('next')" class="text-white/70 hover:text-white transition-colors">
                <SkipForward class="w-5 h-5 fill-current" />
            </button>
        </div>
    </div>
  </div>
</template>

<style scoped>
.custom-scrollbar::-webkit-scrollbar {
  width: 4px;
}
.custom-scrollbar::-webkit-scrollbar-track {
  background: transparent;
}
.custom-scrollbar::-webkit-scrollbar-thumb {
  background: rgba(255, 255, 255, 0.2);
  border-radius: 4px;
}
.custom-scrollbar::-webkit-scrollbar-thumb:hover {
  background: rgba(255, 255, 255, 0.3);
}

@keyframes music-bar {
  0%, 100% { height: 20%; }
  50% { height: 100%; }
}
.animate-music-bar-1 { animation: music-bar 0.6s infinite ease-in-out; }
.animate-music-bar-2 { animation: music-bar 0.8s infinite ease-in-out 0.1s; }
.animate-music-bar-3 { animation: music-bar 0.5s infinite ease-in-out 0.2s; }
</style>
