oc create secret generic git-secret -n openstack \
--from-file=git_ssh_identity=/home/mabe/.ssh/id_rsa \
--from-literal=git_url=git@github.com:mabehiro/ooo.git
