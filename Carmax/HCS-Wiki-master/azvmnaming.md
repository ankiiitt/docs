# Azure VM Naming Standard

All VMs need to adhere to the following naming standards:
Reference:  https://eskb.carmax.org/doku.php?id=server_host_names 
Every new Windows system server will consist of the following five elements at a minimum:

- Two or three letter Owning Team code: Denotes the team that owns the servers at the end of the day. Please reference this grid for details:

| Owning Team |	Character Code |
|-------------|----------------|
| Architecture | ARC |
| CAF-Systems	| CAF |
| Collaboration Technology	| CLB |
| Database Administrators | DBA |
| Enterprise Data Warehouse	| EDW |
| Enterprise Systems | ENT |
| End User Computing | EUC |
| Financial Systems	| FIN |
| HR-Systems | HRS |
| Hosted Compute Solutions | HCS |
| Information Security | IST |
| Loss Prevention | LP |
| Marketing Technology | MAR |
| Merchandising	| MER |
| NOC | NOC |
| Online Systems | OLS |
| QA/CM	| QCT |
| Recruiting Systems | RS |
| Store Sales | SAL |
| Systems Integration | SYS |
| TCOMM - Network Services	| TNS |
| TCOMM - Voice Services | TCM |

- Three letter System code: a code denoting the system or grouping of servers to which a server belongs (for example: “KRO” for Kronos, “CTX” for Citrix, etc.).

- Three letter Role code: A code denoting the role of the server within a system or grouping (“SQL” for SQL, “WEB” for IIS/web services, “APP” for Application, “FSV” for File Server, “UTL” for Utility, etc.).

- P/Q/D/T Status Code: Denotes environment - “P” for Production systems, “Q” for QA, “D” for Development, “T” for Test.
- Sequence Code: A two digit number, denoting both its location, and the order in which the server was built. This particular code/set of characters have historically been where we're seen the most deviation from the norm. With this new convention, servers will be numbered thusly:

| Sequence Code | DataCenter |
|---------------|------------|
| 0# | WestCreek |
| 1# | Primary DataCenter (Atos - Pittsburgh) |
| 2# | Secondary DataCenter (Atos - Irving) |
| 3# | Cloud DataCenter 1 (Azure East US) |
| 4# | Cloud DataCenter 2 (Azure West US) |
| 5# | CAF1/9002 (Carmax Auto Finance) |
| 6# | CAF2/9003 (Carmax Auto Finance) |
| 7# | Cloud DataCenter 3 (Azure Central US) |

The # indicates a number that will iterate with each similar role server added to the pool/cluster (i.e. > 11 & 12 for two Web servers in Pittsburgh, for example).

NOTE: 00, 10, 20, et. al., are not used in this convention. The limited ordinal range is x1-x9. 
Optional Standard Codes

The following are not required for every system, but for servers that meet the criteria of course:

    - Cluster Code: If the server is a part of a Windows cluster, use the code “CL” used to denote a clustered system, immediately before the “PQDT” indicator.
    - Secondary Cluster Code: A secondary single-letter character used in conjunction with the Cluster Code (“CL”) to denote the name of a clustered node (“A,” “B,” etc.).
    - DMZ Code: If the server resides in a DMZ, use the code “Z” to indicate a DMZ system, immediately before the “PQDT” indicator.

Examples:

Generic application server, App role, owned by Financial Systems, Development, Azure East - FINGENAPPD31

Kronos server, WRM role (Workforce Record Manager), owned by HR Systems, QA, Azure West – HRSKROWRMQ41
