


# Create the git-secret
oc create secret generic git-secret -n openstack --from-file=git_ssh_identity=/home/mabe/.ssh/id_rsa.pub --from-literal=git_url=git@github.com:mabehiro/ooo.git
secret/git-secret created

# Verify that secret
oc get secret/git-secret -n openstack
