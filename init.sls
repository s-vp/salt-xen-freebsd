{% set this             = 'XEN' %}
{% set num_cpus         = salt['grains.get']('num_cpus') %}


# Package installation 
#####################################################################################################

xen: pkg.installed

# TODO: build from source



# Poststeps: 
#####################################################################################################


vmdisks:
  module.run:
    - name: zfs.exists 
    - m_name: /vms 


/etc/sysctl.conf: 
  file.blockreplace:
    - marker_start: "########## START {{ this }} managed zone -DO-NOT-EDIT-"
    - marker_end: "########## END {{ this }} managed zone --"
    - append_if_not_found: True
    - show_changes: True
    - content: vm.max_wired=-1

## Load Kernel Modules 

/boot/loader.conf: 
  file.blockreplace:
    - marker_start: "########## START {{ this }} managed zone -DO-NOT-EDIT-"
    - marker_end: "########## END {{ this }} managed zone --"
    - append_if_not_found: True
    - show_changes: True
    - content: |
        xen_kernel="/boot/xen"
        xen_cmdline="dom0_mem=1024M dom0_max_vcpus={{ num_cpus }} dom0pvh=1 com1=115200,8n1 guest_loglvl=all loglvl=all"
#        Add to the above xen_cmdline in order to activate the serial console:
#        xen_cmdline="dom0_mem=2048M dom0_max_vcpus=4 dom0pvh=1 com1=115200,8n1 guest_loglvl=all loglvl=all console=com1"

/boot/menu.rc.local:
  file.managed:
    - contents: 'try-include /boot/xen.4th'

/etc/ttys:
  file.blockreplace:
    - marker_start: "########## START {{ this }} managed zone -DO-NOT-EDIT-"
    - marker_end: "########## END {{ this }} managed zone --"
    - append_if_not_found: True
    - show_changes: True
    - content: |
        xc0  "/usr/libexec/getty Pc"         xterm   on  secure
