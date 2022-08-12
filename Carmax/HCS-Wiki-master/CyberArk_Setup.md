**![Banner](https://github.carmax.com/CarMax/online-systems-operations/blob/master/Documents/WikiImages/CyberArk/CyberArkBanner.png)
CyberArk is a cloud based secret management solution which allows us to protect passwords and files in a convenient way. This guide will walk through the basics of working with the tool. 

- [Setting Up The Ping App](#setting-up-the-ping-app)
- [Logging in](#logging-in)
- [Creating a secret(Account)](#creating-a-secret-account-)
- [Retrieving Passwords](#retrieving-passwords)
- [Deleting Accounts](#deleting-accounts)
- [Migrating Old Password Vaults to Cyber Ark](#migrating-old-password-vaults-to-cyber-ark)
- [Configuring ASG-RD to use Cyberark - Domain Joined Accounts](#configuring-asg-rd-to-use-cyberark---domain-joined-accounts)
- [Configuring ASG-RD to use Cyberark - Non-Domain Joined Accounts](#configuring-asg-rd-to-use-cyberark---non-domain-joined-accounts)

### Setting Up The Ping App

Prior to logging in you will need to setup the ping authentication app(With swipe) on your phone. If you are using the old method of receiving SMS messages this will *not* suffice! to do this nagivate to **login.carmax.com** and click on your profile at the top right and select **"devices"**

![Login](https://github.carmax.com/CarMax/online-systems-operations/blob/master/Documents/WikiImages/CyberArk/Login.Carmax.com.png)

On the next page click **"add"** near the top left

![Add Image](https://github.carmax.com/CarMax/online-systems-operations/blob/master/Documents/WikiImages/CyberArk/AddDevice.png)

Then scan your QR code in using the ping app on your phone

![QR Code](https://github.carmax.com/CarMax/online-systems-operations/blob/master/Documents/WikiImages/CyberArk/QRCode.png)

>Please do not attempt to use this QR code.
>For more help on getting this setup please click [here](https://login.carmax.com/mfa/)


### Logging in

To log in to cyber ark simply navigate to https://cyberark.carmax.local/PasswordVault/v10/logon/radius and use your SSO credentials. Once your sso credentials are accepted you will notice 3 dots bouncing up and down under the password field. 

![Login](https://github.carmax.com/CarMax/online-systems-operations/blob/master/Documents/WikiImages/CyberArk/HomePage.png)

This means CyberArk is waiting for you to provide your 2FA. Your phone should light up and instantly open the ping app upon unlocking it. If you dont see this, open up the ping app and you should see a button. slide the button up to log in. Once you've slide up you will soon log in and see all the secrets(accounts) available to you.

![Dancing Dots](https://github.carmax.com/CarMax/online-systems-operations/blob/master/Documents/WikiImages/CyberArk/DancingDots.png)

### Creating a secret(Account)

In CyberArk secrets stored are called *"Accounts"* and creating an account is very simple. At the top right corner click **"Add account"**

![Add Account](https://github.carmax.com/CarMax/online-systems-operations/blob/master/Documents/WikiImages/CyberArk/AddAccount.png)

Each account has to follow a certain template. These templates dictate the type of information stored and help with organization/automation. For the sake of this guide we will use the "Misc" platform as its a simple template perfect for generic password storage.  To select the Misc platform scroll down on the current screen and hit the **"Misc"** tile. 

![Misc](https://github.carmax.com/CarMax/online-systems-operations/blob/master/Documents/WikiImages/CyberArk/OpenMisc.png)

On the next screen select **"MISC-Unmanaged"**

![Misc Unamanged](https://github.carmax.com/CarMax/online-systems-operations/blob/master/Documents/WikiImages/CyberArk/Misc-Unmanaged.png)

Next you will want to select your teams safe, in this case ours was **"MISC-UNMANAGED-ONLNOPS"**

![Select Your Safe](https://github.carmax.com/CarMax/online-systems-operations/blob/master/Documents/WikiImages/CyberArk/SelectYourSafe.png)

Finally you will need to fill out the details for the account. There's technically only 3 required fields
* Address
* Username
* Application Name
Oddly enough you don't have to have a password to make an account..... All other fields are optional at this point. It is recommended to utilize the notes field.
> Note: the address field can be numerous things. A url,hostname,  the domain a server lives on, etc. Its pretty open to interpretation. 

![Account Details](https://github.carmax.com/CarMax/online-systems-operations/blob/master/Documents/WikiImages/CyberArk/AccountDetails.png)

Once all this information is filled out simply click **"add"** and your account is created!

![Add](https://github.carmax.com/CarMax/online-systems-operations/blob/master/Documents/WikiImages/CyberArk/AddAccount.png)

### Retrieving Passwords

Use the search bar at the top to search for the account you want the password for and click on the account when you find the one you are looking for

![Search](https://github.carmax.com/CarMax/online-systems-operations/blob/master/Documents/WikiImages/CyberArk/SearchForAccount.png)

Once here click the **"Show"** button and you will be able to copy the password.

![Show Password](https://github.carmax.com/CarMax/online-systems-operations/blob/master/Documents/WikiImages/CyberArk/FakePassword.png)

> Note the tracker at the bottom shows how long the password will display for before closing out as a security precaution 

### Deleting Accounts

Deleting accounts requires using the legacy GUI. To do this click on the account you want to delete and at the top right corner select **"Additional details and actions in classic interface"** 

![Additional Info](https://github.carmax.com/CarMax/online-systems-operations/blob/master/Documents/WikiImages/CyberArk/AdditionalDetails.png)

Once the old GUI loads at the top left select the **"delete"** option

![Delete](https://github.carmax.com/CarMax/online-systems-operations/blob/master/Documents/WikiImages/CyberArk/DeleteAccount.png)

Then click on the back button at the top left

![Back Button](https://github.carmax.com/CarMax/online-systems-operations/blob/master/Documents/WikiImages/CyberArk/BackButton.png)

### Migrating Old Password Vaults to Cyber Ark

There's a great guide [here](https://carmax.sharepoint.com/sites/PrivilegedAccessManagement/SitePages/Moving-Secrets-to-Unmanaged-Vaults.aspx?from=SendByEmail&e=Rj2pq5qpCEGFpDMo03QVbw&at=9) on using a custom Carmax script to migrate all passwords


### Configuring ASG-RD to use Cyberark - Domain Joined Accounts

You may want to leverage a remote desktop session manager while using cyberark and fortunately the ASG-RD experience is pretty seamless. You can download asg-rd [here](https://www.asg.com/en/Products/IT-Systems-Management/Applications-Management/ASG-Remote-Desktop.aspx) and the license file is located in _\\isofile01\Enterprise_Systems\Software\VisionApp\VisionApp_2019_

What you'll need to do is identify the managed accounts that have access to the servers you're trying to connect to. Once this is done, ensure your team has established a norm where everyone has a "claim" to one of these accounts. For example our team uses the accounts:
onlnops.wnsadm.01-10 and in this demo we will be checking out onlnops.wnsadm.03 for all the servers logged into. 

![Onlnops](https://github.carmax.com/CarMax/online-systems-operations/blob/master/Documents/WikiImages/CyberArk/Admin%20accounts.png)

Once logged in to ASG-RD it's recommended to setup a folder to house all of the connections you want to setup. This will save time when configuring your environment because we can pass inherited configurations. Once you've created the new folder right click on it and select **"Properties"** Then navigate to **RDP>>Programs** check **"Start Program"** and in the executable path use the following string:

**psm /u onlnops.wnsadm.03@cyberark.carmax.local /a %NAME% /c PSM-RDP**
> Where onlnops.wnsadm.03 = the account from cyber ark you are checking out

![Folder Properties](https://github.carmax.com/CarMax/online-systems-operations/blob/master/Documents/WikiImages/CyberArk/RDP_Programs_Properties.png)

You will also want to add your domain credentials to prevent a second logon for each server. To do this, on the folder go to **Credentials>>General** Select your credentials from the drop down and press **OK**

![Select Creds](https://github.carmax.com/CarMax/online-systems-operations/blob/master/Documents/WikiImages/CyberArk/Add_Credentials.png)

If you haven't setup creds in ASG-RD before you can do so by selecting **Add...** on the current screen, and filling out the properties tab like so:

![Cred Config](https://github.carmax.com/CarMax/online-systems-operations/blob/master/Documents/WikiImages/CyberArk/Credentials.png)

>Note if you do not setup the folder like this and place your connections under it, you will have to do the credentials/program configuration for each device! 

Next, create a connection and **Make sure the name of the connection is the name of the server you wish to connect to!** the %NAME% value is a parameter that uses the connection name in the command above.  
Under the directory you just selected and go to **>>General>>Connection** under the properties. 
Then enter the following IP: **10.161.207.165**

![Connections](https://github.carmax.com/CarMax/online-systems-operations/blob/master/Documents/WikiImages/CyberArk/Connection_Properties.png)

Once this is done connect to your server and you should see a jump box. You will need to enter your SSO password And do the 2factor swipe in ping for each server 

![JumpBox](https://github.carmax.com/CarMax/online-systems-operations/blob/master/Documents/WikiImages/CyberArk/JumpBox.png)


### Configuring ASG-RD to use Cyberark - Non-Domain Joined Accounts

Until we have all of our servers joined on the domain you will find it necessary to to setup accounts for any servers not on the domain a little differently than others. Unfortunately with the way this setup we are limited to using multiple uniquely-named accounts per server. Each server has 2 accounts so 2 people may be logged into a box at once with this current setup. Below is a guide for which accounts connect to various servers. 

**Server Account Mappings**

| kmxcomiis01 | onlnops.lcladmin.01,2  |
| ----------- | ---------------------- |
| kmxcomiis02 | onlnops.lcladmin.03,4  |
| kmxcomiis03 | onlnops.lcladmin.05,6  |
| kmxcomiis04 | onlnops.lcladmin.07,8  |
| kmxcomiis05 | onlnops.lcladmin.09,10 |
| kmxcomiis21 | onlnops.lcladmin.11,12 |
| kmxcomiis22 | onlnops.lcladmin.13,14 |
| kmxcomiis23 | onlnops.lcladmin.15,16 |
| kmxcomiis24 | onlnops.lcladmin.17,18 |
| kmxcomiis25 | onlnops.lcladmin.19,20 |
| KmxComArr01 | onlnops.lcladmin.21,22 |
| KmxComArr02 | onlnops.lcladmin.23,24 |

When setting up your ASG environment for these accounts it is recommended to use a separate folder if you setup inherit permissions in the previous tutorial. It's also reccommended to setup 2 connections per server(1 for each account) See below for example:

![New Folder](https://github.carmax.com/CarMax/online-systems-operations/blob/master/Documents/WikiImages/CyberArk/NewFolderASG.png)

The other difference is the program string being used in the RDP section:

![New String](https://github.carmax.com/CarMax/online-systems-operations/blob/master/Documents/WikiImages/CyberArk/NewConnectionString.png)

You'll notice the string no longer contains the **"@"** since its not connecting to the domain. You also need to change the account name per connection inside of ASG. Finally in the example we are not using the parameterized string as seen in the above guide for simplicity. You have to specify Servername@carmax.org for the hostname now since it can't perform the domain lookup. It's also easier to literally copy the connection, rename it to **"Servername - 2"** and change the account number to increment by one for each account on the server. 

**I.e:**

**Kmxcomarr01 would have:**
> psm /u onlnops.lcladmin.21 /a KmxComArr01.carmax.org /c PSM-RDP

and 
**Kmxcomarr02 would have:**
> psm /u onlnops.lcladmin.22 /a KmxComArr01.carmax.org /c PSM-RDP

since onlnops.lcladmin21/22 are the accounts provisioned for this server**