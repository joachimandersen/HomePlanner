FROM mcr.microsoft.com/dotnet/core/sdk:2.1 AS build-env

WORKDIR /app

# copy csproj and restore as distinct layers
COPY src/Calendar/Calendar.Api/Calendar.Api.csproj ./CalendarApi/
RUN pwd
RUN ls
RUN dotnet restore

# copy and build everything else
COPY CalendarApi/. ./CalendarApi/

RUN dotnet build

FROM build AS publish
WORKDIR /app/dotnetapp
RUN dotnet publish -o out

FROM microsoft/dotnet:2.1-runtime AS runtime
WORKDIR /app
COPY --from=publish /app/dotnetapp/out ./
ENTRYPOINT ["dotnet", "dotnetapp.dll"]
