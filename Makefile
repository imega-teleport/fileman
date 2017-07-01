build:
	@docker run --rm \
		-v $(CURDIR)/build:/go/bin \
		-e GOOS=linux \
		-e GOARCH=amd64 \
		-e CGO_ENABLED=0 \
		golang:1.8-alpine \
		sh -c 'apk --upd add git && go get -u github.com/imega-teleport/db2file'
# && go get -u github.com/imega-teleport/xml2db
	@docker built -t imegateleport/fileman .
