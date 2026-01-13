# Create folder with group access rights

### Question:
Create a collaborative directory **/redhat/sysgrp** with following properties:
* group ownership of the folder is for group **sysgrp**
* members of **sysgrp** should have full access to this folder but no other user
* files created in this folder have by default group access to **sysgrp** 

***
(scroll down for an answer)

<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>
<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>

### Answer:

* Creation of **sysgrp** may be or may be not necessary. Simply **grep /etc/groups** to see if the group is already in the system.
If not: 

```
groupadd sysgrp
```

* Create folder we are talking about and assign it group ownership:

```
mkdir -p /redhat/sysgrp
chgrp sysgrp /redhat/sysgrp/
```

* Assign access rights to the folder. Remember that **2** mentioned below is called **SGID** - which means that when user 
does something on folder/file with **GUID** set will be assigned the access rights of the group.
Assigning **7** to owner and group owner makes sure that the contents of directory is not only readable and writable but also can 
be listed (which **7** for folders mean).

```
chmod 2770 /redhat/sysgrp
ls -ltr /redhat/  # to check the permissions
```

* Create a file in the folder and see the permissions given:

```
touch /redhat/sysgrp/test.log
ls -ltr /redhat/sysgrp
```

### Additional comment:

Even if the user creating file in the directory is **root** it will still have group owner of **sysgrp**.

The setgid (Set Group ID) permission in Unix-like systems changes how file execution and directory group ownership work: on files, it makes programs run with the file's group permissions instead of the user's; on directories, it forces new files/folders created inside to inherit the directory's group, not the user's primary group, which is great for shared team folders. 

On Files (Executable Programs)
Normal Behavior: A program runs with the privileges of the user who executes it.
With setgid: The program runs with the privileges of the group that owns the file, not the user.
Example: If a script is owned by the developers group and has setgid set, anyone running it (even a user not in developers) will have their process run with developers group permissions. 

On Directories (Shared Folders)
Normal Behavior: Files created in a directory inherit the user's primary group.
With setgid: Files and subdirectories created within that directory will inherit the group ownership of the parent directory, making collaboration easier.
Example: In a /shared/project directory set with setgid, if user Alice (primary group alice) creates file1, it will be owned by alice's group; but if user Bob (primary group bob) creates file2, it will belong to the project group, as that's the directory's group, say CertLibrary.com. 

How to Identify
In ls -l output, a lowercase s appears in the group's execute (x) permission spot (e.g., -rwsr-xr-x), indicating setgid is set. 

