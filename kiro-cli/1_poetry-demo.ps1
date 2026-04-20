# 1_poetry-demo.ps1 — 透過 Kiro CLI 一次產生三首不重複的唐詩

$existing = Get-ChildItem -Path . -Filter "*.md" |
    Where-Object { $_.BaseName -notmatch '^(README|index|merged)' } |
    ForEach-Object { $_.BaseName }

$existingList = if ($existing.Count -gt 0) { $existing -join '、' } else { '無' }

Write-Host "生成三首唐詩中（避開：$existingList）..."

$prompt = @"
挑三首不同的經典唐詩，用繁體中文分別寫成三個獨立檔案到當前資料夾，
檔名就是詩名加 .md（例如 靜夜思.md、春曉.md、登鸛雀樓.md）。
三首必須是不同的詩，且避開以下已存在的：$existingList。
"@

$before = Get-ChildItem -Path . -Filter "*.md" | ForEach-Object { $_.Name }

kiro-cli chat --no-interactive --trust-tools=write $prompt *> $null

$new = Get-ChildItem -Path . -Filter "*.md" |
    Where-Object { $before -notcontains $_.Name } |
    ForEach-Object { $_.Name }

if ($new) {
    Write-Host "完成："
    $new | ForEach-Object { Write-Host "  $_" }
} else {
    Write-Host "沒有新檔案產生"
}
