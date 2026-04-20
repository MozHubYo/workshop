import re
import subprocess

while True:
    user_input = input("👤 你：").strip()
    result = subprocess.run(
        ["kiro-cli", "chat", "--no-interactive", "--trust-tools=", user_input],
        capture_output=True, text=True, encoding="utf-8", errors="replace",
    )
    reply = re.sub(r"\x1b\[[0-9;]*m", "", result.stdout).strip().lstrip("> ").strip()
    print(f"🤖 AI：{reply}\n")
