# نشر سريع على Hostinger

## ⚡ خطوات سريعة

### 1. تحديث URL في React
```bash
cd react
echo "VITE_API_BASE_URL=https://yourdomain.com" > .env.production
npm run build
cd ..
```

### 2. تحسين Laravel
```bash
composer install --optimize-autoloader --no-dev
php artisan config:cache
php artisan route:cache
```

### 3. رفع الملفات
- ارفع جميع الملفات إلى `public_html/` (أو حسب إعدادات Hostinger)
- تأكد من رفع `public/` مع محتوياته

### 4. على السيرفر
```bash
# إنشاء .env
cp .env.example .env
# تعديل .env بالبيانات الصحيحة

# إعداد Laravel
php artisan key:generate
php artisan migrate --force
chmod -R 775 storage bootstrap/cache
```

## ✅ تم!

افتح `https://yourdomain.com` للتحقق.

---

**للمزيد من التفاصيل**: راجع `دليل-النشر-Hostinger.md`

