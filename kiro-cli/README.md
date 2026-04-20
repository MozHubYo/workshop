# Kiro CLI Automation

內部培訓教材 — Kiro CLI Headless Mode 從 Demo 到真實業務自動化。

## 線上閱讀

👉 **<https://kiro-cli.moz-bot.com>**

## 內容

一份完整的 Kiro CLI headless 模式教材，涵蓋：

- **核心概念** — 為什麼排程工具只能呼叫 CLI 不能呼叫 IDE
- **安裝設定** — Kiro CLI、API Key、環境變數
- **Demo：唐詩產生器** — 親身感受「代碼呼喚 LLM」的瞬間
- **排程實作** — Task Scheduler GUI 設定，對比「有視窗」vs「隱藏」執行
- **進階案例** — SP-EXPO 真實業務自動化（下載 Google Sheets → 合併 → LLM 分析報告）

## 檔案說明

檔名加上數字前綴方便按教學流程閱讀與執行。

### 唐詩 Demo（1 ~ 5）

| 檔案 | 用途 |
|---|---|
| `1_poetry-demo.ps1` | 唐詩產生器，呼叫 kiro-cli 寫三首唐詩 |
| `2_schedule-with-window.ps1` | 註冊排程（執行時會彈出視窗） |
| `3_unschedule-with-window.ps1` | 移除「有視窗版」排程 |
| `4_schedule-hidden.ps1` | 註冊排程（完全靜默執行） |
| `5_unschedule-hidden.ps1` | 移除「隱藏版」排程 |

### 進階案例 SP-EXPO（6 ~ 9）

| 檔案 | 用途 |
|---|---|
| `6_sp_expo_demo.py` | 主腳本：下載 Google Sheets → LLM 產出分析報告 |
| `7_sp_expo_sheets.json` | 設定檔：Google Sheets 網址列表 |
| `8_schedule-sp-expo.ps1` | 註冊 SP-EXPO 排程（隱藏版） |
| `9_unschedule-sp-expo.ps1` | 移除 SP-EXPO 排程 |

### 其他

| 檔案 | 用途 |
|---|---|
| `index.html` | 教材本體（GitHub Pages 入口） |
| `CNAME` | 自訂域名綁定 |

每個腳本檔案開頭都有寫清楚使用方式。
