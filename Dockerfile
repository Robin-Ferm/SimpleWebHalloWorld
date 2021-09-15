# Getting the SDK from the microsft servers
FROM mcr.microsoft.com/dotnet/sdk:5.0-alpine AS build-env
# The WORKDIR instruction sets the working directory for any RUN, CMD, ENTRYPOINT, COPY and ADD instructions that follow it in the Dockerfile 
WORKDIR /app
# Copying files from csproj into our Docker image.
COPY *.csproj ./
RUN dotnet restore

# Copying everything else and build
COPY . ./
RUN dotnet publish -c Release -o out

# Build runtime image
FROM mcr.microsoft.com/dotnet/aspnet:5.0-alpine
WORKDIR /app
COPY --from=build-env /app/out .
ENTRYPOINT ["dotnet", "SimpleWebHalloWorld.dll"]
