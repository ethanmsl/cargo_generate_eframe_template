# [cargo-generate](https://github.com/cargo-generate/cargo-generate) adaptation of [eframe template](https://github.com/emilk/eframe_template)

## status:

<details>
  <summary> Boring status details; though possibly useful if you wandered/searched your way here </summary>
  
- The cargo-generate template works completely, as of posting of this message.  
- The ease-of-use runner commands mostly work, but are at an early stage.
  - (In particular, the publication command doesn't do much.  There are also to command that only appear on linux systems and offer (with confirm) to install additional prereqs needed to compile to WASM.  These have not been tested.
- There are not currently any mechanisms that keep this in lock with the original [egui/eframe_template](https://github.com/emilk/eframe_template).  If you're viewing this much later than these comments were written you may want to check for freshness.

</details>

## to use:

Prerequisites:

- [rust](https://www.rust-lang.org/tools/install), [cargo-generate](https://github.com/cargo-generate/cargo-generate)

For additional convenience (when using built-in command runner):

- [just](https://github.com/casey/just), [ripgrep](https://github.com/BurntSushi/ripgrep), [sd](https://github.com/chmln/sd).

<details>
  <summary> Quick Install Commands, if desired </summary>
    
If you already [have rust installed](https://www.rust-lang.org/tools/install) then just:
    
```shell
cargo install cargo-generate
cargo install just
cargo install ripgrep
cargo install sd
```

</details>

---

1. Generate project:

```shell
cargo generate --git gh:cargo_generate_eframe_template
```

<img width="600" alt="etemplate-generate" src="https://github.com/ethanmsl/eframe_template_test/assets/33399972/72b056de-feca-4d93-9394-0fc1294c5cab">

2. Follow manual instructions below, optionally use command runner:
   The following will list commands:

```shell
just
```

<img width="600" alt="just commands" src="https://github.com/ethanmsl/eframe_template_test/assets/33399972/40b9cfbe-1fec-4c9b-84d0-9b5f42028855">

---

# Table of Contents:

<!--toc:start-->

- [status](#status)
- [cargo-generate adaptation of eframe template](#cargo-generate-adaptation-of-eframe-template)
  - [to use:](#to-use)
- [Original Readme:](#original-readme)
  - [Getting started](#getting-started)
    - [Learning about egui](#learning-about-egui)
    - [Testing locally](#testing-locally)
    - [Web Locally](#web-locally)
    - [Web Deploy](#web-deploy)
  - [Updating egui](#updating-egui)
  <!--toc:end-->

---

# Original Readme:

This is a template repo for [eframe](https://github.com/emilk/egui/tree/master/crates/eframe), a framework for writing apps using [egui](https://github.com/emilk/egui/).

The goal is for this to be the simplest way to get started writing a GUI app in Rust.

You can compile your app natively or for the web, and share it using Github Pages.

## Getting started

Start by clicking "Use this template" at https://github.com/emilk/eframe_template/ or follow [these instructions](https://docs.github.com/en/free-pro-team@latest/github/creating-cloning-and-archiving-repositories/creating-a-repository-from-a-template).

Change the name of the crate: Chose a good name for your project, and change the name to it in:

- `Cargo.toml`
  - Change the `package.name` from `eframe_template` to `your_crate`.
  - Change the `package.authors`
- `main.rs`
  - Change `eframe_template::TemplateApp` to `your_crate::TemplateApp`
- `index.html`
  - Change the `<title>eframe template</title>` to `<title>your_crate</title>`. optional.
- `assets/sw.js`
  - Change the `'./eframe_template.js'` to `./your_crate.js` (in `filesToCache` array)
  - Change the `'./eframe_template_bg.wasm'` to `./your_crate_bg.wasm` (in `filesToCache` array)

Manual change to mustache-insertions via:

```shell
sd 'eframe_template' '{{crate_name}}' Cargo.toml src/main.rs assets/sw.js
sd 'emilk/eframe_template' '{{author_github_name}}/{{crate_name}}' src/app.rs
sd 'eframe template' '{{crate_name | title_case}}' index.html
sd '(authors = ).*' '${1}["{{authors}}"]' Cargo.toml
git diff
```

### Learning about egui

`src/app.rs` contains a simple example app. This is just to give some inspiration - most of it can be removed if you like.

The official egui docs are at <https://docs.rs/egui>. If you prefer watching a video introduction, check out <https://www.youtube.com/watch?v=NtUkr_z7l84>. For inspiration, check out the [the egui web demo](https://emilk.github.io/egui/index.html) and follow the links in it to its source code.

### Testing locally

Make sure you are using the latest version of stable rust by running `rustup update`.

`cargo run --release`

On Linux you need to first run:

`sudo apt-get install libxcb-render0-dev libxcb-shape0-dev libxcb-xfixes0-dev libxkbcommon-dev libssl-dev`

On Fedora Rawhide you need to run:

`dnf install clang clang-devel clang-tools-extra libxkbcommon-devel pkg-config openssl-devel libxcb-devel gtk3-devel atk fontconfig-devel`

### Web Locally

You can compile your app to [WASM](https://en.wikipedia.org/wiki/WebAssembly) and publish it as a web page.

We use [Trunk](https://trunkrs.dev/) to build for web target.

1. Install the required target with `rustup target add wasm32-unknown-unknown`.
2. Install Trunk with `cargo install --locked trunk`.
3. Run `trunk serve` to build and serve on `http://127.0.0.1:8080`. Trunk will rebuild automatically if you edit the project.
4. Open `http://127.0.0.1:8080/index.html#dev` in a browser. See the warning below.

> `assets/sw.js` script will try to cache our app, and loads the cached version when it cannot connect to server allowing your app to work offline (like PWA).
> appending `#dev` to `index.html` will skip this caching, allowing us to load the latest builds during development.

### Web Deploy

1. Just run `trunk build --release`.
2. It will generate a `dist` directory as a "static html" website
3. Upload the `dist` directory to any of the numerous free hosting websites including [GitHub Pages](https://docs.github.com/en/free-pro-team@latest/github/working-with-github-pages/configuring-a-publishing-source-for-your-github-pages-site).
4. we already provide a workflow that auto-deploys our app to GitHub pages if you enable it.
   > To enable Github Pages, you need to go to Repository -> Settings -> Pages -> Source -> set to `gh-pages` branch and `/` (root).
   >
   > If `gh-pages` is not available in `Source`, just create and push a branch called `gh-pages` and it should be available.

You can test the template app at <https://emilk.github.io/eframe_template/>.

## Updating egui

As of 2023, egui is in active development with frequent releases with breaking changes. [eframe_template](https://github.com/emilk/eframe_template/) will be updated in lock-step to always use the latest version of egui.

When updating `egui` and `eframe` it is recommended you do so one version at the time, and read about the changes in [the egui changelog](https://github.com/emilk/egui/blob/master/CHANGELOG.md) and [eframe changelog](https://github.com/emilk/egui/blob/master/crates/eframe/CHANGELOG.md).
