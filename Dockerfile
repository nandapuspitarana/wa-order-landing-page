# Tahap 1: Build aplikasi Astro
FROM node:20-alpine AS builder

# Set direktori kerja di dalam container
WORKDIR /app

# Salin package.json dan package-lock.json
COPY package*.json ./

# Install dependensi
RUN npm install

# Salin seluruh kode proyek
COPY . .

# Build proyek (output akan berada di folder "dist")
RUN npm run build

# Tahap 2: Menyiapkan Nginx untuk menyajikan file statis
FROM nginx:alpine

# Salin hasil build dari tahap sebelumnya ke direktori default Nginx
COPY --from=builder /app/dist /usr/share/nginx/html

# Expose port 80 untuk akses web
EXPOSE 80

# Jalankan Nginx saat container dimulai
CMD ["nginx", "-g", "daemon off;"]
