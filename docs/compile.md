# Compilation / build steps
This document contains the steps for build and running HiFiCNV.

## Build from source (cluster / local device)
For most internal resources (e.g. cluster and local devices like laptops), the recommended approach is to compile from source.
Assuming you already have git and cargo (Rust) installed, it's a relatively simple process:

```bash
# One-time setup
git clone ssh://git@bitbucket.nanofluidics.com:7999/cr/dtracks.git
cd dtracks

# Each time build
cargo build --release

# Either of these will run the tool
cargo run --release -- -h
./target/release/hificnv -h 
```

## Cross-compile on Mac for Linux for public release
When compiling for public release (target = `x86_64-unknown-linux-gnu`), the following steps can be completed on a Mac with the Apple M1 chip.
At this time, this does seem to reduce the through-put of the tool, likely due to the generic target.

### One-time setup
1. Install the latest [Homebrew](https://brew.sh) if it is not already installed.
2. Install zlib and an unknown Linux GNU compiler:
```bash
brew install zlib
brew install SergioBenitez/osxct/x86_64-unknown-linux-gnu
```
3. Add the rust target:
```bash
rustup target add x86_64-unknown-linux-gnu
```

### Compile
Assuming brew has installed things in the normal locations, the following script should compile HiFiCNV with the correct target.
If errors appear, check the locations provided in the shell script to verify brew installed in the same locations:
```bash
./build_x86_64-unknown-linux-gnu.sh
```
