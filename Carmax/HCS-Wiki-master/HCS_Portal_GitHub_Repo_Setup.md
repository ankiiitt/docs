HCS Portal GitHub Repo Setup 

 

1. Login to JFrog https://carmax.jfrog.io/ and use SAML auth (Cloud Icon Below Login Button) 

![./images/HCS_Portal_GitHub_Repo_Setup/JfrogLogin.png](./images/HCS_Portal_GitHub_Repo_Setup/JfrogLogin.png)


2.	Go to the top right of the screen and go to Edit Profile. It should have an API key there.  If there is not a key there generate a new one.

3. Clone the hcs-portal repo https://github.carmax.com/CarMax/hcs-portal

   ![./images/HCS_Portal_GitHub_Repo_Setup/CloneRepo.png](./images/HCS_Portal_GitHub_Repo_Setup/CloneRepo.png)

4. Make sure npm is installed on your machine before continuing (You can type node -v)

5. At the root of the project type npm login 

6. Username will be your numbered account, password will be the api key, email will be your email 

7. npm install
   ![./images/HCS_Portal_GitHub_Repo_Setup/Auth1.png](./images/HCS_Portal_GitHub_Repo_Setup/auth1.png)

   ![./images/HCS_Portal_GitHub_Repo_Setup/Auth2.png](./images/HCS_Portal_GitHub_Repo_Setup/auth2.png)

   ![./images/HCS_Portal_GitHub_Repo_Setup/Auth2.png](./images/HCS_Portal_GitHub_Repo_Setup/npmlogin.png)

8. To run the project type npm start

9. The project will open in your browser. Make sure you refresh the page to get a page similar to the screenshot below  

   ![./images/HCS_Portal_GitHub_Repo_Setup/Auth2.png](./images/HCS_Portal_GitHub_Repo_Setup/portal.png)

10. To stop the project hold Ctrl + C
