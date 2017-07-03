build:
	@docker run --rm \
		-v $(CURDIR)/build:/go/bin \
		-e GOOS=linux \
		-e GOARCH=amd64 \
		-e CGO_ENABLED=0 \
		golang:1.8-alpine \
		sh -c 'apk --upd add git && go get -u github.com/imega-teleport/db2file'
	@docker build -t imegateleport/fileman .

release:
	@docker login --username $(DOCKER_USER) --password $(DOCKER_PASS)
	@docker push imegateleport/fileman
