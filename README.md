# General Plan
Because if you fail to plan, you plan to fail.

## Breaking into the machine
Sometimes you forget your credentials, here's how to reset them on linux as long as the boot drive isn't encrypted.

Method: Using Recovery Mode
1. Boot the machine, and hold `Shift`, you'll be brough to the GRUB menu.
2. From the menu, select the 2nd option from the top, as long as it contains `(recovery mode)`.
3. In the recovery menu, scroll down and select `root`.
4. Mount the drive: `mount -o remount,rw /`.
5. Reset the password: `passwd [USERNAME]`.
6. Reboot and login.