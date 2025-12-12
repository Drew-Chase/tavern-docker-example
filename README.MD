# Tavern Docker Example
This is an example of how to use Tavern with Docker.

## Prerequisites
- Docker installed on your machine.

## Build the Container
To run this example, follow these steps:
### Clone the repository.
> ### Note:   
> The `--depth 1` flag is used to only clone the latest commit. This will make cloning faster but is not required.
```bash 
git clone https://github.com/Drew-Chase/tavern-docker-example.git --depth 1
```
### Build the Docker image.
```bash
docker build -t tavern-docker-example .
```
### Run the Docker container.   
Replace the port number with the port you want to use.  This project is using port `3698`.
```bash
 docker run -d --name tavern-docker-example -p 3698:3698 tavern-docker-example
```
### Access the application.
Open your browser and navigate to `http://localhost:3698`.

## Publish the Container to GitHub Container Registry
To publish the container to GitHub Container Registry, first generate a [GitHub Personal Access Token (Classic)](https://github.com/settings/tokens) with the following permissions:
- `read:packages`
- `write:packages`
- `delete:packages`
once the token is generated save it in a secure location.
run `docker login ghcr.io -u <your-username> -p <your-token>`
> ### Note:
> When building the container for the GitHub Container Registry, you need to prepend the name with `ghcr.io/<your-username>/`, for example 
> ```bash
> docker build -t ghcr.io/<your-username>/tavern-docker-example .
> ```
Then push the container to the registry using the following command:
```bash
docker push ghcr.io/<your-username>/tavern-docker-example
```
Replace `<your-username>` with your GitHub username.