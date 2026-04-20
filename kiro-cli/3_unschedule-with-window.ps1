# ═══════════════════════════════════════════════════════════
# unschedule-with-window.ps1 — 移除「有視窗版」排程任務
# ═══════════════════════════════════════════════════════════
#
# 功能：
#   刪除由 2_schedule-with-window.ps1 註冊的 Windows Task Scheduler 任務。
#
# 使用方式：
#   在 PowerShell 執行：
#     .\3_unschedule-with-window.ps1
#
# 任務名稱：Kiro Poetry (Visible)
#
# ═══════════════════════════════════════════════════════════

$taskName = "Kiro Poetry (Visible)"

$task = Get-ScheduledTask -TaskName $taskName -ErrorAction SilentlyContinue
if ($null -eq $task) {
    Write-Host "ℹ 找不到任務：$taskName" -ForegroundColor Yellow
    Write-Host "   可能已經刪除，或從未註冊。" -ForegroundColor Gray
    exit 0
}

Unregister-ScheduledTask -TaskName $taskName -Confirm:$false
Write-Host "✅ 已移除任務：$taskName" -ForegroundColor Green
