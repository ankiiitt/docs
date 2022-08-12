# HCS Frequently Asked Questions


Q: How do I engage the HCS team for new requests?

A: The best way to engage the team is to start with the HCS portal. From here there are numerous self-services forms to requests tons of standard items, such as resource groups, cloud accounts, and tagging help. The HCS portal is always being worked on, and will have new capabilities in the future. For now, if your request cannot be solved with one of the standard request forms created a unique request using the  *"Need help"* button. This will create a card on our leankit board, and someone will typically pick up the request within 24 hours. 

![./images/NeedHelp.png](./images/NeedHelp.png)

Q: How do I connect to the VPN while on a mac?

A: See the doc below:
https://carmax.service-now.com/nav_to.do?uri=%2F$viewer.do%3Fsysparm_stack%3Dno%26sysparm_sys_id%3D72464df41b8133ccd443b9dcdd4bcb59


Q: Where do I request a PA account? 

A: Fill out the following form for a PA account:
https://carmax.service-now.com/css?id=sc_cat_item_guide&sys_id=25bdbf83db4edc50de4bc1391396195a



Q: Where do I go to request an ADO (Azure Devops Project) 

A: Fill out the following form:
https://carmax.service-now.com/css?id=sc_cat_item_guide&sys_id=4e778a7cdbb38850bb0cd12c5e96199b



Q: How do you determine which data center an on-prem(on-premise) server lives in?

A: Ping the server name and see what the IP address resolves to then see the chart below:

| IP Range   | Location                                  |      |
| ---------- | ----------------------------------------- | ---- |
| 10.161.x.x | Any Server in this range is in irving     |      |
| 10.16.x.x  | Any server in this range is in Pittsburgh |      |
| 172.x.x.x  | Any server in this range is in WestCreek  |      |

Q: How do you log into App Dynamics?
A: For non prod:
https://carmax-dev.saas.appdynamics.com/controller/#/
For Prod:
https://carmax-prod.saas.appdynamics.com/controller/#/location=AD_HOME_OVERVIEW
(Account name will be carmax-dev or carmax-prod depending on the environment)

Q: How do submit carbux?

A: Use the following form:
http://carnuts.carmax.org/home/index

Q: How can I write to a file using node?
A:  See example code below

```
const fs = require('fs')

    fs.writeFile('./calendarevents.json', userInput, err => {
        if (err) {
            //res.sendStatus(500);
        }
        else {
            console.log("The file was saved!");
            //res.status(200).send("received your request!"); <-- this breaks for some reason
        }   
    });
```

