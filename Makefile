BROWSERIFY = browserify
UGLIFY = node_modules/.bin/uglifyjs
LASTSHA=$$(git rev-parse HEAD)

test:
	node tests/provider-store-tests.js

run:
	wzrd app.js:index.js -- \
		-d

run-plain:
	python -m SimpleHTTPServer

run-summary-workspace:
	cd workspace/summary-render && wzrd summary-render-workspace.js -- -d

build:
	$(BROWSERIFY) app.js | $(UGLIFY) -c -m -o index.js

commit-build: build
	git commit -a -m"Build for $(LASTSHA)." || echo "No new build needed."

pushall: commit-build
	git push origin gh-pages
