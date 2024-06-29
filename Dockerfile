FROM mcr.microsoft.com/dotnet/sdk:6.0-cbl-mariner2.0 AS build

WORKDIR /config

RUN dotnet new tool-manifest

RUN dotnet tool install Microsoft.DataApiBuilder

RUN dotnet tool run dab -- init --database-type "mssql" --connection-string "@env('DATABASE_CONNECTION_STRING')"

RUN dotnet tool run dab -- add Product --source "dbo.Products" --permissions "anonymous:read"

FROM mcr.microsoft.com/azure-databases/data-api-builder

COPY --from=build /config /App
