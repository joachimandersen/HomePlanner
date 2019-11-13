FROM mcr.microsoft.com/dotnet/core/sdk:2.1 AS build-env

WORKDIR /app

# copy csproj and restore as distinct layers
COPY src/Calendar/Calendar.Api/*.csproj ./CalendarApi/

RUN pwd
RUN ls
RUN dotnet restore CalendarApi/Calendar.Api.csproj

# copy and build everything else
COPY src/Calendar/Calendar.Api/. ./CalendarApi/

RUN dotnet build CalendarApi/Calendar.Api.csproj

#FROM build AS publish
#WORKDIR /app/CalendarApi
#RUN dotnet publish -o out

FROM microsoft/dotnet:2.1-runtime AS runtime
WORKDIR /app
COPY /app/CalendarApi/bin/Debug/netcoreapp2.1/. ./
ENTRYPOINT ["dotnet", "Calendar.Api.dll"]
