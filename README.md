# Yocto BSP's

Repo to build custom BSP images

## Building

For instructions on building a BSP, see the [Build Instructions](./docs/BUILD.md) in the documents folder.

## Layout

Layers are located in the `./layers` directory, separated by type.

### Common

This folder contains common/custom layers from my personal GitHub Account.

Layers:

1. meta-beaglev-tcook
   * Layer for building BSP for BeagleV development boards
2. meta-raspberrypi-tcook
   * Layer for building BSP for Raspberry Pi boards
3. meta-tcook-common
   * Common recipes shared with all BSP builds

### Open-Source

This folder contains various open-source layers, and can originate from many different websites.

Layers:

1. meta-arm
   * Layer for ARM recipes
   * Contains various sub-layers for building more complex ARM BSPs
2. meta-lts-mixins
   * Layer for various fixes (currently used for RPi U-Boot when building scarthgap)
3. meta-raspberrypi
   * Raspberry Pi Layer
   * Used for all Raspberry Pi boards
4. meta-security
   * Various Security Recipes
   * Contains various sub-layers for stronger security, such as TPM device drivers, scanner drivers, etc.
5. meta-virtualization
   * Used for process/kernel/processor virtualization, not VM-related
   * Contains various sub-layers for adding graphic drivers, networking, OCI container handling, etc.
6. poky
   * Base layer for all of this to work at all
   * Contains sub-layers that provide the _skeleton_ for the rest of the BSP to build on.
7. meta-clang
   * Clang C/C++ Compiler based on LLVM
8. meta-openembedded
   * Embedded Linux recipes
   * Contains various sub-layers for extra programs/features that an embedded Linux implementation may need.
9. meta-secure-core
   * More Security recipes, moreso for system hardening
   * Contains various sub-layers for more comprehensive security (TPM2 drivers/software, for example), efi secure boot, and others.
10. meta-swupdate
    * Used for updating BSP using the swupdate process
11. meta-riscv
    * Layers for RISC-V Processors

### Other Repos

Other repositories are included in order to run the build process and/or automate and further streamline the process.

1. `whisk`
   * Tool to enable multiple configurations to be defined in [a single config file](./whisk.yaml)
2. `layers/pyrex`
   * Tool that runs bitbake inside of a Docker container.
   * Can be customized with its [config file](layers/pyrex.ini), but it works fine as it is.

