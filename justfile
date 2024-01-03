
# default recipe to display help information
_default:
	@ just --list --unsorted


# ripgrep for elements in braces -- to see mustache insertions
[no-cd]
template-rg *INSIDE:
	@ echo "-- NOTE: this is run from calling directory; not justfile directory. --"
	rg "\{\{.*{{INSIDE}}.*\}\}"

# Cargo run --release, plus optional installs for specific systems.
run-local-classic:
	cargo run --release

# run trunk server and open webpage to access it
run-local-wasm:
	rustup target add wasm32-unknown-unknown
	cargo install --locked trunk
	( sleep 2; open http://127.0.0.1:8080/index.html#dev )&
	trunk serve

web-deploy:
	trunk build --release
	@ echo "a static site has been loaded to dist/, you can add this to, for example, github pages"
	sleep 2
	open https://docs.github.com/en/free-pro-team@latest/github/working-with-github-pages/configuring-a-publishing-source-for-your-github-pages-site

# nominal requirements for linux (note: I have not tested these)
[linux]
[confirm]
linux-install:
	sudo apt-get install libxcb-render0-dev libxcb-shape0-dev libxcb-xfixes0-dev libxkbcommon-dev libssl-dev

# nominal requirements for fed-raw (note: I have not tested these)
[linux]
[confirm]
fedora-rawhide-install:
	dnf install clang clang-devel clang-tools-extra libxkbcommon-devel pkg-config openssl-devel libxcb-devel gtk3-devel atk fontconfig-devel

