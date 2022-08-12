# Authenticating With Azure REST APIs

I spent some time yesterday working with Azure Management REST APIs. One pain point I found, with minimal documentation, was how to authenticate to get the initial Bearer Token. 

For this example, you will need a SPO client id and it's client secret. Going forward these will be called ClientId and ClientSecret. Please replace these with your own in the example. Additionally all of my code will be in Python for this example, however, we are just creating a body to get our token back. You should know how to do this in any language you choose to write with. 

### Lets Get Started:

For my example we will be authenticating and receiving a Bearer Token, then using that token to make a call to the Subscriptions portion of the Management API. 

### Required Information:

For this, in addition to the previously mentioned ClientId and ClientSecret you will need your Tenant ID and a Subscription ID. For my example I will be using obfuscated information.

Code:

```
import json
import requests

# Do not copy the below exactly. I have a file I'm getting the data from. You will want this info to come from a secure location
ClientId = data['ClientID']
ClientSecret = data['ClientSecret']
tenant_id = "12345678-1234-1234-1234-12345678"
subscription_id = "09876543-4321-4321-4321-09876543"
auth_uri = f"https://login.microsoftonline.com/{tenant_id}/oauth2/token"
call_uri = f"https://management.azure.com/subscriptions/{subscription_id}?api-version=2016-06-01"
```

This first section of code is just setting up the variables we will use going forward. From here we start building the body and call for our requests. 

```
auth_body = {
    "client_id": ClientId,
    "client_secret": ClientSecret,
    "grant_type": "client_credentials",
    "resource": "https://management.azure.com/"
}

response = requests.post(auth_uri, data=auth_body) #This is the call to get the auth token using the body we built
data = response.json()
```

What we are doing here is creating a body for a POST request. This body contains our credentials, the grant type, and the resource type we want access to. In our case grant type is client_credentials because we are sending client credentials to get our Bearer Token. Resource is the management api. 

We then store the data in a variable called data. The response we get has lots of additional data, but we just want the json. 

From here we can use our token by building the bearer token line and then creating our authentication header. 

```
bearer_token = f"Bearer {data['access_token']}"
auth_header = {
    "Content-Type": "application/json",
    "Authorization": bearer_token
}

call_resposne = requests.get(call_uri, headers=auth_header)
print(call_resposne.json())
```

We are creating a line for our auth_header called bearer_token. This must be in the format "Bearer <YOURTOKENHERE>" and this was my quick way of making sure that worked. We then create the auth_header. This lets the application know we want a JSON response and here is our Authorization Token. 

Then we pass all of that into our call and print the response. 