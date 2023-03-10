# Installing HiFiCNV
## Instructions
1. Navigate to the [latest release](https://github.com/PacificBiosciences/HiFiCNV/releases/latest) and download the tarball file (e.g. `hificnv-{version}-x86_64-unknown-linux-gnu.tar.gz`).
2. Decompress the tar file.
3. (Optional) Verify the md5 checksum.
4. Test the binary file by running it with the help option (`-h`).
5. Visit [Quickstart guide](./quickstart.md) for details on running HiFiCNV.

## Example with v0.1.3
```bash
# modify this to update the version
VERSION="v0.1.3"
# get the release file
wget https://github.com/PacificBiosciences/HiFiCNV/releases/download/${VERSION}/hificnv-${VERSION}-x86_64-unknown-linux-gnu.tar.gz
# decompress the file into folder ${VERSION}
tar -xzvf hificnv-${VERSION}-x86_64-unknown-linux-gnu.tar.gz
cd hificnv-${VERSION}-x86_64-unknown-linux-gnu
# optional, check the md5 sum
md5sum -c hificnv.md5
# execute help instructions
./hificnv -h
```