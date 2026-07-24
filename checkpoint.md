# RHCSA Preparation Checkpoint

## Environment

* Host OS: Parrot OS
* Virtualization: KVM
* Guest: RHEL 10 VM
* Practice style: Hands-on RHCSA labs
* Goal: RHCSA (EX200)
* Experience: Beginner with some RHEL exposure from ISTRAC Data Center
* Study time: ~2 hours/day

---

## Topics Completed

### 1. User and Group Management

Commands practiced:

* useradd
* passwd
* usermod -aG
* groupadd
* groupdel
* gpasswd
* id
* groups
* userdel -r

Concepts learned:

* Primary vs supplementary groups
* Service accounts
* Temporary users
* User expiration
* Account locking
* Sudo basics

---

### 2. Permissions

Learned:

* rwx
* Numeric permissions
* chmod
* chown
* chgrp

Special permissions:

* SUID
* SGID
* Sticky Bit

Examples practiced:

* Shared directory with SGID
* Sticky bit behavior
* Ownership and deletion rules

Important understanding:

* File deletion depends on directory permissions, not file permissions.

---

### 3. LVM

Created:

* 3 disks
* PVs
* VG: vgdev

Logical Volumes:

* lvprojects
* lvarchive

Commands practiced:

* pvcreate
* vgcreate
* lvcreate
* mkfs.xfs
* mount
* df -h
* pvs
* vgs
* lvs
* lvdisplay -m

Extended LV:

* lvextend -L +2G -r /dev/vgdev/lvprojects

Important understanding:

* LVM allocates extents from PVs.
* VG free space can remain unused.
* XFS can grow online.
* LVM does not consume the entire disk immediately.

---

### 4. Filesystems and Mounts

Practiced:

* mkfs.xfs
* mount
* umount
* /etc/fstab

Fixed:

* fstab parse error

Learned:

* Correct fstab field order
* mount -a testing
* Persistent mounts

---

### 5. HTTPD (Apache)

Commands practiced:

* systemctl start httpd
* systemctl stop httpd
* systemctl enable httpd
* systemctl restart httpd
* systemctl status httpd

Verification:

* curl localhost
* ss -tulpn

Troubleshooting:

* Invalid httpd.conf
* httpd -t
* journalctl -xeu httpd

Error encountered:

* AH00534: No MPM loaded

Fix:

* Restore original configuration

Important understanding:

* Always run httpd -t before restart.

---

### 6. Firewalld

Commands practiced:

* firewall-cmd --list-all
* firewall-cmd --add-service=http --permanent
* firewall-cmd --reload

Learned:

* Difference between runtime and permanent rules.
* Why ping may work while HTTP fails.

Troubleshooting flow:

1. Service
2. Port
3. Firewall
4. SELinux

---

### 7. SELinux

Current mode:

* Enforcing

Commands learned:

* getenforce
* sestatus
* ls -Z
* ls -Zd
* chcon
* restorecon
* semanage fcontext
* getsebool
* setsebool

---

#### SELinux Context Understanding

Context format:

user:role:type:level

Examples:

Apache process:

system_u:system_r:httpd_t:s0

Web content:

unconfined_u:object_r:httpd_sys_content_t:s0

Important concept:

Only the TYPE is usually important.

Process:

httpd_t

Allowed content:

httpd_sys_content_t

Denied content:

default_t

---

#### SELinux Lab

Changed:

DocumentRoot "/web"

Observed:

/web -> default_t

Result:

403 Forbidden

Temporary fix:

chcon -t httpd_sys_content_t /web
chcon -t httpd_sys_content_t /web/index.html

Result:

curl localhost

Output:

SELINUX TEST

---

#### Persistent Fix

Learned:

chcon = temporary

semanage fcontext = persistent

Command:

semanage fcontext -a -t httpd_sys_content_t "/web(/.*)?"

Apply:

restorecon -Rv /web

Important regex understanding:

/web(/.*)?

Matches:

* /web
* /web/index.html
* /web/images
* /web/images/logo.png

But:

/web/.*

Does NOT match:

* /web

Only contents beneath it.

---

### 8. SELinux Booleans

Commands:

* getsebool -a
* getsebool -a | grep httpd
* setsebool
* setsebool -P

Important booleans:

* httpd_can_network_connect
* httpd_enable_homedirs
* httpd_read_user_content

Important understanding:

Contexts control file access.

Booleans control SELinux features/capabilities.

---

## Current RHCSA Skill Assessment

Strong:

* Users and Groups
* Permissions
* SUID/SGID/Sticky Bit
* LVM
* Filesystems
* fstab
* HTTPD
* Firewalld
* SELinux Contexts
* SELinux Booleans

Need More Practice:

* NetworkManager (nmcli)
* Storage troubleshooting
* Containers (Podman)
* Scheduled tasks
* ACLs
* Stratis/VDO (if required by exam version)

---

## Next Topic To Learn

NetworkManager (nmcli)

Planned topics:

1. nmcli
2. ACLs
3. Cron/Systemd Timers
4. Podman
5. RHCSA Troubleshooting Labs
6. Full Mock Exam




# RHCSA (EX200) Preparation Checkpoint

## Student Profile

* Goal: RHCSA (EX200)
* Current Level: Beginner with some real-world RHEL exposure from ISTRAC Data Center
* Study Style: Hands-on labs only
* Study Time: ~2 hours/day
* Preferred Method:

* Learn concepts first
* Then perform hands-on labs
* Explain *why* things work
* RHCSA exam-focused approach
* One topic at a time with examiner-style questions

---

# Lab Environment

Host OS:

* Parrot Security OS

Virtualization:

* KVM

Guest OS:

* RHEL 10

Access:

* Terminal
* KVM graphical console when required

---

# Topics Completed

## 1. User and Group Management

Commands Practiced

* useradd
* userdel -r
* usermod
* passwd
* groupadd
* groupdel
* gpasswd
* id
* groups

Concepts Learned

* Primary group
* Supplementary groups
* User lifecycle
* Account locking
* Password management
* Service accounts
* Temporary users
* Basic sudo concepts

Status:
✅ Completed

---

## 2. Linux Permissions

Commands

* chmod
* chown
* chgrp

Concepts

* rwx permissions
* Numeric permissions
* Symbolic permissions
* Ownership

Special Permissions

* SUID
* SGID
* Sticky Bit

Important Understanding

* File deletion depends on the parent directory permissions.
* Read/Write permissions on a file do not automatically allow deletion.

Status:
✅ Completed

---

## 3. LVM

Labs Completed

Created

* Physical Volumes
* Volume Group (vgdev)
* Logical Volumes

* lvprojects
* lvarchive

Commands

* pvcreate
* vgcreate
* lvcreate
* mkfs.xfs
* mount
* umount
* df -h
* pvs
* vgs
* lvs
* lvdisplay -m
* lvextend -L +SIZE -r

Concepts

* PV
* VG
* LV
* Physical Extents
* Logical Extents
* Online XFS growth
* VG free space

Status:
✅ Completed

---

## 4. Filesystems & Persistent Mounts

Commands

* mkfs.xfs
* mount
* umount
* mount -a

Configuration

* /etc/fstab

Concepts

* Persistent mounts
* fstab field order
* mount -a testing
* Parse error troubleshooting

Status:
✅ Completed

---

## 5. HTTPD (Apache)

Commands

* systemctl start
* stop
* restart
* enable
* status

Verification

* curl localhost
* ss -tulpn

Troubleshooting

* httpd -t
* journalctl -xeu httpd

Lab Performed

* Broke httpd.conf intentionally
* Received:

* AH00534: No MPM loaded
* Restored configuration

Important Habit

Always run:

```bash
httpd -t
```

before restarting Apache.

Status:
✅ Completed

---

## 6. Firewalld

Commands

* firewall-cmd --list-all
* firewall-cmd --add-service=http --permanent
* firewall-cmd --reload

Concepts

* Runtime vs Permanent rules
* Service troubleshooting order

Troubleshooting Flow

1. Service
2. Port
3. Firewall
4. SELinux

Status:
✅ Completed

---

## 7. SELinux

Mode

* Enforcing

Commands

* getenforce
* sestatus
* ls -Z
* ls -Zd
* chcon
* restorecon
* semanage fcontext
* getsebool
* setsebool

Context Understanding

Format

```
user:role:type:level
```

Most Important Field

* Type

Examples

Process

```
httpd_t
```

Content

```
httpd_sys_content_t
```

Wrong Type

```
default_t
```

Lab Completed

* Changed Apache DocumentRoot to:

```
/web
```

Observed

```
default_t
```

Result

```
403 Forbidden
```

Temporary Fix

```
chcon
```

Permanent Fix

```
semanage fcontext
restorecon
```

Regex Learned

```
/web(/.*)?
```

Difference from

```
/web/.*
```

SELinux Booleans Learned

* httpd_can_network_connect
* httpd_enable_homedirs
* httpd_read_user_content

Concept Learned

Contexts decide **what** a process may access.

Booleans decide **what features/capabilities** are allowed.

Status:
✅ Completed

---

## 8. NetworkManager (nmcli)

Commands Learned

* nmcli device status
* nmcli connection show
* nmcli device show
* nmcli connection modify
* nmcli connection up
* nmcli connection down
* hostnamectl set-hostname
* ip addr
* ip route

Concepts

Device

Example

```
ens3
```

Connection Profile

Example

```
ens3
```

Important Understanding

Device ≠ Connection Profile

Labs Completed

* Static IP
* DHCP
* DNS
* Gateway
* Hostname
* Bring interface up/down

Troubleshooting Learned

* Changing a profile does not immediately change the active configuration.
* `nmcli con up` applies the profile.
* While switching back to DHCP, the interface temporarily had both:

* Static IP
* DHCP IP
* Learned how to remove:

* ipv4.addresses
* ipv4.gateway
* ipv4.dns

Status:
✅ Completed

---

## 9. ACL (Access Control Lists)

Commands Learned

View ACL

```
getfacl
```

Add ACL

```
setfacl -m
```

Remove One ACL

```
setfacl -x
```

Remove All ACLs

```
setfacl -b
```

Default ACL

```
setfacl -d -m
```

Concepts Learned

Why ACLs exist

Normal permissions only provide:

* Owner
* Group
* Others

ACL allows permissions for specific users/groups without changing ownership.

Important Understanding

The "+" in:

```
-rw-r-----+
```

means:

Extended ACL entries exist.

Mask Concept

Understood that:

* Mask limits effective permissions.
* `setfacl` usually recalculates the mask automatically.
* Effective permissions may be lower than requested permissions because of the mask.

Default ACL

Successfully understood that:

```
setfacl -d -m
```

creates a template on a directory.

New files inherit the ACL automatically.

Existing files do not.

Directory inheritance concept fully understood.

Relationship Between ACL and Deletion

Understood that:

ACL controls access to the file.

Deletion depends on:

Parent directory write + execute permissions.

Status:
✅ Completed

---

# Current RHCSA Progress

Strong Areas

* User Management
* Groups
* Linux Permissions
* Special Permissions
* LVM
* Filesystems
* fstab
* Apache
* Firewalld
* SELinux
* NetworkManager
* ACLs

Confidence

Approximately 65–70% of RHCSA objectives completed.

---

# Next Topic (Start Here)

## Topic 10 — Job Scheduling

Start from the beginning with:

### Cron

Teach in this order:

1. Why Cron exists
2. Cron vs At
3. crond service
4. Cron syntax (five fields)
5. crontab -e
6. crontab -l
7. Hands-on labs
8. RHCSA troubleshooting
9. Common exam questions

After Cron, continue with:

1. At (one-time jobs)
2. systemd timers (RHCSA awareness)
3. Podman Containers
4. RHCSA Troubleshooting Labs
5. Full RHCSA Mock Exams

---

# Teaching Style to Continue

Continue exactly like previous sessions:

* Explain concepts before commands.
* One small lab at a time.
* Wait for lab completion before moving forward.
* Frequently ask examiner-style questions.
* Focus on understanding, not memorization.
* Use real RHCSA scenarios and troubleshooting examples.
* Keep explanations practical and exam-oriented.


---

## Progress Update (Current Session)

### Newly Completed

#### 10. Cron (Recurring Job Scheduling)

Commands practiced:

* systemctl status/start/enable crond
* crontab -e
* crontab -l

Concepts learned:

* crond service
* Five cron fields (Minute Hour Day Month Weekday)
* Special characters: *, ,, -, */
* Multiple jobs can execute at the same time.
* > vs >> redirection
* Reading cron expressions left-to-right
* Practical recurring jobs

Labs completed:

* Created a cron job writing timestamps to /tmp/cron_test.log every minute.
* Created jobs running every 2 minutes and at the top of every hour.
* Verified execution by checking log files.

#### 11. at (One-Time Job Scheduling)

Commands practiced:

* systemctl status/start/enable atd
* at now + 2 minutes
* atq
* at -c
* atrm

Concepts learned:

* Difference between cron and at
* at schedules one-time jobs only.
* Jobs remain in queue until executed.
* Executed jobs are removed automatically.
* atrm removes pending jobs.
* at -c displays the stored job.

Labs completed:

* Verified atd service.
* Scheduled one-time jobs.
* Listed queued jobs with atq.
* Learned to inspect and remove jobs.

---

## Overall Progress

Estimated completion: **75–80%**

Completed:
- User & Group Management
- Linux Permissions (SUID/SGID/Sticky Bit)
- ACLs
- LVM
- Filesystems & /etc/fstab
- HTTPD
- Firewalld
- SELinux
- NetworkManager (nmcli)
- Cron
- at

Remaining:
1. Podman (major topic)
2. Boot process & GRUB rescue (awareness)
3. Storage review
4. Networking review
5. Comprehensive troubleshooting
6. Full RHCSA mock exams
