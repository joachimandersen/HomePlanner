FROM mcr.microsoft.com/dotnet/core/aspnet:2.1 AS base
WORKDIR /app
EXPOSE 80

FROM microsoft/dotnet:2.1-sdk AS build
WORKDIR /app
COPY src/Calendar/Calendar.Api/*.csproj ./CalendarApi/
RUN dotnet restore "CalendarApi/Calendar.Api.csproj"
RUN dotnet build "CalendarApi/Calendar.Api.csproj" -c Release -o /app

FROM build AS publish
RUN dotnet publish "CalendarApi/Calendar.Api.csproj" -c Release -o /app

FROM base AS final
WORKDIR /app
COPY --from=publish /app .
ENTRYPOINT ["dotnet", "Calendar.Api.dll"]
