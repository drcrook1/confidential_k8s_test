docker stop conf_test
docker rm conf_test
docker build -t conf_test .
docker run --name conf_test --env-file ./dev.env -it conf_test