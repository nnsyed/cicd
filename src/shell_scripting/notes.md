1. Keyword: A special token hardcoded into shell grammar that defines
structure and logical flow of script.

eg: if then else fi for while do done case [[

- Recognized very early in the shell's token processing phase before variable
expansion or word splitting 

- Role: They build the control structures (like loops and conditionals)

2. shell built-in: A command implemented directly inside the shell executable code
rather than as a spearate expternal binary file on disk.

eg: cd, pwd, cho eval, export [

- Role: Used to perform utility operation or manage the shell env directly without
spawning a heaby external child process.

3. utility: External binary programs or scripts stores on your file system
   typically in directories like /bin, /usr/bin or /usr/local/bin

eg: ls, grep, awk, sed, curl, find

- When you call an external utility, the shell must look it up using $PATH
variable, create a new new child process(fork), and load the program into 
memory to run it.

run commands:
- type if
- type cd
- type grep


Feature         test            [	                [[	            ((
-----------------------------------------------------------------------------------------
Type	    Built-in / 	        Built-in / 	        Shell Keyword	Shell Keyword
            Command             Command

Primary 	Basic string, 	    Synonym for test    Advanced 	    Pure Integer Arithmetic
Purpose     file, & integer                         evaluation
            checks

Key         Requires strict     Exactly same as     No quoting      C-style math expressions;  standard    variable quoting;   test, but requires  required;       uses >, <, ==.
Features    uses -eq, -gt.	.	 a closing ] 	    pattern/regex 
                                                    matching; 
                                                    && and ||.
            
Portability	POSIX Standard 	    POSIX Standard 	    Bash, Zsh, Ksh 	 Bash, Zsh, Ksh
            (highly portable)   (highly portable)   only             only

double quotes
--------------------
In a shell script, you should use double quotes (") around all variable expansions and command substitutions whenever you want to prevent the shell from performing word splitting and globbing (filename expansion), while still allowing the variable to expand.

It is used with echo to:
1. To Preserve Whitespace, Tabs, and Newlines  
2. To Prevent Unintended Filename Expansion (Globbing)
3. To Handle Leading/Trailing Spaces and Empty Strings


$
--------------------------
$# — The Argument Count

$? — The Exit Status


$@ — All Arguments (Separated)

$@	All arguments (individually)	"arg1" "arg2" "arg 3 with spaces"	Iterating through inputs with a for loop

file owners:
---------------
file_owner=$(stat -c %U $f)
#file_owner=$(ls -l $f | awk '{print $3}')
The stat command in Linux displays detailed file or file system metadata (such as permissions, size, inode number, and timestamps) that go beyond what standard listing commands like ls provide.