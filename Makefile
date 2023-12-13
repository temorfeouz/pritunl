key:
	docker exec -it pritunl pritunl setup-key
pass:
	docker exec -it pritunl pritunl default-password
build:
	docker-compose build
exec-pritunl:
	docker run -it --entrypoint sh pritunl
up:
	docker-compose up
down:
	docker-compose down
clean: down
	docker system prune -a