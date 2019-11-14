FROM mcr.microsoft.com/dotnet/core/aspnet:2.1 AS base
WORKDIR /app
EXPOSE 80

FROM microsoft/dotnet:2.1-sdk AS build
WORKDIR /app
COPY "src/Calendar/Calendar.Api/Calendar.Api.csproj", "Calendar.Api/"
RUN dotnet restore "Calendar.Api/Calendar.Api.csproj"
RUN dotnet build "Calendar.Api/Calendar.Api.csproj" -c Release -o /app

FROM build AS publish
RUN dotnet publish "Calendar.Api/Calendar.Api.csproj" -c Release -o /app

FROM base AS final
WORKDIR /app
COPY --from=publish /app .
ENTRYPOINT ["dotnet", "Calendar.Api.dll"]
