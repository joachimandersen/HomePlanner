FROM mcr.microsoft.com/dotnet/core/aspnet:2.1 AS base
WORKDIR /app
EXPOSE 80

FROM microsoft/dotnet:2.1-sdk AS build
WORKDIR /src
COPY ["Calendar/Calendar.Api/*.csproj", "Calendar.Api/"]
RUN dotnet restore "Calendar.Api/Calendar.Api.csproj"
COPY . .
WORKDIR "src/Calendar.Api"
RUN dotnet build "Calendar.Api.csproj" -c Release -o /app

FROM build AS publish
RUN dotnet publish "Calendar.Api.csproj" -c Release -o /app
#FROM build AS publish
#WORKDIR /app/CalendarApi
#RUN dotnet publish -o out

FROM base AS final
WORKDIR /app
COPY --from=publish /app .
ENTRYPOINT ["dotnet", "Calendar.Api.dll"]
