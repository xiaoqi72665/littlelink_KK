# 配置
$HTML_FILE = 'index.html'
$OUTPUT_DIR = 'output_images'
$IMG_EXTS = @('.png', '.jpg', '.jpeg', '.svg', '.ico', '.webp')

# 读取HTML内容
$html = Get-Content $HTML_FILE -Encoding UTF8 -Raw

# 正则提取 src/href 路径
$pattern = '(?:src|href)=[""](.*?)[""]'
$matches = [regex]::Matches($html, $pattern, [System.Text.RegularExpressions.RegexOptions]::IgnoreCase)

# 过滤出图片路径
$imgPaths = @()
foreach ($match in $matches) {
    $path = $match.Groups[1].Value
    $ext = [System.IO.Path]::GetExtension($path).ToLower()
    if ($IMG_EXTS -contains $ext) {
        $imgPaths += $path
    }
}

# 去重
$imgPaths = $imgPaths | Sort-Object -Unique

# 创建输出目录
if (!(Test-Path $OUTPUT_DIR)) {
    New-Item -ItemType Directory -Path $OUTPUT_DIR | Out-Null
}

# 复制文件
foreach ($imgPath in $imgPaths) {
    $srcPath = $imgPath -replace '/', '\'
    if (!(Test-Path $srcPath)) {
        Write-Host "未找到文件: $srcPath" -ForegroundColor Yellow
        continue
    }
    
    $destPath = Join-Path $OUTPUT_DIR $srcPath
    $destDir = Split-Path $destPath -Parent
    
    if (!(Test-Path $destDir)) {
        New-Item -ItemType Directory -Path $destDir -Force | Out-Null
    }
    
    Copy-Item $srcPath $destPath -Force
    Write-Host "已复制: $srcPath -> $destPath" -ForegroundColor Green
}

Write-Host "`nAll done! Please upload images from $OUTPUT_DIR directory." -ForegroundColor Cyan 