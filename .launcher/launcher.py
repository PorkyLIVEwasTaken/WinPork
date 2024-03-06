import tkinter as tk
from tkinter import Variable, messagebox
import subprocess
import os

def switch_rac():
    global rac
    rac = 1 - rac  # Toggle between 0 and 1
    label_rac.config(text="RAC: " + str(rac))

def run_batch():
    if rac == 0:
        batch_file = "C:\\WinPork\\winpork-repair-handler.bat"
        os.environ["RAC"] = "0"
        os.environ["quitreason"] = "0xC0000139"
    else:
        batch_file = "C:\\WinPork\\winpork-repair.bat"
        os.environ["RAC"] = "1"
        os.environ["quitreason"] = "0xC0000139"
    try:
        subprocess.run([batch_file, str(rac)], check=True)
    except subprocess.CalledProcessError:
        messagebox.showerror("WinPork", "WinPork crashed! Crash code: " + os.environ.get("quitreason","UNKNOWN"))

# Initialize RAC
rac = 0

# Create the main window
root = tk.Tk()
root.title("WinPork Launcher")

# Calculate the screen's width and height
screen_width = root.winfo_screenwidth()
screen_height = root.winfo_screenheight()

# Calculate the position for the window to appear in the center
window_width = 300
window_height = 90
x_position = (screen_width - window_width) // 2
y_position = (screen_height - window_height) // 2

# Set the window size and position
root.geometry(f"{window_width}x{window_height}+{x_position}+{y_position}")
root.resizable(False, False)  # Disable resizing

# Set the window style to a fixed dialog (remove minimize button)
#root.attributes("-toolwindow", True)

# Create widgets
label_rac = tk.Label(root, text="RAC: " + str(rac))
rac_check = tk.Checkbutton(root, text="Run as Companion?", variable=rac, command=switch_rac)
label_warn_rac1 = tk.Label(root, text="NOTE: Running WinPork in Run as Companion has limited functionality due to User Control protections.", wraplength=290)
#button_switch = tk.Button(root, text="Switch RAC", command=switch_rac)
button_run = tk.Button(root, text="Start WinPork", command=run_batch)

# Place widgets in the window
#label_rac.pack()
rac_check.pack()
label_warn_rac1.pack()
#button_switch.pack()
button_run.pack()

# Start the application
root.mainloop()
