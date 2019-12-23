# linux-useful-commands
Some useful commands

## Git
### Global setup

```bash
git config --global user.email "email@example.com"
git config --global user.name "username"

# Use kdiff as merge tool
sudo apt-get install kdiff3
git config --global merge.tool "kdiff3"

#Use vim as default editor
git config --global core.editor "vim"
```

### Git commands
```bash
# Import functions
chmod u+x functions && . ./functions

# Remove all branches but master
remove_branches_but master

# Squash against another branch
git rebase -i <other branch>
# Squash last 2 commits in current branch
git rebase -i HEAD~2
# Squash when merging
git merge --squash <other branch>

# Take file from another branch
git checkout <branch> -- file

# Change author and committer
git filter-branch --env-filter 'if [ "$GIT_AUTHOR_EMAIL" = "incorrect@email" ]; then
     GIT_AUTHOR_EMAIL=correct@email;
     GIT_AUTHOR_NAME="Correct Name";
     GIT_COMMITTER_EMAIL=$GIT_AUTHOR_EMAIL;
     GIT_COMMITTER_NAME="$GIT_AUTHOR_NAME"; fi' -- --all
```
 
## Ip Tables

### Show rules
```bash
# Show all rules in verbose mode
sudo iptables -L -v

# Show all lines with line number
sudo iptables -L --line-numbers

# Show routing table
route -n
```

### Create rule
```bash
# Template for appending a new rule to the chain:
# <chain> can be: INPUT, FORWARD, OUTPUT
# <target> can be: ACCEPT, DROP, RETURN
sudo iptables -A <chain> -i <interface> -p <protocol (tcp/udp) > -s <source> -dport <port no.>  -j <target>

sudo iptables -A <chain> -i <interface> -p <protocol (tcp/udp) > -s <source>  -j <target> -m iprange --src-range 192.168.1.100-192.168.1.200
```

### Delete rules
```bash
# Flush all chains
sudo iptables -F 

# Flush rules for a given chain
sudo iptables -F <chain>

# Delete line <n> in chain <chain>
sudo iptables -D <chain> <n>
```

### Useful examples
```bash
# Allow LAN nodes with private IPs to communicate with external public networks
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE 

# Forward all traffic from tun0 to wlan0 in state RELATED, ESTABILISHED
sudo iptables -A FORWARD -i tun0 -o wlan0 -m state --state RELATED,ESTABLISHED -j ACCEPT

# Forward all traffic from tun0 to wlan0
sudo iptables -A FORWARD -i wlan0 -o tun0 -j ACCEPT

# Save current rules
sudo sh -c "iptables-save > /etc/iptables/rules.v4"

# To make those ip tables persistent, install iptables-persistent...
sudo apt-get install iptables-persistent

# ...or modify /etc/rc.local accordingly
```