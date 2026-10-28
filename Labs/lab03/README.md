### Lab 3: RISC-V Assembly

#### Exercise 3. Fibonacci
1. At what address is n stored in memory? Hint: Step through the code and look at the contents of the registers
`0x10000000`
2. How would you compute the 20th fibonacci number?
*Change the value stored at n to 20*
#### Connecting files to Venus

You can "mount" a folder from your local device onto Venus's web frontend, so that edits you make within the browser Venus editor are reflected in your local file system, and vice versa. If you don't do this step, files created and edited in Venus will be lost each time you close the tab, unless you copy/paste them to a local file.

Here's what you need to do:

1. If you don't already have your labs repo cloned on your local machine, open a terminal on your local machine and clone it.
Windows users should clone outside WSL (Git Bash is recommended). Note that Windows paths are also accessible from WSL (e.g. C:/Users/oski/cs61c/labs/ in Windows is /mnt/c/Users/oski/cs61c/labs/ in WSL).
2. `cd` into your labs repo folder, and run `java -jar tools/venus.jar . -dm`. This will expose your lab directory to Venus on a network port.
You should see a big "Javalin" logo.
If you see a message along the lines of "port unable to be bound", then you can specify another port number explicitly by appending --port PORT_NUM to the command (for example, java -jar tools/venus.jar . -dm --port 6162 will expose the file system on port 6162).
此处请访问：
`http://localhost:6161/venus`
然后在venus终端输入：
`mount local labs`
3. Open https://venus.cs61c.org in your web browser (Chrome or Firefox are recommended). In the Venus web terminal, run mount local labs (if you chose a different port, replace "local" with the full URL, such as http://localhost:6162). This connects Venus to your file system.
In your browser, you may see a prompt saying Key has been shown in the Venus mount server! Please copy and paste it into here.. You should be able to see a key in the most recent line of your local terminal output; just copy and paste it into the dialog.
4. Go to the "Files" tab. You should now be able to see your labs directory under the labs folder.
5. Navigate to lab03, and make sure it works by hitting the Edit button next to fib.s. This should open in the Editor tab.
If you make any changes to the file in the Editor tab, hitting command-s on a Mac and ctrl-s on Windows/Linux will update your local copy of the file. To check if the save was successful, open the file on your local machine to see if it matches what you have in the web editor (unfortunately no feedback message has been implemented yet).
Note: If you make any changes to a file in your local machine, if you had the same file open in the Venus editor, you'll need to reopen it from the "Files" menu to get the new changes.
6. To make it so that the file system will attempt to remount automatically whenever you close and reopen Venus, enable "Save on Close" in the Settings pane (again in the Venus tab). This will make the Venus web client attempt to locate the file system exposed by running Venus locally, and will pop up an error saying that it couldn't connect to the server if it doesn't see it running. If this happens, just follow the above steps to manually remount the file system.

#### `ecall` in RISC-V
```asm
finish:
    addi a0, x0, 1 # argument to ecall to execute print integer
    addi a1, t0, 0 # argument to ecall, the value to be printed
    ecall # print integer ecall
```
Printing is a system call. You'll learn more about these later in the semester, but a system call is essentially a way for your program to interact with the Operating System. To make a system call in RISC-V, we use a special instruction called `ecall`. To print out an integer, we need to pass two arguments to `ecall`. The first argument specifies what we want `ecall` to do (in this case, print an integer). To specify that we want to print an integer, we pass a 1. The second argument is the integer that we want to print out.

In C, we are used to functions looking like `ecall(1, t0)`. In RISC-V, we cannot pass arguments in this way. To pass an argument, we need to place it in an argument register (`a0`-`a7`). When the function executes, it will look in these registers for the arguments. (If you haven't seen this in lecture yet, you will soon). The first argument should be placed in `a0`, the second in `a1`, etc.

To set up the arguments, we placed a `1` in `a0` and we placed the integer that we wanted to print in `a1`.

Next, let's terminate our program! This also requires ecall

```asm
addi a0, x0, 10 # argument to ecall to terminate
ecall # terminate ecall
```