echo "remove orphaned packages"
dnf -y autoremove
echo "Remove previous kernels that preserved for rollbacks"
dnf -y remove -y $(dnf repoquery --installonly --latest-limit=-1 -q)

echo "Removing extra firmware packages"
dnf -y remove linux-firmware

echo "clean all package cache information"
dnf -y clean all  --enablerepo=\*;

echo "truncate any logs that have built up during the install"
find /var/log -type f -exec truncate --size=0 {} \;

# Block until cloud-init completes
cloud-init status --wait  > /dev/null 2>&1
[ $? -ne 0 ] && echo 'Cloud-init failed' && exit 1
echo 'Cloud-init succeeded at ' `date -R`

echo "Stop cloud-init and wipe the state"

systemctl stop cloud-init
rm -rf /var/lib/cloud/

echo "remove the contents of /tmp and /var/tmp"
rm -rf /tmp/* /var/tmp/*

echo "Force a new random seed to be generated"
rm -f /var/lib/systemd/random-seed

echo "Wipe netplan machine-id (DUID) so machines get unique ID generated on boot"
truncate -s 0 /etc/machine-id

echo "Clear the history so our install commands aren't there"
export HISTSIZE=0


