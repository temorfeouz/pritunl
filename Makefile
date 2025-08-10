key:
	docker exec -it pritunl pritunl setup-key
pass:
	docker exec -it pritunl pritunl default-password
build:
	docker-compose build
exec-pritunl:
	docker run -it --entrypoint sh pritunl
start:
	docker-compose start
stop:
	docker-compose stop
up:
	docker compose up
down:
	docker-compose down
clean: down
	docker system prune -a
genxuicerts:
	openssl req -x509 -newkey rsa:4096 -sha256 -nodes \
  -keyout runtime/xui/cert/key.pem \
  -out runtime/xui/cert/cert.pem \
  -days 3650 \
  -subj "/CN=www.microsoft.com"