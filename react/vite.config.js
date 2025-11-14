import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'
import { resolve } from 'path'
import { fileURLToPath } from 'url'

const __dirname = fileURLToPath(new URL('.', import.meta.url))

// https://vitejs.dev/config/
export default defineConfig({
  plugins: [react()],
  build: {
    outDir: '../public',
    emptyOutDir: false, // لا تحذف ملفات Laravel في public
    rollupOptions: {
      input: resolve(__dirname, 'index.html')
    },
    assetsDir: 'assets',
    sourcemap: false,
    minify: true
  },
  base: './' // استخدام مسارات نسبية للنشر
})
