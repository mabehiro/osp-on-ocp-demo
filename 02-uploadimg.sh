virtctl image-upload dv openstack-base-img -n openstack \
 --size=100Gi --image-path=rhel-9.2-x86_64-kvm.qcow2 \
 --storage-class ocs-storagecluster-ceph-rbd --access-mode ReadWriteOnce --insecure
