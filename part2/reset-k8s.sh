sudo virsh destroy k8s-cp
sudo virsh undefine k8s-cp
sudo rm /var/lib/libvirt/images/k8s-cp.qcow2
sudo rm /var/lib/libvirt/images/k8s-cp-seed.iso
sudo qemu-img create -f qcow2 -F qcow2 -b /var/lib/libvirt/images/noble-server-cloudimg-amd64.img /var/lib/libvirt/images/k8s-cp.qcow2 20G
sudo cloud-localds /var/lib/libvirt/images/k8s-cp-seed.iso ~/vms/cloudinit/k8s-cp-user-data.yaml
virt-install   --name k8s-cp   --memory 16384 --vcpus 4   --disk path=/var/lib/libvirt/images/k8s-cp.qcow2,format=qcow2   --disk path=/var/lib/libvirt/images/k8s-cp-seed.iso,device=cdrom   --import   --os-variant ubuntu24.04   --network bridge=br0,model=virtio,virtualport_type=openvswitch,target=tap-k8scp   --noautoconsole   --graphics none   --console pty,target_type=serial
