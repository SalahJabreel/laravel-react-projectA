# دليل النشر على Hostinger Shared Hosting

## ✅ ما تم إعداده

- ✅ تحديث `react/vite.config.js` لبناء React في `public/`
- ✅ تحديث `routes/web.php` لخدمة React app
- ✅ تحديث `public/.htaccess` لدعم React Router
- ✅ إنشاء `.htaccess` في الجذر لحماية الملفات
- ✅ بناء React app للإنتاج

---

## 📋 خطوات النشر

### 1️⃣ إعداد قاعدة البيانات

1. سجل الدخول إلى **hPanel** في Hostinger
2. اذهب إلى **MySQL Databases**
3. أنشئ قاعدة بيانات جديدة (مثلاً: `u123456789_app_db`)
4. أنشئ مستخدم جديد وربطه بقاعدة البيانات
5. سجل بيانات الاتصال:
   - Database Name
   - Username
   - Password
   - Host (عادة `localhost`)

---

### 2️⃣ تحديث ملفات الإعداد

#### أ. تحديث `react/.env.production`:
```env
VITE_API_BASE_URL=https://yourdomain.com
```

#### ب. تحديث `.env` في Laravel (على السيرفر):
```env
APP_NAME="Your App Name"
APP_ENV=production
APP_DEBUG=false
APP_URL=https://yourdomain.com

DB_CONNECTION=mysql
DB_HOST=localhost
DB_PORT=3306
DB_DATABASE=your_database_name
DB_USERNAME=your_db_username
DB_PASSWORD=your_db_password

# باقي الإعدادات...
```

---

### 3️⃣ بناء React للإنتاج

```bash
cd react
# تحديث .env.production بالـ URL الصحيح أولاً
npm run build
```

سيتم بناء الملفات في `public/`:
- `public/index.html`
- `public/assets/` (CSS & JS files)

---

### 4️⃣ تحضير الملفات للنشر

#### الملفات المطلوبة للرفع:
```
✅ app/
✅ bootstrap/
✅ config/
✅ database/
✅ public/          (مع ملفات React المبنية)
✅ resources/
✅ routes/
✅ storage/         (تأكد من وجود المجلدات الفرعية)
✅ vendor/          (أو قم بتثبيتها على السيرفر)
✅ artisan
✅ composer.json
✅ composer.lock
✅ .htaccess        (في الجذر)
✅ .env             (سيتم إنشاؤه على السيرفر)
```

#### الملفات التي لا ترفع:
```
❌ node_modules/
❌ react/node_modules/
❌ .git/
❌ storage/logs/*.log
❌ .env.example
```

---

### 5️⃣ رفع الملفات إلى Hostinger

#### الطريقة الأولى: File Manager
1. افتح **File Manager** من hPanel
2. اذهب إلى `public_html/`
3. ارفع جميع الملفات باستثناء `public/`
4. انقل محتويات `public/` إلى `public_html/` (Document Root)

#### الطريقة الثانية: FTP/SFTP
استخدم FileZilla أو أي FTP client:
- **Host**: `ftp.yourdomain.com` أو IP
- **Username**: من hPanel
- **Password**: من hPanel
- **Port**: 21 (FTP) أو 22 (SFTP)

---

### 6️⃣ إعداد Laravel على السيرفر

#### أ. إنشاء `.env`:
```bash
# عبر SSH أو File Manager
cp .env.example .env
# ثم عدّل .env بالبيانات الصحيحة
```

#### ب. تثبيت Dependencies:
```bash
composer install --optimize-autoloader --no-dev
```

#### ج. إنشاء APP_KEY:
```bash
php artisan key:generate
```

#### د. تحديث الصلاحيات:
```bash
chmod -R 755 storage bootstrap/cache
chmod -R 775 storage
```

#### ه. تشغيل Migrations:
```bash
php artisan migrate --force
```

#### و. تحسين الأداء:
```bash
php artisan config:cache
php artisan route:cache
php artisan view:cache
```

---

### 7️⃣ إعدادات Hostinger الإضافية

#### أ. PHP Version:
- تأكد من استخدام **PHP 8.0+** من hPanel → PHP Configuration

#### ب. SSL Certificate:
- فعّل **SSL** من hPanel → SSL

#### ج. Error Reporting:
- في `.env`: `APP_DEBUG=false` للإنتاج

---

### 8️⃣ هيكل المجلدات على السيرفر

```
public_html/              (Document Root)
├── index.php            (Laravel)
├── index.html           (React app)
├── assets/              (React built files)
│   ├── index.xxx.css
│   └── index.xxx.js
├── .htaccess
└── ... (Laravel public files)

../                      (خارج public_html)
├── app/
├── bootstrap/
├── config/
├── database/
├── routes/
├── storage/
├── vendor/
├── .env
└── artisan
```

**ملاحظة**: في بعض إعدادات Hostinger، قد تكون جميع الملفات في `public_html/` مباشرة.

---

### 9️⃣ التحقق من النشر

1. افتح `https://yourdomain.com`
2. تحقق من React app (يجب أن تظهر الواجهة)
3. اختبر API: `https://yourdomain.com/api/user`
4. تحقق من Console للأخطاء
5. اختبر تسجيل الدخول والتسجيل

---

## 🔧 استكشاف الأخطاء

### مشكلة: صفحة بيضاء
- تحقق من `storage/logs/laravel.log`
- تأكد من `APP_DEBUG=true` مؤقتاً للتحقق من الأخطاء
- تحقق من صلاحيات `storage/` و `bootstrap/cache/`

### مشكلة: 404 في React Routes
- تحقق من `public/.htaccess`
- تأكد من أن `routes/web.php` محدث

### مشكلة: CORS Errors
- تحقق من `config/cors.php`
- تأكد من `VITE_API_BASE_URL` في React

### مشكلة: Database Connection
- تحقق من بيانات `.env`
- تأكد من أن MySQL يعمل
- تحقق من Host (قد يكون `127.0.0.1` بدلاً من `localhost`)

---

## 📝 ملاحظات مهمة

1. **Node.js غير متوفر** على Shared Hosting - ابني React محلياً قبل الرفع
2. **Composer**: قد تحتاج لتثبيت dependencies محلياً ثم رفع `vendor/`
3. **Storage**: تأكد من صلاحيات الكتابة على `storage/`
4. **.env**: لا ترفع `.env` إلى Git، أنشئه على السيرفر مباشرة
5. **SSL**: استخدم HTTPS دائماً في الإنتاج

---

## 🚀 سكريبت سريع للبناء

```bash
# 1. تحديث .env.production
cd react
echo "VITE_API_BASE_URL=https://yourdomain.com" > .env.production

# 2. بناء React
npm run build

# 3. إعداد Laravel
cd ..
composer install --optimize-autoloader --no-dev
php artisan config:cache
php artisan route:cache

# 4. رفع الملفات (FTP/SFTP)
```

---

## ✅ قائمة التحقق النهائية

- [ ] قاعدة البيانات منشأة ومتصلة
- [ ] `.env` محدث بجميع البيانات الصحيحة
- [ ] React مبني وملفات `public/` محدثة
- [ ] جميع الملفات مرفوعة
- [ ] الصلاحيات محدثة (`storage/`, `bootstrap/cache/`)
- [ ] Migrations تم تشغيلها
- [ ] Cache تم تنظيمه
- [ ] SSL مفعّل
- [ ] التطبيق يعمل بشكل صحيح

---

**تم النشر بنجاح! 🎉**

