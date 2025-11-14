#!/bin/bash

# سكريبت نشر Laravel + React على Hostinger
# استخدم: bash deploy.sh

echo "🚀 بدء عملية النشر..."

# 1. تحديث .env.production
echo "📝 تحديث .env.production..."
read -p "أدخل الـ URL الخاص بك (مثال: https://yourdomain.com): " DOMAIN_URL
cd react
echo "VITE_API_BASE_URL=$DOMAIN_URL" > .env.production
echo "✅ تم تحديث .env.production"

# 2. بناء React
echo "🔨 بناء React app..."
npm run build
if [ $? -eq 0 ]; then
    echo "✅ تم بناء React بنجاح"
else
    echo "❌ فشل بناء React"
    exit 1
fi

# 3. العودة للجذر
cd ..

# 4. تحسين Laravel
echo "⚙️ تحسين Laravel..."
composer install --optimize-autoloader --no-dev
php artisan config:cache
php artisan route:cache
php artisan view:cache

echo "✅ تم إعداد المشروع للنشر!"
echo ""
echo "📋 الخطوات التالية:"
echo "1. رفع الملفات إلى Hostinger"
echo "2. إنشاء .env على السيرفر"
echo "3. تشغيل: php artisan key:generate"
echo "4. تشغيل: php artisan migrate --force"
echo "5. تحديث الصلاحيات: chmod -R 775 storage"

