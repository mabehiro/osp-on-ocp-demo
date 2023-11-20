#!/bin/bash
set -eux

if [ -e /etc/kernel/cmdline ]; then
  echo 'Updating /etc/kernel/cmdline'
  sed -i -e "s/^\(.*\)net\.ifnames=0\s*\(.*\)/\1\2/" /etc/kernel/cmdline
fi

source /etc/default/grub
if grep -q "net.ifnames=0" <<< "$GRUB_CMDLINE_LINUX"; then
  echo 'Updating /etc/default/grub'
  sed -i -e "s/^\(GRUB_CMDLINE_LINUX=.*\)net\.ifnames=0\s*\(.*\)/\1\2/" /etc/default/grub
fi
if [ "$GRUB_ENABLE_BLSCFG" == "true" ]; then
  echo 'Fixing BLS entries'
  find /boot/loader/entries -type f -exec sed -i -e "s/^\(.*\)net\.ifnames=0\s*\(.*\)/\1\2/" {} \;
fi
# Always do this, on RHEL8 with BLS we still need it as the BLS entry uses $kernelopts from grubenv
echo 'Running grub2-mkconfig'
grub2-mkconfig -o /etc/grub2.cfg
grub2-mkconfig -o /etc/grub2-efi.cfg
rm -f /etc/sysconfig/network-scripts/ifcfg-ens* /etc/sysconfig/network-scripts/ifcfg-eth*
update-ca-trust extract
