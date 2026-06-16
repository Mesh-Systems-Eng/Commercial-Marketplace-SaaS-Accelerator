# Deployment Notes

## Mesh Deployment

[Deployed to Mesh Tenant](https://portal.azure.com/#@meshsystems.com/resource/subscriptions/13e3ba18-4cd3-4abd-b6b9-945258a5236f/resourceGroups/rg-marketplace-accelerator-pd/overview)

## Deployment Parameters

```powershell
./Deploy.ps1 `
 -WebAppNamePrefix "PdMarketAccel" `
 -ResourceGroupForDeployment "rg-marketplace-accelerator-pd" `
 -PublisherAdminUsers "austin.delarosa@meshsystems.com,mike.coleman@meshsystems.com,kyle.burns@meshsystems.com" `
 -Location "Central US" `
 -AzureSubscriptionID "13e3ba18-4cd3-4abd-b6b9-945258a5236f" `
 -TenantID "d49110b2-6f26-4c66-b723-1729cdb9a3cf"
```

## macOS Prerequisites

Run from PowerShell 7 (`pwsh`). The repo has a `global.json` pin for .NET SDK `8.0.303`, so .NET 10 alone is not enough.

```powershell
az login --tenant d49110b2-6f26-4c66-b723-1729cdb9a3cf
Invoke-WebRequest https://dot.net/v1/dotnet-install.sh -OutFile dotnet-install.sh
chmod +x ./dotnet-install.sh
./dotnet-install.sh -version 8.0.303
$ENV:PATH="$HOME/.dotnet:$HOME/.dotnet/tools:$ENV:PATH"
dotnet tool install --global dotnet-ef --version 8.0.6
Install-Module -Name Az -AllowClobber
Install-Module -Name SqlServer -AllowClobber
```

## Known Issues Fixed Locally

- `Get-AzureRmSqlServer` failed because AzureRM cmdlets are deprecated and not available on the Mac setup. `Deploy.ps1` now uses `Get-AzSqlServer`.
- `Compress-Archive` failed with missing `../Publish` because `dotnet publish` failed before package creation. The script now checks the required .NET SDK, creates `../Publish`, and fails fast after each publish command.
- `Invoke-Sqlcmd` failed because it is provided by the `SqlServer` PowerShell module. Install it with `Install-Module -Name SqlServer -AllowClobber`.
- `dotnet-ef 8.0.0` emitted a version warning against EF Core runtime `8.0.6`. Use `dotnet-ef 8.0.6` for this repo.
- SQL migration execution failed with `Conversion failed when converting date and/or time from character string` because generated seed SQL used local-culture `DateTime.Now` strings from macOS. `BaselineV2_Seed.cs` now emits ISO 8601 UTC datetime strings for SQL Server-safe seed values.

## Created App Registrations

- Fulfillment API App Registration: `fab1c0bb-f913-4d5a-a304-e55561f06c6b`
- Admin Portal SSO App Registration: `4698951b-b2af-4e93-8b72-29b41b63710d`
- Landing Page SSO App Registration: `6ba6401e-4244-4b5a-ab14-80567b94ef4a`
