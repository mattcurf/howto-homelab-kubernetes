sudo virsh destroy lb 
sudo virsh undefine lb 
sudo rm /var/lib/libvirt/images/lb.qcow2
sudo rm /var/lib/libvirt/images/lb-seed.iso
sudo qemu-img create -f qcow2 -F qcow2 -b /var/lib/libvirt/images/noble-server-cloudimg-amd64.img /var/lib/libvirt/images/lb.qcow2 20G
sudo cloud-localds /var/lib/libvirt/images/lb-seed.iso ~/vms/cloudinit/lb-user-data.yaml
virt-install --name lb --memory 8192 --vcpus 2 --disk path=/var/lib/libvirt/images/lb.qcow2,format=qcow2 --disk path=/var/lib/libvirt/images/lb-seed.iso,device=cdrom --import --os-variant ubuntu24.04 --network bridge=br0,model=virtio,virtualport_type=openvswitch,target=tap-lb-lan --network bridge=br0,model=virtio,virtualport_type=openvswitch,target=tap-lb-vlan5 --noautoconsole --graphics none --console pty,target_type=serial
