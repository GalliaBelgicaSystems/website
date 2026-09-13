.PHONY: build serve clean

build: public/index.html public/CNAME

public/index.html: content/index.md templates/base.html assets/logo.png
	@mkdir -p public
	cp assets/logo.png public/
	pandoc --standalone --from markdown --to html5 \
	  --template templates/base.html --metadata title="GalliaBelgicaSystems" \
	  --output $@ $<

public/CNAME: CNAME
	@mkdir -p public
	cp CNAME public/CNAME

serve: build
	python3 -m http.server -d public 8000

clean:
	rm -rf public
