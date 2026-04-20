# ═══════════════════════════════════════════════════════════
# schedule-hidden.ps1 — 註冊排程（隱藏視窗版）
# ═══════════════════════════════════════════════════════════
#
# 功能：
#   把 1_poetry-demo.ps1 註冊到 Windows Task Scheduler，
#   設定在「當下時間 + 30 秒」自動觸發一次。
#   執行時完全靜默，畫面不會彈出任何視窗。
#   體驗「真正無感的自動化」。
#
# 使用方式：
#   1. 先確認 1_poetry-demo.ps1 與本腳本在同一個資料夾
#   2. 在 PowerShell 執行：
#        .\4_schedule-hidden.ps1
#   3. 等 30 秒，什麼視窗都不會出現，但資料夾會多出 3 個 poem md 檔
#   4. 清理：執行 .\5_unschedule-hidden.ps1
#
# 任務名稱：Kiro Poetry (Hidden)
#
# 與 schedule-with-window.ps1 的差異：
#   本腳本 argument 多了 -WindowStyle Hidden，讓 PowerShell 背景執行
#
# ═══════════════════════════════════════════════════════════

$taskName = "Kiro Poetry (Hidden)"
$scriptPath = Join-Path $PSScriptRoot "1_poetry-demo.ps1"
$workingDir = $PSScriptRoot
$triggerTime = (Get-Date).AddSeconds(30)

# 關鍵差異：-WindowStyle Hidden 讓執行時不彈出視窗
$action = New-ScheduledTaskAction `
    -Execute "powershell.exe" `
    -Argument "-NoProfile -WindowStyle Hidden -ExecutionPolicy Bypass -File `"$scriptPath`"" `
    -WorkingDirectory $workingDir

$trigger = New-ScheduledTaskTrigger -Once -At $triggerTime

$settings = New-ScheduledTaskSettingsSet `
    -AllowStartIfOnBatteries `
    -DontStopIfGoingOnBatteries `
    -StartWhenAvailable `
    -ExecutionTimeLimit (New-TimeSpan -Minutes 10)

# 移除同名舊任務（若存在）
Unregister-ScheduledTask -TaskName $taskName -Confirm:$false -ErrorAction SilentlyContinue

Register-ScheduledTask `
    -TaskName $taskName `
    -Action $action `
    -Trigger $trigger `
    -Settings $settings `
    -Description "Kiro Poetry demo — hidden terminal version"

Write-Host ""
Write-Host "✅ 已註冊任務：$taskName" -ForegroundColor Green
Write-Host "   觸發時間：$($triggerTime.ToString('yyyy-MM-dd HH:mm:ss'))" -ForegroundColor Yellow
Write-Host "   請等待約 30 秒，畫面不會有任何變化，但檔案會悄悄產生" -ForegroundColor Yellow
