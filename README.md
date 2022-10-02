# solc-bin
The project mainly concern compile solc in aarch64 machine. for amd64/x86 binaries please ref [solc-bin](https://github.com/ethereum/solc-bin/).

## how to install

please replace `{version}` below.

> now only has `0.6.4` version.

```bash
wget https://raw.githubusercontent.com/GalaIO/solc-bin/master/linux-aarch64/solc_{version}
chmod +x solc_{version}
sudo mv solc_{version} /usr/local/bin/solc
solc --version
```

## how to build other version

### prepare

1. you should prepare a aarch64 machine first. you could create it in AWS.
2. you should install `git` `docker`, you could find installation instructions in many places.

### build from source

```bash
git clone https://github.com/GalaIO/solc-bin.git
cd solc-bin
docker build --tag solc-bin-build ./
docker run -it -v ~/build:/home/build solc-bin-build /bin/bash

# now, you are in container runtime
cd home/build/
git clone --recursive https://github.com/ethereum/solidity.git
cd solidity
# you could replace the target version, you want to compile
git checkout v0.6.4
mkdir build
cd build
cmake .. && make
exit
# you will see the solc binary in ~/build/solidity/build/solc/solc
```

That's all.

## other issue

### when you compile v0.6.4 in ubuntu/20.04 or ubuntu/22.04?

you will get some warning, and stop to compile.

when you find:

```bash
error: loop variable ‘arg’ creates a copy from type ‘const solidity::yul::TypedName’ [-Werror=range-loop-construct]
cc1plus: all warnings being treated as errors
```

just comment 36 line `add_compile_options(-Werror)`, in `cmake/EthCompilerSettings.cmake` file.

when you find:

```bash
error: ‘size_t’ was not declared in this scope; did you mean ‘std::size_t’?
```

just add `using std::size_t;` declare, in `solidity/tools/yulPhaser/Selections.h` file.

### when you find lost some `GLIBCXX_3.4.26` or `GLIBC_2.34` when run?

you should downgrade your docker image base, recommend you to use `buildpack-deps:bionic`.