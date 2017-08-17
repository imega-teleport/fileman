build: test
	@docker run --rm \
		-v $(CURDIR)/build:/go/bin \
		-e GOOS=linux \
		-e GOARCH=amd64 \
		-e CGO_ENABLED=0 \
		golang:1.8-alpine \
		sh -c 'apk --upd add git && go get -u github.com/imega-teleport/db2file && go get -u github.com/imega-teleport/xml2db'
	@docker build -t imegateleport/fileman .

release:
	@docker login --username $(DOCKER_USER) --password $(DOCKER_PASS)
	@docker push imegateleport/fileman

test:
	@docker run -d --name "teleport_db" \
		-v $(CURDIR)/conf.d/mysql:/etc/mysql/conf.d \
		imega/mysql
	@docker run --rm \
		-v $(CURDIR)/sql:/sql \
		--link teleport_db:s \
		imega/mysql-client \
		mysql --host=s -e "source /sql/create_db.sql"
	@docker run --rm \
		-v $(CURDIR)/sql:/sql \
		--link teleport_db:s \
		imega/mysql-client \
		mysql --host=s --database=teleport -e "source /sql/schema.sql"
