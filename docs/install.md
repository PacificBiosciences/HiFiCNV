# Installing HiFiCNV
## From conda
The easiest way to install HiFiCNV is through [conda](https://docs.conda.io/projects/conda/en/stable/user-guide/install/index.html):

```bash
# create a brand new conda environment and install latest HiFiCNV
conda create -n hificnv -c bioconda hificnv
# OR install latest into current conda environment
conda install hificnv
# OR install a specific version into current conda environment
conda install hificnv=0.1.6b
```

## From GitHub
Conda updates usually lag the GitHub release by a couple days.
Use the following instructions to get the most recent version directly from GitHub:

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