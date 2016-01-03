Salt state to run Xen Dom0 on FreeBSD 11
====
  
[FreeBSD wiki reference](https://wiki.freebsd.org/Xen)


***


* run as followingi (from your salt master): 

`salt 'xenbox' state.apply xen` 

* to disable xen and comment out changes: 

`salt 'xenbox' state.apply xen.disable`
 
