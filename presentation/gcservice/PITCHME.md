GrowthChart-Server
===

---

# Agenda

- Requirements
- ASP.NET Core
- Server structure
- End-to-end testing

---

# Requirements

- Data stored as EHR archetypes
- AQL queries &rarr; Domain objects
  - E.g. "Give me all height registrations for patient x"
- _**Microservice**_ architecture


![](./gcs_architecture.png)

---

# ASP.NET Core
- Complete redesign of the ASP stack
- Lightweight
- Platform independent
- Targets .NET 4.x, Standard and Core

---

## [Kestrel](https://docs.microsoft.com/en-us/aspnet/core/fundamentals/servers/kestrel?tabs=aspnetcore2x)

ASP.NET Core web server

- Self-host

![](./kestrel-to-internet2.png)

- or behind _reverse proxy_

![](./kestrel-to-internet.png)

---

##### Simple setup:
```shell
mkdir demo
cd demo
dotnet new webapi
```

---

#### Simple IIS:
- In your project:

  Add a the IIS integration package,  (already included in metapackage `Microsoft.AspNetCore`)

  ```
  dotnet add package Microsoft.AspNetCore.Server.IISIntegration
  ```

- On the IIS host:
  Install the ASP.NET Core Module ([ANCM](https://docs.microsoft.com/en-us/aspnet/core/fundamentals/servers/aspnet-core-module?tabs=aspnetcore2x))

  ```
  choco install dotnetcore-windowshosting
  ```

  ​

  ​

