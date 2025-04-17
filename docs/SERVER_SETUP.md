# 🛠️ Server Setup Instructions for {app-name}

This guide covers how to:
- Set up a shared system directory for deployment
- Create a group for collaboration
- Configure GitHub deploy key for pulling code without per-user SSH setup

---

## 📁 1. Set the Project Directory

Move your app out of your home folder and into a shared system location:

```shell
sudo mv ~/{app-name} /opt/{app-name}
```

---

## 👥 2. Create a Shared Group

Create a group for all collaborators and assign permissions:

```shell
sudo groupadd {app-name}
sudo usermod -aG {app-name} $USER
sudo usermod -aG {app-name} <other-dev>
```

Apply ownership and group-based permissions:

```shell
# 👤 Change ownership of all files to your user and the shared group
sudo chown --recursive $USER:{app-name} /opt/{app-name}

# 🔐 Set directory permissions:
# 7 (rwx) for user, 7 (rwx) for group, 5 (r-x) for others
# This allows group members to read, write, and execute
sudo chmod --recursive 775 /opt/{app-name}

# 📦 Set the "setgid" bit on the directory:
# Ensures all newly created files/folders inherit the group {app-name}
sudo chmod g+s /opt/{app-name}
```

This allows any group member to edit the contents, and newly created files inherit the group.

> ✨ After running `usermod`, either **log out and back in**, or run:

```shell
newgrp {app-name}
```

---

## 🔐 3. Add a Global GitHub Deploy Key

### Step 1: Generate the key

```shell
ssh-keygen -t ed25519 -C "deploy@{app-name}" -f /opt/{app-name}/.ssh/deploy_key
```

Leave the passphrase empty.

### Step 2: Add the public key to GitHub

1. Go to your GitHub repo  
2. Navigate to **Settings → Deploy Keys**  
3. Click **"Add deploy key"**  
4. Paste the contents of:

```shell
/opt/{app-name}/.ssh/deploy_key.pub
```

✅ Enable **write access** if needed.

---

## 🌐 4. Global SSH Config (System-Wide)

Create a global SSH config for GitHub to use the deploy key automatically:

```shell
sudo nano /etc/ssh/ssh_config.d/github_{app-name}.conf
```

Paste:

```
Host github.com
    IdentityFile /opt/{app-name}/.ssh/deploy_key
    IdentitiesOnly yes
```

Then ensure the key is group-readable:

```shell
sudo chown root:{app-name} /opt/{app-name}/.ssh/deploy_key
sudo chmod 640 /opt/{app-name}/.ssh/deploy_key
```

---

## ✅ 5. Test It

Try pulling the latest code from any user in the group:

```shell
cd /opt/{app-name}
git pull
```

You should not be prompted for credentials.

---

## 🎯 Summary

| Task                          | Command Example                           |
|-------------------------------|--------------------------------------------|
| Shared app folder             | `/opt/{app-name}`                         |
| Shared user group             | `sudo groupadd {app-name}`               |
| GitHub SSH deploy key         | Stored in `/opt/{app-name}/.ssh/`        |
| Global SSH config             | `/etc/ssh/ssh_config.d/github_{app-name}.conf` |
| Multi-user code pull          | `git pull` works from any group member   |

---
