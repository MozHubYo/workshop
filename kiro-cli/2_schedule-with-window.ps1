# ═══════════════════════════════════════════════════════════
# schedule-with-window.ps1 — 註冊排程（有視窗版）
# ═══════════════════════════════════════════════════════════
#
# 功能：
#   把 1_poetry-demo.ps1 註冊到 Windows Task Scheduler，
#   設定在「當下時間 + 30 秒」自動觸發一次。
#   執行時會彈出黑色 PowerShell 視窗，讓你親眼看到腳本被觸發。
#
# 使用方式：
#   1. 先確認 1_poetry-demo.ps1 與本腳本在同一個資料夾
#   2. 在 PowerShell 執行：
#        .\2_schedule-with-window.ps1
#   3. 等約 30 秒，會看到彈出的黑色視窗自動執行完關閉
#   4. 清理：執行 .\3_unschedule-with-window.ps1
#
# 任務名稱：Kiro Poetry (Visible)
#
# ═══════════════════════════════════════════════════════════

$taskName = "Kiro Poetry (Visible)"
$scriptPath = Join-Path $PSScriptRoot "1_poetry-demo.ps1"
$workingDir = $PSScriptRoot
$triggerTime = (Get-Date).AddSeconds(30)

# 注意：這裡沒有 -WindowStyle Hidden，所以執行時會彈出視窗
$action = New-ScheduledTaskAction `
    -Execute "powershell.exe" `
    -Argument "-NoProfile -ExecutionPolicy Bypass -File `"$scriptPath`"" `
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
    -Description "Kiro Poetry demo — visible terminal version"

Write-Host ""
Write-Host "✅ 已註冊任務：$taskName" -ForegroundColor Green
Write-Host "   觸發時間：$($triggerTime.ToString('yyyy-MM-dd HH:mm:ss'))" -ForegroundColor Yellow
Write-Host "   請等待約 30 秒，會看到彈出視窗自動執行" -ForegroundColor Yellow
