all: build

build: lib resources/docs.js

lib: src
	./node_modules/.bin/coffee -c -o ./lib ./src

resources/docs.js: src
	cp -r ./src/vendor/client/*.js ./lib/client/
	cat ./lib/client/zepto.min.js > /tmp/sdjsmin
	cat ./lib/client/underscore-min.js >> /tmp/sdjsmin
	cat ./lib/client/docs.js >> /tmp/sdjsmin
	./node_modules/.bin/uglifyjs --overwrite /tmp/sdjsmin
	mv /tmp/sdjsmin ./resources/docs.js

test:
	./node_modules/.bin/nodeunit test

pages:
	./bin/styledocco -n StyleDocco -o ./ ./resources/docs.css

examples:
	./bin/styledocco -n StyleDocco -o ./examples/styledocco resources/docs.css
	cd ./examples/bootstrap && ../../bin/styledocco -n "Twitter Bootstrap" less/buttons.less

.PHONY: build test pages examples
