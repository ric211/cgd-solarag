
#SERVER =
#DIRECTORY =

JEKYLL = bundle exec jekyll

# LOGO	=

HASH	:= \#
# COLOR	= $(HASH)

ASSETS = \
	assets/fonts/fa-brands-400.eot \
	assets/fonts/fa-brands-400.svg \
	assets/fonts/fa-brands-400.ttf \
	assets/fonts/fa-brands-400.woff \
	assets/fonts/fa-brands-400.woff2 \
	assets/img/favicon.ico \
	assets/img/navbar-icon.png \
	assets/img/apple-touch-icon-192x192-precomposed.png \
	assets/img/apple-touch-icon-180x180-precomposed.png \
	assets/img/apple-touch-icon-152x152-precomposed.png \
	assets/img/apple-touch-icon-144x144-precomposed.png \
	assets/img/apple-touch-icon-120x120-precomposed.png \
	assets/img/apple-touch-icon-76x76-precomposed.png \
	assets/img/apple-touch-icon-72x72-precomposed.png \
	assets/img/apple-touch-icon-60x60-precomposed.png \
	assets/img/logo.png

CONVERT = magick convert

.PHONY: all
all: $(ASSETS)
	$(JEKYLL) build --incremental

.PHONY: serve
serve: all
	$(JEKYLL) serve

.PHONY: upload
upload: all
	rsync -avHz --delete --progress _site/ $(SERVER):$(DIRECTORY)

.PHONY: clean
clean:
	rm -rfv $(ASSETS)
	$(JEKYLL) clean

.PHONY: doctor
doctor:
	$(JEKYLL) doctor

assets/fonts/fa-%: _includes/Font-Awesome/webfonts/fa-%
	@echo " GEN  $@"
	@mkdir -p $(dir $@)
	@install -m 644 $< $@

assets/img/navbar-icon.png: $(LOGO) Makefile
	@echo " GEN  $@" && \
	$(CONVERT) -background none -flatten -density 1200 -bordercolor none \
		-resize 128x128 -fill white -colorize 100 $< $@

assets/img/favicon.ico: $(LOGO) Makefile
	@echo " GEN  $@" && \
	$(CONVERT) -background none -flatten -density 1200 -bordercolor none \
		-resize 64x64 -fill "$(COLOR)" -colorize 100 $< $@

assets/img/apple-touch-icon-%-precomposed.png: $(LOGO) Makefile
	@echo " GEN  $@" && \
	$(CONVERT) \
		-background none \
		-flatten \
		-density 1200 \
		-bordercolor none \
		-border 5%x5% \
		-fill "$(COLOR)" \
		-colorize 100 \
		-resize $(patsubst assets/img/apple-touch-icon-%-precomposed.png,%,$@) \
		-gravity center \
		-extent $(patsubst assets/img/apple-touch-icon-%-precomposed.png,%,$@)x$(patsubst assets/img/apple-touch-icon-%-precomposed.png,%,$@) \
		$< $@

assets/img/logo.png: $(LOGO) Makefile
	@echo " GEN  $@" && \
	$(CONVERT) \
		-background none \
		-flatten \
		-density 1200 \
		-bordercolor none \
		-border 5%x5% \
		-fill "$(COLOR)" \
		-colorize 100 \
		-resize 1024x1024 \
		-gravity center \
		-extent 1024x1024 \
		$< $@
