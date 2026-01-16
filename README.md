# KK_LINK (jisuk.top)

The personal landing page of 不鹤 (KK), combining modern web technologies with stunning visual effects.

![Status](https://img.shields.io/badge/Status-Active-success)
![Vue](https://img.shields.io/badge/Vue.js-3.5-4FC08D?logo=vuedotjs)
![Vite](https://img.shields.io/badge/Vite-6.0-646CFF?logo=vite)
![Tailwind](https://img.shields.io/badge/Tailwind_CSS-4.0-38B2AC?logo=tailwindcss)

## ✨ Features

- **🌌 Galaxy Background**: An interactive, WebGL-based 3D starfield background (powered by `ogl`).
- **💫 Circular Text Avatar**: A dynamic, rotating text wrapper around the avatar (`motion-v`).
- **🌠 Star Border Buttons**: Interactive buttons with a flowing "shooting star" border effect.
- **📊 Live Stats Simulation**: Animated counters for "Visitors" and "Hits" that simulate real-time traffic and persist via `localStorage`.
- **📱 Responsive Design**: Perfectly adapted for mobile devices, including notch/Dynamic Island optimization.
- **⚡ Automated Deployment**: Integrated GitHub Actions workflow for automatic deployment to GitHub Pages.

## 🛠️ Tech Stack

- **Framework**: Vue 3 + TypeScript + Vite
- **Styling**: Tailwind CSS
- **Animations**: motion-v, vue-bits
- **Icons**: Simple Icons (Brands), Lucide Vue Next (UI)
- **Deployment**: GitHub Actions -> GitHub Pages

## 🚀 Getting Started

### Installation

```bash
npm install
```

### Development

```bash
npm run dev
```

### Build

```bash
npm run build
```

## 🚢 Deployment

This project is configured to automatically deploy to GitHub Pages.

1. Push your changes to the `main` branch.
2. The [GitHub Action](.github/workflows/deploy.yml) will automatically build and deploy the `dist` folder to the `gh-pages` branch.
3. Your custom domain `jisuk.top` (`CNAME` is in `public/`) will be preserved.

## 📄 License

MIT
