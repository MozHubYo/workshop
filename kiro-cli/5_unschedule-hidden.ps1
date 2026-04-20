# ═══════════════════════════════════════════════════════════
# unschedule-hidden.ps1 — 移除「隱藏版」排程任務
# ═══════════════════════════════════════════════════════════
#
# 功能：
#   刪除由 4_schedule-hidden.ps1 註冊的 Windows Task Scheduler 任務。
#
# 使用方式：
#   在 PowerShell 執行：
#     .\5_unschedule-hidden.ps1
#
# 任務名稱：Kiro Poetry (Hidden)
#
# ═══════════════════════════════════════════════════════════

$taskName = "Kiro Poetry (Hidden)"

$task = Get-ScheduledTask -TaskName $taskName -ErrorAction SilentlyContinue
if ($null -eq $task) {
    Write-Host "ℹ 找不到任務：$taskName" -ForegroundColor Yellow
    Write-Host "   可能已經刪除，或從未註冊。" -ForegroundColor Gray
    exit 0
}

Unregister-ScheduledTask -TaskName $taskName -Confirm:$false
Write-Host "✅ 已移除任務：$taskName" -ForegroundColor Green
