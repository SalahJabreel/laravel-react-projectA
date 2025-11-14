# سكريبت نشر Laravel + React على Hostinger (PowerShell)
# استخدم: .\deploy.ps1

Write-Host "🚀 بدء عملية النشر..." -ForegroundColor Green

# 1. تحديث .env.production
Write-Host "📝 تحديث .env.production..." -ForegroundColor Yellow
$domainUrl = Read-Host "أدخل الـ URL الخاص بك (مثال: https://yourdomain.com)"
Set-Location react
"VITE_API_BASE_URL=$domainUrl" | Out-File -FilePath .env.production -Encoding utf8
Write-Host "✅ تم تحديث .env.production" -ForegroundColor Green

# 2. بناء React
Write-Host "🔨 بناء React app..." -ForegroundColor Yellow
npm run build
if ($LASTEXITCODE -eq 0) {
    Write-Host "✅ تم بناء React بنجاح" -ForegroundColor Green
} else {
    Write-Host "❌ فشل بناء React" -ForegroundColor Red
    exit 1
}

# 3. العودة للجذر
Set-Location ..

# 4. تحسين Laravel
Write-Host "⚙️ تحسين Laravel..." -ForegroundColor Yellow
composer install --optimize-autoloader --no-dev
php artisan config:cache
php artisan route:cache
php artisan view:cache

Write-Host "✅ تم إعداد المشروع للنشر!" -ForegroundColor Green
Write-Host ""
Write-Host "📋 الخطوات التالية:" -ForegroundColor Cyan
Write-Host "1. رفع الملفات إلى Hostinger"
Write-Host "2. إنشاء .env على السيرفر"
Write-Host "3. تشغيل: php artisan key:generate"
Write-Host "4. تشغيل: php artisan migrate --force"
Write-Host "5. تحديث الصلاحيات: chmod -R 775 storage"

