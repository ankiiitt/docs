# Integrating Git and VS Code

## Download Git
[Git for Windows](https://git-scm.com/download/win) and keep in mind this is **NOT** Github Desktop.

## Steps to integrate VS Code and our Github
- Clone a repository if you have not already (skip this if you already have one you can use)
  - Go to [github](https://github.carmax.com) and find a repo you have access to.
  - When on the main page of the repo, there is a "Clone or download" button. Click on it and copy the URL to your clip board.
  - Open Gitbash (click on start and type bash).
  - change directory to where you would like to clone the repo. I use ```C:\Code\``` as my location so that is what I will use as a reference going forward.
    - In git bash, the path is done slightly different than your normal command prompt. Type ```pwd``` to get an example of your current path.
    - ```
      Wed Feb 07 14:46 /c/code $ pwd
      /c/code
      ```
      as an example. 
    - For me to ```cd``` to the directory it would be ```cd /c/code```
  - Once in the location you want to clone the repo to run the command ```git clone $URLYOUCOPIEDEARLIER``` for example: ```git clone https://github.carmax.com/CarMax/es-tools.git```
    - this process will create a folder by the name of the repo and clone the contents of the master branch of the repo to that folder. 
    - If asked for credentials enter your numbered account with ```@kmx.local``` and your personal access token (steps to create below).
    - Once cloned, right click the new folder in explorer and select ```Open with VSCode``` or open VS Code and select open folder and point to your new folder. 
    - Make a change to a file and commit that change. This will prompt you for credentials. Your credentials are your numbered account ```######@kmx.local``` and the personal access token (steps to create are below).

## Creating a personal access token
- This process is completed by logging into [github](https://github.carmax.com) and clicking on your account picture in the upper right corner.
- From there select ```Settings```
- Once the settings page loads, you will see ```Personal Access Tokens``` on the left hand side
- At the top of the heading ```Personal access tokens``` to the right you will see a button that says ```Generate new token```.
- Click ```Generate new token``` and give it a description and select the checkbox next to ```repo```. This will automatically check a few additional boxes related to the repo level access.
- Scroll to the bottom and click ```Generate token```.
- Note the message at the top of the page ```Make sure you copy your new personal access token now. You won't be able to see it again!``` and copy that token. 
- You have completed the creation of a personal access token.

## Troubleshooting
### Not able to enter credentials in vs code
- If you are having issues and do not get the option to set your credentials in VS Code, open ```git bash```
- Run the command ```git config --system --unset credentials.helper```
- Try syncing a repo in VS Code again and you should get a credentials login prompt.

### Always prompted for credentials.