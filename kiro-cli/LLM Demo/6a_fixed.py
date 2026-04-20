import re
import subprocess

PROMPT = "你好"
print(f"👤 你：你好")

result = subprocess.run(
    ["kiro-cli", "chat", "--no-interactive", "--trust-tools=", PROMPT],
    capture_output=True, text=True, encoding="utf-8", errors="replace",
)

reply = re.sub(r"\x1b\[[0-9;]*m", "", result.stdout).strip().lstrip("> ").strip()
print(f"🤖 AI：{reply}")
