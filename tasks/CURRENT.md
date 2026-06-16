# Current Tasks

## Goal

Deploy the Commercial Marketplace SaaS Accelerator from macOS.

## Context

The deployment script fails in PowerShell with:

```text
Deploy.ps1: The term 'Get-AzureRmSqlServer' is not recognized as a name of a cmdlet, function, script file, or executable program.
```

The command being run passes `WebAppNamePrefix`, deployment resource group, publisher admin users, Azure location, subscription ID, and tenant ID.

## Tasks

- [x] Inspect `Deploy.ps1` and supporting deployment scripts.
- [x] Identify all AzureRM module dependencies and deprecated cmdlets.
- [x] Convert the deployment flow to macOS-compatible Az PowerShell cmdlets where feasible.
- [x] Validate script syntax and any available non-destructive checks.
- [x] Document the macOS deployment command and required prerequisites if missing.

## Progress

- Replaced deprecated `Get-AzureRmSqlServer` with `Get-AzSqlServer`.
- Updated local deployment documentation for macOS/PowerShell 7 usage.
- Verified `Deploy.ps1` parses successfully in PowerShell 7.
- Verified no remaining AzureRM references in PowerShell scripts.
- Verified `Get-AzSqlServer` is available in the local PowerShell environment.
- Fixed package preparation so `../Publish` is created before compression.
- Added fail-fast checks after each `dotnet publish` command so publish errors are reported directly instead of surfacing as `Compress-Archive` path errors.
- Found local .NET SDK mismatch: `global.json` requires `8.0.303`, but only `10.0.108` is installed.
- Restored deploy script preflight validation for the required .NET 8 SDK.
- Added macOS documentation for installing .NET SDK `8.0.303` and `dotnet-ef`.
- Added `$HOME/.dotnet/tools` to `PATH` during deployment and preflight validation for `dotnet-ef`.
- Added preflight validation for `Invoke-Sqlcmd` and documented the `SqlServer` PowerShell module dependency.
- Updated documented `dotnet-ef` version from `8.0.0` to `8.0.6` to match EF Core package references.
- Fixed `BaselineV2_Seed.cs` to emit ISO 8601 UTC seed dates instead of local-culture `DateTime.Now` strings that SQL Server could not parse.

## Notes

- Do not run destructive Azure deployment operations without explicit user approval.
- Git write operations require explicit user approval.
