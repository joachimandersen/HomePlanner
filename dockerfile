FROM mcr.microsoft.com/dotnet/core/aspnet:2.1 AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

FROM mcr.microsoft.com/dotnet/core/sdk:2.1 AS build
WORKDIR /src
RUN pwd
RUN ls
COPY ./Calendar/Calendar.csproj ./Calendar/
RUN dotnet restore "Calendar/Calendar.csproj"
RUN ls
COPY . .
RUN ls
WORKDIR "/src/Calendar"
RUN pwd
RUN ls
RUN dotnet build "Calendar.csproj" -c Release -o /app

FROM build AS publish
RUN dotnet publish "Calendar.csproj" -c Release -o /app

FROM base AS final
WORKDIR /app
COPY --from=publish /app .
ENTRYPOINT ["dotnet", "Calendar.dll"]
