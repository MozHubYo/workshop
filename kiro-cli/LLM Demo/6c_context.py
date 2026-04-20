import re
import subprocess

messages = []

while True:
    user_input = input("👤 你：").strip()
    messages.append({"role": "user", "content": user_input})
    history = "\n".join(f"{m['role']}: {m['content']}" for m in messages)

    result = subprocess.run(
        ["kiro-cli", "chat", "--no-interactive", "--trust-tools=", history],
        capture_output=True, text=True, encoding="utf-8", errors="replace",
    )
    reply = re.sub(r"\x1b\[[0-9;]*m", "", result.stdout).strip().lstrip("> ").strip()
    messages.append({"role": "assistant", "content": reply})
    print(f"🤖 AI：{reply}\n")
