FROM mcr.microsoft.com/dotnet/core/sdk:2.2 AS build-env
WORKDIR src/Calendar/Calendar.Api

RUN dotnet restore

RUN dotnet publish -c Release -o out

# Build runtime image
FROM mcr.microsoft.com/dotnet/core/aspnet:2.2
WORKDIR src/Calendar/Calendar.Api
COPY --from=build-env /src/out .
ENTRYPOINT ["dotnet", "aspnetapp.dll"]
