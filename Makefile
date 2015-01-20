.PHONY : init build install

init :
	[ -d .vendor ] || mkdir .vendor
	[ -d pebblejs ] || git clone https://github.com/pebble/pebblejs.git .vendor/pebblejs
	npm install

build :
	rm -rf src resources
	\cp .vendor/pebblejs/wscript ./
	cp -r .vendor/pebblejs/src/ ./
	cp -r .vendor/pebblejs/resources/ ./
	-[ -d source/resources ] && cp -r source/resources/* ./resources/
	`npm bin`/browserify --ignore-missing -t coffeeify --extension=".coffee" source/coffee/app.coffee > ./src/js/app.js
	pebble build

install : build
	pebble install
	pebble logs
