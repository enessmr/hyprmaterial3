#!/usr/bin/env python3
import os
import sys
import getpass
import datetime
import subprocess

# --- Config paths ---
home = os.path.expanduser("~")
chat_dir = os.path.join(home, ".local/share/hyprmaterial3/ai/chathist")
selected_file = os.path.join(home, ".local/share/hyprmaterial3/ai/selected.txt")

os.makedirs(chat_dir, exist_ok=True)

# --- Get username ---
username = getpass.getuser()

# --- Load selected AI ---
def get_selected_ai():
    if not os.path.exists(selected_file):
        open(selected_file, "w").close()  # create empty
        return "None"
    with open(selected_file, "r") as f:
        ai = f.read().strip()
        if ai == "":
            return "None"
        return ai

# --- Create new chat file ---
def new_chat_file():
    timestamp = datetime.datetime.now().strftime("%Y_%m_%d_%H-%M-%S")
    file_path = os.path.join(chat_dir, f"chathistory_{timestamp}.txt")
    open(file_path, "w").close()
    return file_path

# --- Process single query ---
def process_query(ai_name, query, chat_file):
    # Save user input
    with open(chat_file, "a") as f:
        f.write(f"{username}: {query}\n")

    # Run AI (example with Ollama)
    try:
        print(f"[DEBUG] Running: ollama run {ai_name.lower()} '{query}'", file=sys.stderr)
        result = subprocess.run(
            ["ollama", "run", ai_name.lower(), query],
            capture_output=True,
            text=True,
            timeout=30  # don't hang forever bestie
        )
        print(f"[DEBUG] Return code: {result.returncode}", file=sys.stderr)
        if result.stderr:
            print(f"[DEBUG] Stderr: {result.stderr}", file=sys.stderr)
        
        if result.returncode != 0:
            answer = f"[Error] Ollama failed with code {result.returncode}: {result.stderr}"
        else:
            answer = result.stdout.strip()
            if not answer:
                answer = "[Error] Ollama returned empty response"
    except subprocess.TimeoutExpired:
        answer = "[Error] Ollama timed out (30s limit)"
    except FileNotFoundError:
        answer = "[Error] Ollama not found - is it installed and in PATH?"
    except Exception as e:
        answer = f"[Error] Failed to run AI: {e}"

    # Save AI output
    with open(chat_file, "a") as f:
        f.write(f"{ai_name}: {answer}\n")

    print(answer)
    sys.stdout.flush()

# --- Main logic ---
chat_file = new_chat_file()

print("AI backend started. Type your queries.")
sys.stdout.flush()

if len(sys.argv) >= 3:
    # Command line mode - single query
    ai_name = sys.argv[1]
    query = sys.argv[2]
    process_query(ai_name, query, chat_file)
else:
    # Interactive mode - continuous input
    for line in sys.stdin:
        query = line.strip()
        if not query:
            continue

        ai_name = get_selected_ai()
        if ai_name == "None":
            print("[Error] No AI selected. Please select a valid AI.")
            sys.stdout.flush()
            continue  # this was missing the continue btw

        process_query(ai_name, query, chat_file)