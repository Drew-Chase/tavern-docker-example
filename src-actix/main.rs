#[actix_web::main]
async fn main()->anyhow::Result<()>{
	tavern_docker_example_lib::run().await
}
