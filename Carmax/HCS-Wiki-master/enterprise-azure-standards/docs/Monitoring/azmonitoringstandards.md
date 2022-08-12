# Azure Monitoring
When it comes to monitoring resources in Azure, we have a several options available to us.  One important distinction to note is a quick distinction between different type of Azure resources.  There are a handful of important questions to understand prior to deciding on what option is best.

A few additional things to consider when determining which path to pursue for monitoring and alerting are the following:
- Who needs to be notified?
- What specific thresholds are important to monitor?
- How often does the alert need to fire off?
- What method of notification (Email, SMS) is needed?  
- Do you need to have a Service Now ticket generated for the alert?
- Will other teams need to be involved in supporting the resource?

### Azure Built-in Monitoring & Alerting
The following monitoring options are built into Azure:

1. Azure Monitoring – Alerts (classic) 

* Reference link: https://docs.microsoft.com/en-us/azure/monitoring-and-diagnostics/monitoring-overview-alerts
* Can monitor a variety of different metrics including a variety of Azure resource performance metrics, VM performance, service health, security events, policy updates and more.
* These are configured through the Azure portal or by using PowerShell.
* Because of PowerShell support, they can easily be incorporated within the build process.
* They support notification via email, sms, or webhook notifications.

2. Azure Monitoring – Alerts 

* Reference link: https://docs.microsoft.com/en-us/azure/monitoring-and-diagnostics/monitoring-overview-unified-alerts 
* Can monitor a variety of Azure resource types including VM performance metrics, storage accounts, virtual networks, SQL databases, Web Apps, Log Analytics queries and many more.
* These alerts can be configured within the Azure portal or within the OMS portal.
* Queries for these alerts can be built using the log analytics query language or through selections within the portal.
* These queries can take place as often as every minute if needed.
* These alerts utilize action groups to send notifications.  These action groups are highly customizable and can include email, sms, voice, push notifications in the portal, webhooks, logicapps and automation runbooks.
* These action groups can include any combination of these action types.

3. Azure Monitoring – Metrics

* Reference link: https://docs.microsoft.com/en-us/azure/monitoring-and-diagnostics/monitoring-overview-metrics 
* These metrics can be built out within the Azure portal and pinned to a dashboard on the Azure portal.
* These metrics are helpful if near real-time visibility is needed into an Azure resource or VM.

4. Log Analytics

* Reference link: https://docs.microsoft.com/en-us/azure/azure-monitor/log-query/log-query-overview
* Used to provide near real-time performance metrics from any log data within Azure.
* Uses the kusto query language to pull log data.
* For VMs, this requires the OMS agent.


5. Application Insights

* Reference link: https://docs.microsoft.com/en-us/azure/application-insights/app-insights-overview 
* Used to provide near real-time performance metrics for applications.
* Supports a variety of platforms including .NET, Node.js and J2EE. 
* Can be used to create charts, dashboards, application maps, metric streams and can be pinned to a dashboard on the Azure portal.
* Incorporates with Azure alerts to send out notifications based on defined thresholds being met.

### Monitoring Tools External to Azure
The following monitoring tools are managed and configured outside of Azure and are important to understand:

6. Application Dynamics

* Reference link: https://www.appdynamics.com/ 
* This tool provides deep analysis and alerting based on application performance regardless of whether the application is deployed in Azure only or in a hybrid model.
* The Technical Operations Center (TOC) maintains this tool and has visibility into dashboards and alerts produced from it.
* This requires an agent to report back to the central console.
* Business planning handles licensing for this product.  Each agent requires a license. 
* Supports a variety of platforms including Java, .NET, Linux and Windows.
* Application maps, reports, dashboards, and alerts can be configured.

7. Splunk

* Reference link: https://www.splunk.com/
* Can handle any type of log type.
* Handles dashboards, alerts, and other valuable analytical data.

## Infrastructure as a Service (IaaS) Monitoring
This includes Windows and Linux VMs.

Using the built-in Azure monitoring and alerting tools will make sense for the following situations:
- The VM is going to be short-lived or immutable.
- The VM is used in a Sandbox, Dev, or QA environment.
- ServiceNow integration is not needed for incident management.
- No other team needs to provide support.
- A high degree of customization is needed for the alert metrics.
- Traffic flow needs to be locked down between Azure and on-premises.

## Platform as a Service (PaaS) Monitoring
This is also known as serverless solutions and includes the following: storage, keyvault, sql, cosmosdb, web app, and many others.

Monitoring and alerting of PaaS resources can be classified into two different categories: 
- Deploy and configure Application Dynamics.
- Any combination of the above built in Azure monitoring and alerting tools.

Each of the above options has pros and cons to consider.  The best path regarding what needs to be monitored and which tool to perform the monitoring will need to be determined by the specific needs of the application team along with what items are most important to keep an eye on.  