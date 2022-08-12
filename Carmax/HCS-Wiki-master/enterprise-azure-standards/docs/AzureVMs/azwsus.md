# Windows Updates in Azure

The BTAC - Vulnerability Management team performs Windows Updates on KMX domain joined systems in Azure using Windows Server Update Services (WSUS).

Once a Windows VM is joined to the kmx.local domain within Azure it will be registered with the appropriate WSUS server as the source for receiving Windows updates. For NonProd, the WSUS server is ENTUTLQ31. For Prod, the WSUS server is ENTUTLP31. Both of these WSUS servers are downstream replica servers communicating with our on-premises primary WSUS server, ENTUTLP04.

This mechanism is done via Group Policy Objects (GPO) related to the appropriate WSUS server and patching schedule.

WSUS updates are scheduled on either Monday or Wednesday at 1AM based on the AD security group that the Computer object is a member of. This is managed using Active Directory Group Policy.

NonProd Groups:

- KMX-WSUS-G-AZ-NonProd-Servers-Mon-1AM
- KMX-WSUS-G-AZ-NonProd-Servers-Wed-1AM

Prod Groups:

- KMX-WSUS-G-AZ-Prod-Servers-Mon-1AM
- KMX-WSUS-G-AZ-Prod-Servers-Wed-1AM

If you have any questions/concerns or need any assistance with getting VMs added to one of the above AD groups, please partner up with a member of the Enterprise Cloud Reliability team and we will can assist.

If mobile asset needs to be updated, Ensure that the schedule details are listed into [Mobile Asset](http://entutlp11:8082).
