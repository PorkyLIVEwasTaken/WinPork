from asyncio.windows_events import NULL
from ctypes import alignment
from email import message
import shutil
import tkinter as tk
from tkinter import Image, PhotoImage, Variable, messagebox
import subprocess
import os
from tkinter import filedialog
import webbrowser
import ctypes

global launcher_version
global wp_install_location

launcher_version = "Alpha-1.0"
wp_install_location = os.environ.get('WP_install_location')

print("Parent directory:", wp_install_location)

def switch_rac():
    global rac
    rac = 1 - rac  # Toggle between 0 and 1
    label_rac.config(text="RAC: " + str(rac))
    
    if rac == 0:
        button_run.config(text="\u26A0 Boot to WinPork (This requires a restart!)")
    else:
        button_run.config(text="Start WinPork")
        
def exit_launcher():
    root.quit()

def set_wp_inst_loc():
    response = messagebox.askyesnocancel("WinPork", "Is WinPork located in C:/WinPork?")

    # Check the user's response
    if response is None:
        print("Action cancelled")
    elif response:
        os.environ["WP_install_location"] = "C:\\"
        wp_install_location = str(os.environ.get("WP_install_location"))
        messagebox.showinfo("WinPork", "Changed WinPork location to C:/WinPork")
        # Perform action for "Yes" button
    else:
        os.environ["WP_install_location"] = filedialog.askdirectory()
        wp_install_location = os.environ.get("WP_install_location")
        messagebox.showinfo("WinPork", f"Changed WinPork location to {wp_install_location}")
        # Perform action for "No" button
    print(f"{wp_install_location}")

def run_batch():
    if rac == 0:
        if ctypes.windll.shell32.IsUserAnAdmin():
            batch_file = f"{wp_install_location}\\WinPork\\winpork-repair-handler.bat"
            os.environ["RAC"] = "0"
            os.environ["quitreason"] = "0xC0000139"
        else:
            messagebox.showerror("WinPork", "You need administrator privileges to boot WinPork on bare metal!\n\nTo gain administrator privileges, right-click the WinPork launcher and select 'Run as administrator'.")
    else:
        batch_file = f"{wp_install_location}\\WinPork\\winpork-repair.bat"
        os.environ["RAC"] = "1"
        os.environ["quitreason"] = "0xC0000139"
    try:
        print(f"{wp_install_location}\\WinPork\\winpork-repair.bat")
        print(f"{batch_file}")
        subprocess.run([batch_file, str(rac)], check=True)
    except subprocess.CalledProcessError:
        messagebox.showerror("WinPork", "WinPork crashed! Crash code: " + os.environ.get("quitreason","UNKNOWN"))
    root.after(100, exit_launcher)

def visit_wp_website():
    webbrowser.open("http://wp.porkify.net", 2, True)

def reset_wp():
    confirm = messagebox.askyesno("Reset WinPork", "Are you sure you want to remove all saved WinPork data?")
    if confirm:
        try:
#            shutil.rmtree(f"{wp_install_location}\\WinPork\\wp")
#            messagebox.showinfo("WinPork", "WinPork data removed successfully!")
#        except Exception as e:
#            messagebox.showerror("WinPork", f"An error occured: {e}")

            # Check if the script has write permissions for the directory
            if os.access(wp_install_location, os.W_OK):
                # You have write permissions, proceed with deletion
                try:
                    shutil.rmtree(wp_install_location)
                    print("Folder deleted successfully.")
                except Exception as e:
                    print(f"Error deleting folder: {e}")
            else:
                print("Insufficient permissions to delete the folder.")
        except Exception as e:
            messagebox.showerror("WinPork", f"{e}")
    else:
        messagebox.showinfo("WinPork", "WinPork data removal cancelled.")

# Menu items

def about_page():
    messagebox.showinfo("WinPork", f"Launcher Version: {launcher_version}")

def bootset_open():
    subprocess.run(f"{wp_install_location}\\WinPork\\aliases\\settings.bat", check=True, start_new_session=True)

def open_wp_install_folder():
    # Get the value of the environment variable

    # Check if the environment variable exists and has a value
    try:
        if wp_install_location:
            # Open File Explorer to the specified directory
            subprocess.Popen(['explorer', wp_install_location])
        else:
            print("Location does not exist, is unknown, or is not set.")
    except Exception as e:
        print(f"{e}")
        messagebox.showerror("WinPork", f"{e}")

# Initialize RAC
rac = 0

# Create the main window
root = tk.Tk()
root.title("WinPork Launcher")

# Calculate the screen's width and height
screen_width = root.winfo_screenwidth()
screen_height = root.winfo_screenheight()

# Calculate the position for the window to appear in the center
window_width = 360
window_height = 100
x_position = (screen_width - window_width) // 2
y_position = (screen_height - window_height) // 2

# Set the window size and position
root.geometry(f"{window_width}x{window_height}+{x_position}+{y_position}")
root.resizable(False, False)  # Disable resizing

# Set the window style to a fixed dialog (remove minimize button)
#root.attributes("-toolwindow", True)

# Toolbar
toolbar = tk.Frame(root, bd=1, relief=tk.RAISED)

# Menus
menu_bar = tk.Menu(root)

file_menu = tk.Menu(menu_bar, tearoff=0)
file_menu.add_command(label="Exit", command=exit_launcher)
menu_bar.add_cascade(label="File", menu=file_menu)

edit_menu = tk.Menu(menu_bar, tearoff=0)
edit_menu.add_command(label="Open WinPork Folder...", command=open_wp_install_folder)
edit_menu.add_separator()
edit_menu.add_command(label="Clear WinPork Data", command=reset_wp)
edit_menu.add_command(label="Set WinPork Installation Location", command=set_wp_inst_loc)
edit_menu.add_command(label="Boot Settings...", command=bootset_open)
menu_bar.add_cascade(label="Edit", menu=edit_menu)

help_menu = tk.Menu(menu_bar, tearoff=0)
help_menu.add_command(label="Visit WinPork Website...", command=visit_wp_website)
help_menu.add_command(label="About", command=about_page)
menu_bar.add_cascade(label="Help", menu=help_menu)

# Create widgets
label_rac = tk.Label(root, text="RAC: " + str(rac))
rac_check = tk.Checkbutton(root, text="Run as Companion?", variable=rac, command=switch_rac)
label_warn_rac1 = tk.Label(root, text="NOTE: Running WinPork in Run as Companion has limited functionality due to User Control protections.", wraplength=290)
label_launcher_version = tk.Label(root, text=launcher_version)
button_run = tk.Button(toolbar, text="Start WinPork" if rac == 1 else "\u26A0 Boot to WinPork (This requires a restart!)", command=run_batch)

# Place widgets in the window
rac_check.pack()
label_warn_rac1.pack()

toolbar.pack(side=tk.BOTTOM, fill=tk.X)

button_run.pack(side="right", fill="both", expand=True)

# Setup the menu bar
root.config(menu=menu_bar)

# Start the application
root.mainloop()
