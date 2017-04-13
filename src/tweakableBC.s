# File: tweakableBC.s
# Date: 26, April, 2016
# Usage: tweakableBC.c implementation on ARM Cortex-M4, optimized for code size

        .thumb
# =============================================================================
# Data section
# =============================================================================
        .data
        .align  2
TeH:
    .2byte   0x33dd, 0xd968, 0x4616, 0x6feb, 0x2e32, 0x855e, 0xed7a, 0xc487
    .2byte   0xaca3, 0x07cf, 0x1a20, 0x7204, 0x5bf9, 0xb14c, 0x98b1, 0xf095
    .2byte   0x9d86, 0x7733, 0xe84d, 0xc1b0, 0x8069, 0x2b05, 0x4321, 0x6adc
    .2byte   0x02f8, 0xa994, 0xb47b, 0xdc5f, 0xf5a2, 0x1f17, 0x36ea, 0x5ece
    .2byte   0x6461, 0x8ed4, 0x11aa, 0x3857, 0x798e, 0xd2e2, 0xbac6, 0x933b
    .2byte   0xfb1f, 0x5073, 0x4d9c, 0x25b8, 0x0c45, 0xe6f0, 0xcf0d, 0xa729
    .2byte   0xf6be, 0x1c0b, 0x8375, 0xaa88, 0xeb51, 0x403d, 0x2819, 0x01e4
    .2byte   0x69c0, 0xc2ac, 0xdf43, 0xb767, 0x9e9a, 0x742f, 0x5dd2, 0x35f6
    .2byte   0xe223, 0x0896, 0x97e8, 0xbe15, 0xffcc, 0x54a0, 0x3c84, 0x1579
    .2byte   0x7d5d, 0xd631, 0xcbde, 0xa3fa, 0x8a07, 0x60b2, 0x494f, 0x216b
    .2byte   0x58e5, 0xb250, 0x2d2e, 0x04d3, 0x450a, 0xee66, 0x8642, 0xafbf
    .2byte   0xc79b, 0x6cf7, 0x7118, 0x193c, 0x30c1, 0xda74, 0xf389, 0x9bad
    .2byte   0xdea7, 0x3412, 0xab6c, 0x8291, 0xc348, 0x6824, 0x0000, 0x29fd
    .2byte   0x41d9, 0xeab5, 0xf75a, 0x9f7e, 0xb683, 0x5c36, 0x75cb, 0x1def
    .2byte   0x4c78, 0xa6cd, 0x39b3, 0x104e, 0x5197, 0xfafb, 0x92df, 0xbb22
    .2byte   0xd306, 0x786a, 0x6585, 0x0da1, 0x245c, 0xcee9, 0xe714, 0x8f30
    .2byte   0xca3a, 0x208f, 0xbff1, 0x960c, 0xd7d5, 0x7cb9, 0x149d, 0x3d60
    .2byte   0x5544, 0xfe28, 0xe3c7, 0x8be3, 0xa21e, 0x48ab, 0x6156, 0x0972
    .2byte   0x70fc, 0x9a49, 0x0537, 0x2cca, 0x6d13, 0xc67f, 0xae5b, 0x87a6
    .2byte   0xef82, 0x44ee, 0x5901, 0x3125, 0x18d8, 0xf26d, 0xdb90, 0xb3b4
    .2byte   0xa102, 0x4bb7, 0xd4c9, 0xfd34, 0xbced, 0x1781, 0x7fa5, 0x5658
    .2byte   0x3e7c, 0x9510, 0x88ff, 0xe0db, 0xc926, 0x2393, 0x0a6e, 0x624a
    .2byte   0x2740, 0xcdf5, 0x528b, 0x7b76, 0x3aaf, 0x91c3, 0xf9e7, 0xd01a
    .2byte   0xb83e, 0x1352, 0x0ebd, 0x6699, 0x4f64, 0xa5d1, 0x8c2c, 0xe408
    .2byte   0xb59f, 0x5f2a, 0xc054, 0xe9a9, 0xa870, 0x031c, 0x6b38, 0x42c5
    .2byte   0x2ae1, 0x818d, 0x9c62, 0xf446, 0xddbb, 0x370e, 0x1ef3, 0x76d7
    .2byte   0x1bc4, 0xf171, 0x6e0f, 0x47f2, 0x062b, 0xad47, 0xc563, 0xec9e
    .2byte   0x84ba, 0x2fd6, 0x3239, 0x5a1d, 0x73e0, 0x9955, 0xb0a8, 0xd88c
    .2byte   0x891b, 0x63ae, 0xfcd0, 0xd52d, 0x94f4, 0x3f98, 0x57bc, 0x7e41
    .2byte   0x1665, 0xbd09, 0xa0e6, 0xc8c2, 0xe13f, 0x0b8a, 0x2277, 0x4a53
    .2byte   0x0f59, 0xe5ec, 0x7a92, 0x536f, 0x12b6, 0xb9da, 0xd1fe, 0xf803
    .2byte   0x9027, 0x3b4b, 0x26a4, 0x4e80, 0x677d, 0x8dc8, 0xa435, 0xcc11

TeL:
    .2byte   0xdd33, 0x68d9, 0x1646, 0xeb6f, 0x322e, 0x5e85, 0x7aed, 0x87c4
    .2byte   0xa3ac, 0xcf07, 0x201a, 0x0472, 0xf95b, 0x4cb1, 0xb198, 0x95f0
    .2byte   0x869d, 0x3377, 0x4de8, 0xb0c1, 0x6980, 0x052b, 0x2143, 0xdc6a
    .2byte   0xf802, 0x94a9, 0x7bb4, 0x5fdc, 0xa2f5, 0x171f, 0xea36, 0xce5e
    .2byte   0x6164, 0xd48e, 0xaa11, 0x5738, 0x8e79, 0xe2d2, 0xc6ba, 0x3b93
    .2byte   0x1ffb, 0x7350, 0x9c4d, 0xb825, 0x450c, 0xf0e6, 0x0dcf, 0x29a7
    .2byte   0xbef6, 0x0b1c, 0x7583, 0x88aa, 0x51eb, 0x3d40, 0x1928, 0xe401
    .2byte   0xc069, 0xacc2, 0x43df, 0x67b7, 0x9a9e, 0x2f74, 0xd25d, 0xf635
    .2byte   0x23e2, 0x9608, 0xe897, 0x15be, 0xccff, 0xa054, 0x843c, 0x7915
    .2byte   0x5d7d, 0x31d6, 0xdecb, 0xfaa3, 0x078a, 0xb260, 0x4f49, 0x6b21
    .2byte   0xe558, 0x50b2, 0x2e2d, 0xd304, 0x0a45, 0x66ee, 0x4286, 0xbfaf
    .2byte   0x9bc7, 0xf76c, 0x1871, 0x3c19, 0xc130, 0x74da, 0x89f3, 0xad9b
    .2byte   0xa7de, 0x1234, 0x6cab, 0x9182, 0x48c3, 0x2468, 0x0000, 0xfd29
    .2byte   0xd941, 0xb5ea, 0x5af7, 0x7e9f, 0x83b6, 0x365c, 0xcb75, 0xef1d
    .2byte   0x784c, 0xcda6, 0xb339, 0x4e10, 0x9751, 0xfbfa, 0xdf92, 0x22bb
    .2byte   0x06d3, 0x6a78, 0x8565, 0xa10d, 0x5c24, 0xe9ce, 0x14e7, 0x308f
    .2byte   0x3aca, 0x8f20, 0xf1bf, 0x0c96, 0xd5d7, 0xb97c, 0x9d14, 0x603d
    .2byte   0x4455, 0x28fe, 0xc7e3, 0xe38b, 0x1ea2, 0xab48, 0x5661, 0x7209
    .2byte   0xfc70, 0x499a, 0x3705, 0xca2c, 0x136d, 0x7fc6, 0x5bae, 0xa687
    .2byte   0x82ef, 0xee44, 0x0159, 0x2531, 0xd818, 0x6df2, 0x90db, 0xb4b3
    .2byte   0x02a1, 0xb74b, 0xc9d4, 0x34fd, 0xedbc, 0x8117, 0xa57f, 0x5856
    .2byte   0x7c3e, 0x1095, 0xff88, 0xdbe0, 0x26c9, 0x9323, 0x6e0a, 0x4a62
    .2byte   0x4027, 0xf5cd, 0x8b52, 0x767b, 0xaf3a, 0xc391, 0xe7f9, 0x1ad0
    .2byte   0x3eb8, 0x5213, 0xbd0e, 0x9966, 0x644f, 0xd1a5, 0x2c8c, 0x08e4
    .2byte   0x9fb5, 0x2a5f, 0x54c0, 0xa9e9, 0x70a8, 0x1c03, 0x386b, 0xc542
    .2byte   0xe12a, 0x8d81, 0x629c, 0x46f4, 0xbbdd, 0x0e37, 0xf31e, 0xd776
    .2byte   0xc41b, 0x71f1, 0x0f6e, 0xf247, 0x2b06, 0x47ad, 0x63c5, 0x9eec
    .2byte   0xba84, 0xd62f, 0x3932, 0x1d5a, 0xe073, 0x5599, 0xa8b0, 0x8cd8
    .2byte   0x1b89, 0xae63, 0xd0fc, 0x2dd5, 0xf494, 0x983f, 0xbc57, 0x417e
    .2byte   0x6516, 0x09bd, 0xe6a0, 0xc2c8, 0x3fe1, 0x8a0b, 0x7722, 0x534a
    .2byte   0x590f, 0xece5, 0x927a, 0x6f53, 0xb612, 0xdab9, 0xfed1, 0x03f8
    .2byte   0x2790, 0x4b3b, 0xa426, 0x804e, 0x7d67, 0xc88d, 0x35a4, 0x11cc
        
TdH:
    .2byte   0xddbb, 0x031c, 0xa870, 0x5f2a, 0x2ae1, 0xb59f, 0x370e, 0x818d
    .2byte   0x1ef3, 0x9c62, 0x42c5, 0xe9a9, 0x76d7, 0xf446, 0x6b38, 0xc054
    .2byte   0x30c1, 0xee66, 0x450a, 0xb250, 0xc79b, 0x58e5, 0xda74, 0x6cf7
    .2byte   0xf389, 0x7118, 0xafbf, 0x04d3, 0x9bad, 0x193c, 0x8642, 0x2d2e
    .2byte   0x8a07, 0x54a0, 0xffcc, 0x0896, 0x7d5d, 0xe223, 0x60b2, 0xd631
    .2byte   0x494f, 0xcbde, 0x1579, 0xbe15, 0x216b, 0xa3fa, 0x3c84, 0x97e8
    .2byte   0xf5a2, 0x2b05, 0x8069, 0x7733, 0x02f8, 0x9d86, 0x1f17, 0xa994
    .2byte   0x36ea, 0xb47b, 0x6adc, 0xc1b0, 0x5ece, 0xdc5f, 0x4321, 0xe84d
    .2byte   0xa21e, 0x7cb9, 0xd7d5, 0x208f, 0x5544, 0xca3a, 0x48ab, 0xfe28
    .2byte   0x6156, 0xe3c7, 0x3d60, 0x960c, 0x0972, 0x8be3, 0x149d, 0xbff1
    .2byte   0x5bf9, 0x855e, 0x2e32, 0xd968, 0xaca3, 0x33dd, 0xb14c, 0x07cf
    .2byte   0x98b1, 0x1a20, 0xc487, 0x6feb, 0xf095, 0x7204, 0xed7a, 0x4616
    .2byte   0x73e0, 0xad47, 0x062b, 0xf171, 0x84ba, 0x1bc4, 0x9955, 0x2fd6
    .2byte   0xb0a8, 0x3239, 0xec9e, 0x47f2, 0xd88c, 0x5a1d, 0xc563, 0x6e0f
    .2byte   0x18d8, 0xc67f, 0x6d13, 0x9a49, 0xef82, 0x70fc, 0xf26d, 0x44ee
    .2byte   0xdb90, 0x5901, 0x87a6, 0x2cca, 0xb3b4, 0x3125, 0xae5b, 0x0537
    .2byte   0xe13f, 0x3f98, 0x94f4, 0x63ae, 0x1665, 0x891b, 0x0b8a, 0xbd09
    .2byte   0x2277, 0xa0e6, 0x7e41, 0xd52d, 0x4a53, 0xc8c2, 0x57bc, 0xfcd0
    .2byte   0xc926, 0x1781, 0xbced, 0x4bb7, 0x3e7c, 0xa102, 0x2393, 0x9510
    .2byte   0x0a6e, 0x88ff, 0x5658, 0xfd34, 0x624a, 0xe0db, 0x7fa5, 0xd4c9
    .2byte   0x245c, 0xfafb, 0x5197, 0xa6cd, 0xd306, 0x4c78, 0xcee9, 0x786a
    .2byte   0xe714, 0x6585, 0xbb22, 0x104e, 0x8f30, 0x0da1, 0x92df, 0x39b3
    .2byte   0x9e9a, 0x403d, 0xeb51, 0x1c0b, 0x69c0, 0xf6be, 0x742f, 0xc2ac
    .2byte   0x5dd2, 0xdf43, 0x01e4, 0xaa88, 0x35f6, 0xb767, 0x2819, 0x8375
    .2byte   0x677d, 0xb9da, 0x12b6, 0xe5ec, 0x9027, 0x0f59, 0x8dc8, 0x3b4b
    .2byte   0xa435, 0x26a4, 0xf803, 0x536f, 0xcc11, 0x4e80, 0xd1fe, 0x7a92
    .2byte   0x4f64, 0x91c3, 0x3aaf, 0xcdf5, 0xb83e, 0x2740, 0xa5d1, 0x1352
    .2byte   0x8c2c, 0x0ebd, 0xd01a, 0x7b76, 0xe408, 0x6699, 0xf9e7, 0x528b
    .2byte   0xb683, 0x6824, 0xc348, 0x3412, 0x41d9, 0xdea7, 0x5c36, 0xeab5
    .2byte   0x75cb, 0xf75a, 0x29fd, 0x8291, 0x1def, 0x9f7e, 0x0000, 0xab6c
    .2byte   0x0c45, 0xd2e2, 0x798e, 0x8ed4, 0xfb1f, 0x6461, 0xe6f0, 0x5073
    .2byte   0xcf0d, 0x4d9c, 0x933b, 0x3857, 0xa729, 0x25b8, 0xbac6, 0x11aa
     
TdL:
    .2byte   0xbbdd, 0x1c03, 0x70a8, 0x2a5f, 0xe12a, 0x9fb5, 0x0e37, 0x8d81
    .2byte   0xf31e, 0x629c, 0xc542, 0xa9e9, 0xd776, 0x46f4, 0x386b, 0x54c0
    .2byte   0xc130, 0x66ee, 0x0a45, 0x50b2, 0x9bc7, 0xe558, 0x74da, 0xf76c
    .2byte   0x89f3, 0x1871, 0xbfaf, 0xd304, 0xad9b, 0x3c19, 0x4286, 0x2e2d
    .2byte   0x078a, 0xa054, 0xccff, 0x9608, 0x5d7d, 0x23e2, 0xb260, 0x31d6
    .2byte   0x4f49, 0xdecb, 0x7915, 0x15be, 0x6b21, 0xfaa3, 0x843c, 0xe897
    .2byte   0xa2f5, 0x052b, 0x6980, 0x3377, 0xf802, 0x869d, 0x171f, 0x94a9
    .2byte   0xea36, 0x7bb4, 0xdc6a, 0xb0c1, 0xce5e, 0x5fdc, 0x2143, 0x4de8
    .2byte   0x1ea2, 0xb97c, 0xd5d7, 0x8f20, 0x4455, 0x3aca, 0xab48, 0x28fe
    .2byte   0x5661, 0xc7e3, 0x603d, 0x0c96, 0x7209, 0xe38b, 0x9d14, 0xf1bf
    .2byte   0xf95b, 0x5e85, 0x322e, 0x68d9, 0xa3ac, 0xdd33, 0x4cb1, 0xcf07
    .2byte   0xb198, 0x201a, 0x87c4, 0xeb6f, 0x95f0, 0x0472, 0x7aed, 0x1646
    .2byte   0xe073, 0x47ad, 0x2b06, 0x71f1, 0xba84, 0xc41b, 0x5599, 0xd62f
    .2byte   0xa8b0, 0x3932, 0x9eec, 0xf247, 0x8cd8, 0x1d5a, 0x63c5, 0x0f6e
    .2byte   0xd818, 0x7fc6, 0x136d, 0x499a, 0x82ef, 0xfc70, 0x6df2, 0xee44
    .2byte   0x90db, 0x0159, 0xa687, 0xca2c, 0xb4b3, 0x2531, 0x5bae, 0x3705
    .2byte   0x3fe1, 0x983f, 0xf494, 0xae63, 0x6516, 0x1b89, 0x8a0b, 0x09bd
    .2byte   0x7722, 0xe6a0, 0x417e, 0x2dd5, 0x534a, 0xc2c8, 0xbc57, 0xd0fc
    .2byte   0x26c9, 0x8117, 0xedbc, 0xb74b, 0x7c3e, 0x02a1, 0x9323, 0x1095
    .2byte   0x6e0a, 0xff88, 0x5856, 0x34fd, 0x4a62, 0xdbe0, 0xa57f, 0xc9d4
    .2byte   0x5c24, 0xfbfa, 0x9751, 0xcda6, 0x06d3, 0x784c, 0xe9ce, 0x6a78
    .2byte   0x14e7, 0x8565, 0x22bb, 0x4e10, 0x308f, 0xa10d, 0xdf92, 0xb339
    .2byte   0x9a9e, 0x3d40, 0x51eb, 0x0b1c, 0xc069, 0xbef6, 0x2f74, 0xacc2
    .2byte   0xd25d, 0x43df, 0xe401, 0x88aa, 0xf635, 0x67b7, 0x1928, 0x7583
    .2byte   0x7d67, 0xdab9, 0xb612, 0xece5, 0x2790, 0x590f, 0xc88d, 0x4b3b
    .2byte   0x35a4, 0xa426, 0x03f8, 0x6f53, 0x11cc, 0x804e, 0xfed1, 0x927a
    .2byte   0x644f, 0xc391, 0xaf3a, 0xf5cd, 0x3eb8, 0x4027, 0xd1a5, 0x5213
    .2byte   0x2c8c, 0xbd0e, 0x1ad0, 0x767b, 0x08e4, 0x9966, 0xe7f9, 0x8b52
    .2byte   0x83b6, 0x2468, 0x48c3, 0x1234, 0xd941, 0xa7de, 0x365c, 0xb5ea
    .2byte   0xcb75, 0x5af7, 0xfd29, 0x9182, 0xef1d, 0x7e9f, 0x0000, 0x6cab
    .2byte   0x450c, 0xe2d2, 0x8e79, 0xd48e, 0x1ffb, 0x6164, 0xf0e6, 0x7350
    .2byte   0x0dcf, 0x9c4d, 0x3b93, 0x5738, 0x29a7, 0xb825, 0xc6ba, 0xaa11

TmcH:
    .2byte   0x0000, 0x41d9, 0x8291, 0xc348, 0x3412, 0x75cb, 0xb683, 0xf75a
    .2byte   0x6824, 0x29fd, 0xeab5, 0xab6c, 0x5c36, 0x1def, 0xdea7, 0x9f7e
    .2byte   0x149d, 0x5544, 0x960c, 0xd7d5, 0x208f, 0x6156, 0xa21e, 0xe3c7
    .2byte   0x7cb9, 0x3d60, 0xfe28, 0xbff1, 0x48ab, 0x0972, 0xca3a, 0x8be3
    .2byte   0x2819, 0x69c0, 0xaa88, 0xeb51, 0x1c0b, 0x5dd2, 0x9e9a, 0xdf43
    .2byte   0x403d, 0x01e4, 0xc2ac, 0x8375, 0x742f, 0x35f6, 0xf6be, 0xb767
    .2byte   0x3c84, 0x7d5d, 0xbe15, 0xffcc, 0x0896, 0x494f, 0x8a07, 0xcbde
    .2byte   0x54a0, 0x1579, 0xd631, 0x97e8, 0x60b2, 0x216b, 0xe223, 0xa3fa
    .2byte   0x4321, 0x02f8, 0xc1b0, 0x8069, 0x7733, 0x36ea, 0xf5a2, 0xb47b
    .2byte   0x2b05, 0x6adc, 0xa994, 0xe84d, 0x1f17, 0x5ece, 0x9d86, 0xdc5f
    .2byte   0x57bc, 0x1665, 0xd52d, 0x94f4, 0x63ae, 0x2277, 0xe13f, 0xa0e6
    .2byte   0x3f98, 0x7e41, 0xbd09, 0xfcd0, 0x0b8a, 0x4a53, 0x891b, 0xc8c2
    .2byte   0x6b38, 0x2ae1, 0xe9a9, 0xa870, 0x5f2a, 0x1ef3, 0xddbb, 0x9c62
    .2byte   0x031c, 0x42c5, 0x818d, 0xc054, 0x370e, 0x76d7, 0xb59f, 0xf446
    .2byte   0x7fa5, 0x3e7c, 0xfd34, 0xbced, 0x4bb7, 0x0a6e, 0xc926, 0x88ff
    .2byte   0x1781, 0x5658, 0x9510, 0xd4c9, 0x2393, 0x624a, 0xa102, 0xe0db
    .2byte   0x8642, 0xc79b, 0x04d3, 0x450a, 0xb250, 0xf389, 0x30c1, 0x7118
    .2byte   0xee66, 0xafbf, 0x6cf7, 0x2d2e, 0xda74, 0x9bad, 0x58e5, 0x193c
    .2byte   0x92df, 0xd306, 0x104e, 0x5197, 0xa6cd, 0xe714, 0x245c, 0x6585
    .2byte   0xfafb, 0xbb22, 0x786a, 0x39b3, 0xcee9, 0x8f30, 0x4c78, 0x0da1
    .2byte   0xae5b, 0xef82, 0x2cca, 0x6d13, 0x9a49, 0xdb90, 0x18d8, 0x5901
    .2byte   0xc67f, 0x87a6, 0x44ee, 0x0537, 0xf26d, 0xb3b4, 0x70fc, 0x3125
    .2byte   0xbac6, 0xfb1f, 0x3857, 0x798e, 0x8ed4, 0xcf0d, 0x0c45, 0x4d9c
    .2byte   0xd2e2, 0x933b, 0x5073, 0x11aa, 0xe6f0, 0xa729, 0x6461, 0x25b8
    .2byte   0xc563, 0x84ba, 0x47f2, 0x062b, 0xf171, 0xb0a8, 0x73e0, 0x3239
    .2byte   0xad47, 0xec9e, 0x2fd6, 0x6e0f, 0x9955, 0xd88c, 0x1bc4, 0x5a1d
    .2byte   0xd1fe, 0x9027, 0x536f, 0x12b6, 0xe5ec, 0xa435, 0x677d, 0x26a4
    .2byte   0xb9da, 0xf803, 0x3b4b, 0x7a92, 0x8dc8, 0xcc11, 0x0f59, 0x4e80
    .2byte   0xed7a, 0xaca3, 0x6feb, 0x2e32, 0xd968, 0x98b1, 0x5bf9, 0x1a20
    .2byte   0x855e, 0xc487, 0x07cf, 0x4616, 0xb14c, 0xf095, 0x33dd, 0x7204
    .2byte   0xf9e7, 0xb83e, 0x7b76, 0x3aaf, 0xcdf5, 0x8c2c, 0x4f64, 0x0ebd
    .2byte   0x91c3, 0xd01a, 0x1352, 0x528b, 0xa5d1, 0xe408, 0x2740, 0x6699

TmcL:
    .2byte   0x0000, 0xd941, 0x9182, 0x48c3, 0x1234, 0xcb75, 0x83b6, 0x5af7
    .2byte   0x2468, 0xfd29, 0xb5ea, 0x6cab, 0x365c, 0xef1d, 0xa7de, 0x7e9f
    .2byte   0x9d14, 0x4455, 0x0c96, 0xd5d7, 0x8f20, 0x5661, 0x1ea2, 0xc7e3
    .2byte   0xb97c, 0x603d, 0x28fe, 0xf1bf, 0xab48, 0x7209, 0x3aca, 0xe38b
    .2byte   0x1928, 0xc069, 0x88aa, 0x51eb, 0x0b1c, 0xd25d, 0x9a9e, 0x43df
    .2byte   0x3d40, 0xe401, 0xacc2, 0x7583, 0x2f74, 0xf635, 0xbef6, 0x67b7
    .2byte   0x843c, 0x5d7d, 0x15be, 0xccff, 0x9608, 0x4f49, 0x078a, 0xdecb
    .2byte   0xa054, 0x7915, 0x31d6, 0xe897, 0xb260, 0x6b21, 0x23e2, 0xfaa3
    .2byte   0x2143, 0xf802, 0xb0c1, 0x6980, 0x3377, 0xea36, 0xa2f5, 0x7bb4
    .2byte   0x052b, 0xdc6a, 0x94a9, 0x4de8, 0x171f, 0xce5e, 0x869d, 0x5fdc
    .2byte   0xbc57, 0x6516, 0x2dd5, 0xf494, 0xae63, 0x7722, 0x3fe1, 0xe6a0
    .2byte   0x983f, 0x417e, 0x09bd, 0xd0fc, 0x8a0b, 0x534a, 0x1b89, 0xc2c8
    .2byte   0x386b, 0xe12a, 0xa9e9, 0x70a8, 0x2a5f, 0xf31e, 0xbbdd, 0x629c
    .2byte   0x1c03, 0xc542, 0x8d81, 0x54c0, 0x0e37, 0xd776, 0x9fb5, 0x46f4
    .2byte   0xa57f, 0x7c3e, 0x34fd, 0xedbc, 0xb74b, 0x6e0a, 0x26c9, 0xff88
    .2byte   0x8117, 0x5856, 0x1095, 0xc9d4, 0x9323, 0x4a62, 0x02a1, 0xdbe0
    .2byte   0x4286, 0x9bc7, 0xd304, 0x0a45, 0x50b2, 0x89f3, 0xc130, 0x1871
    .2byte   0x66ee, 0xbfaf, 0xf76c, 0x2e2d, 0x74da, 0xad9b, 0xe558, 0x3c19
    .2byte   0xdf92, 0x06d3, 0x4e10, 0x9751, 0xcda6, 0x14e7, 0x5c24, 0x8565
    .2byte   0xfbfa, 0x22bb, 0x6a78, 0xb339, 0xe9ce, 0x308f, 0x784c, 0xa10d
    .2byte   0x5bae, 0x82ef, 0xca2c, 0x136d, 0x499a, 0x90db, 0xd818, 0x0159
    .2byte   0x7fc6, 0xa687, 0xee44, 0x3705, 0x6df2, 0xb4b3, 0xfc70, 0x2531
    .2byte   0xc6ba, 0x1ffb, 0x5738, 0x8e79, 0xd48e, 0x0dcf, 0x450c, 0x9c4d
    .2byte   0xe2d2, 0x3b93, 0x7350, 0xaa11, 0xf0e6, 0x29a7, 0x6164, 0xb825
    .2byte   0x63c5, 0xba84, 0xf247, 0x2b06, 0x71f1, 0xa8b0, 0xe073, 0x3932
    .2byte   0x47ad, 0x9eec, 0xd62f, 0x0f6e, 0x5599, 0x8cd8, 0xc41b, 0x1d5a
    .2byte   0xfed1, 0x2790, 0x6f53, 0xb612, 0xece5, 0x35a4, 0x7d67, 0xa426
    .2byte   0xdab9, 0x03f8, 0x4b3b, 0x927a, 0xc88d, 0x11cc, 0x590f, 0x804e
    .2byte   0x7aed, 0xa3ac, 0xeb6f, 0x322e, 0x68d9, 0xb198, 0xf95b, 0x201a
    .2byte   0x5e85, 0x87c4, 0xcf07, 0x1646, 0x4cb1, 0x95f0, 0xdd33, 0x0472
    .2byte   0xe7f9, 0x3eb8, 0x767b, 0xaf3a, 0xf5cd, 0x2c8c, 0x644f, 0xbd0e
    .2byte   0xc391, 0x1ad0, 0x5213, 0x8b52, 0xd1a5, 0x08e4, 0x4027, 0x9966

        .align  1
mul2:
    .byte   0x0,0x2,0x4,0x6,0x8,0xa,0xc,0xe,0x3,0x1,0x7,0x5,0xb,0x9,0xf,0xd

mul4:
    .byte   0x0,0x4,0x8,0xc,0x3,0x7,0xb,0xf,0x6,0x2,0xe,0xa,0x5,0x1,0xd,0x9

perm:
    .byte   1,6,11,12,5,10,15,0,9,14,3,4,13,2,7,8

rcon:
# Originally each of those elements was 64-bit integer whose lower half part is
# all zeros, so we simply store the higher half.
    .4byte  0x01230101
    .4byte  0x01230303
    .4byte  0x01230707
    .4byte  0x01231717
    .4byte  0x01233737
    .4byte  0x01237676
    .4byte  0x01237575
    .4byte  0x01237373
    .4byte  0x01236767
    .4byte  0x01235757
    .4byte  0x01233636
    .4byte  0x01237474
    .4byte  0x01237171
    .4byte  0x01236363
    .4byte  0x01234747
    .4byte  0x01231616
    .4byte  0x01233535
    .4byte  0x01237272
    .4byte  0x01236565
    .4byte  0x01235353
    .4byte  0x01232626
    .4byte  0x01235454
    .4byte  0x01233030
    .4byte  0x01236060
    .4byte  0x01234141
    .4byte  0x01230202
    .4byte  0x01230505
    .4byte  0x01231313
    .4byte  0x01232727
    .4byte  0x01235656
    .4byte  0x01233434
    .4byte  0x01237070
    .4byte  0x01236161

# =============================================================================
# Code section
# =============================================================================
        .align 2
        .text
# =============================================================================
# Procedure: multi
# Arguments:
#       1. x, stored in R0
#       2. alpha, stored in R1
# Global variables:
#       1. mul2
#       2. mul4
# Return value: R0
# Used registers: R0, R1, R2
# =============================================================================
multi:
    CMP         r1,     #2              @ alpha == 2
    BEQ         ALPHA_2
    CMP         r1,     #4              @ alpha == 4
    BEQ         ALPHA_4
MULTI_RETURN:
    BX          lr                      @ return
ALPHA_2:
    LDR         r2,     =mul2           @ load mul2[x]
    B           MULTI_LOAD
ALPHA_4:
    LDR         r2,     =mul4           @ load mul4[x]
MULTI_LOAD:
    LDRB        r0,     [r2, r0]
    B           MULTI_RETURN
        .ltorg                          @ insert a literal pool
# =============================================================================
# Procedure: G
# Arguments:
#       tweakey, a 64-bit integer:
#       1. lower 32 bits of tweakey, stored in R0
#       2. higher 32 bits of tweakey, stored in R1
#       3. alpha, stored in R2
# Global variables: none
# Return value:
#       a 64-bit integer:
#       1. lower 32 bits: stored in R0
#       2. higher 32 bits: stored in R1
# Used registers: R0, R1, R2, R3, R4-R7
# =============================================================================
G:
    PUSH        {r4-r7, lr}             @ save R4-R7, lr
    MOV         r5,     r0              @ now R5 holds the lower half of tweakey
    MOV         r6,     r1              @ and R6 the higher half
    MOV         r7,     r2              @ R7 holds alpha
    MOV         r4,     #0              @ set counter i = 0
# for(i=0; i<16; i++) {
G_CALC_TWEAKEY:
    MOV         r2,     r4
# shift=4*i
    LSL         r2,     r2,     #2      @ shift = 4*i
# tmp=(tweakey>>shift)&0xf;
    MOV         r0,     r5              @ load the lower half of tweakey
    MOV         r1,     r6              @ load the higher half of tweakey
    BL          LSR_64                  @ result = R1:R0
    MOV         r1,     #0xf
    AND         r0,     r0,     r1      @ tmp = R0 & 0xf
# tmp=multi(tmp, alpha);
    MOV         r1,     r7              @ load alpha
    BL          multi                   @ R0 holds tmp
# tmp2=(uint64_t)tmp)<<shift
    MOV         r1,     #0
    MOV         r2,     r4
    LSL         r2,     r2,     #2      @ shift = 4*i
    BL          LSL_64                  @ result = R1:R0
    PUSH        {r0-r1}                 @ save tmp2
# tweakey&=0xffffffffffffffffULL^(0xfULL<<shift);
    MOV         r0,     #0xf
    MOV         r1,     #0
    MOV         r2,     r4
    LSL         r2,     r2,     #2      @ shift = 4*i
    BL          LSL_64                  @ result = R1:R0
    MVN         r0,     r0
    MVN         r1,     r1              @ XOR with all 1's is logic NOT
    MOV         r2,     r5
    MOV         r3,     r6              @ tweakey = R3:R2
    BL          AND_64                  @ result = R1:R0
    POP         {r2-r3}                 @ retrieve tmp2 = R3:R2
# tweakey ^= tmp2
    BL          XOR_64                  @ result = R1:R0
# update tweakey
    MOV         r5,     r0
    MOV         r6,     r1
# increment i:
    ADD         r4,     r4,     #1
    CMP         r4,     #16
    BNE         G_CALC_TWEAKEY
# }
# return tweakey
    POP         {r4-r7}                 @ restore R4-R7
    POP         {r2}                    @ lr        
    BX          r2                      @ return
# =============================================================================
# Procedure: H
# Arguments:
#       tweakey, a 64-bit integer:
#       1. lower 32 bits of tweakey, stored in R0
#       2. higher 32 bits of tweakey, stored in R1
# Global variables: none
# Return value:
#       a 64-bit integer:
#       1. lower 32 bits: stored in R0
#       2. higher 32 bits: stored in R1
# Used registers: R0, R1, R2, R3, R4-R6
# =============================================================================
H:
    PUSH        {r4-r6, lr}             @ save R4-R6, lr
    MOV         r5,     r0
    MOV         r6,     r1              @ tweakey = R6:R5
# uint64_t res=0;
    MOV         r2,     #0
    MOV         r3,     #0              @ res = R3:R2 = 0
    PUSH        {r2-r3}                 @ save res
# set counter
    MOV         r4,     #0              @ set i = 0
# for (i=0; i<16; i++) {
H_CALC_RES:
# load tweakey:
    MOV         r0,     r5
    MOV         r1,     r6              @ tweakey = R1:R0
# shiftIn=60ULL-4ULL*i;
    MOV         r2,     r4
    LSL         r2,     r2,     #2      @ 4*i
    SUB         r2,     r2,     #60     @ 4*i - 60
    NEG         r2,     r2              @ 60 - 4*i = shiftIn
# tweakey >> shiftIn
    BL          LSR_64                  @ result = R1:R0
# result & 0xf
    MOV         r1,     #0              @ higher half is 0
    MOV         r2,     #0xf
    AND         r0,     r0,     r2      @ lower half & 0xf
# shiftOut=60ULL-4ULL*perm[i];
    LDR         r2,     =perm
    LDRB        r2,     [r2, r4]        @ load perm[i]
    LSL         r2,     r2,     #2      @ 4*perm[i]
    SUB         r2,     r2,     #60     @ 4*perm[i] - 60
    NEG         r2,     r2              @ 60-4*perm[i] = shiftOut
# tmp = ((tweakey >> shiftIn)&0xf) << shiftOut
    BL          LSL_64                  @ tmp = R1:R0
# load res
    POP         {r2-r3}                 @ res = R3:R2
# res^=tmp;
    BL          XOR_64                  @ res = R1:R0
    PUSH        {r0-r1}                 @ save res
# }
# increment i
    ADD         r4,     r4,     #1
    CMP         r4,     #16
    BNE         H_CALC_RES
# return res;
    POP         {r0-r1}                 @ return value = R1:R0
    POP         {r4-r6}                 @ restore R4-R6
    POP         {r2}                    @ lr        
    BX          r2                      @ return
# =============================================================================
# Procedure: GETU64
# Arguments: pt, addr to an array of bytes, with length 8, stored in R0
# Global variables: none
# Return value:
#       a 64-bit integer:
#       1. lower 32 bits: stored in R0
#       2. higher 32 bits: stored in R1
# Used registers: R0, R1, R2, R3, R4-R7
# =============================================================================
GETU64:
    PUSH        {r4-r7, lr}             @ save R4-R7, lr
    MOV         r7,     r0              @ r7 now holds addr to pt
# init result:
    MOV         r5,     #0
    MOV         r6,     #0              @ result = R6:R5
# set counter:
    MOV         r4,     #0              @ set counter i = 0
GETU64_LOOP:
    LDRB        r0,     [r7, r4]        @ load pt[i]
    MOV         r1,     #0              @ extend to 64 bit, pt[i] = R1:R0
# calc shift offset:
    MOV         r2,     r4
    LSL         r2,     r2,     #3      @ 8*i
    SUB         r2,     r2,     #56     @ 8*i - 56
    NEG         r2,     r2              @ 56 - 8*i, offset
# shift left:
    BL          LSL_64                  @ tmp = R1:R0
# xor:
    MOV         r2,     r5
    MOV         r3,     r6
    BL          XOR_64                  @ tmp^result = R1:R0
# update the temp result:
    MOV         r5,     r0
    MOV         r6,     r1
# increment i:
    ADD         r4,     r4,     #1
    CMP         r4,     #8
    BNE         GETU64_LOOP
# done, the result is still R1:R0, no need to load
    POP         {r4-r7}                 @ restore R4-R7
    POP         {r2}                    @ lr
    BX          r2                      @ return
# =============================================================================
# Procedure: PUTU64
# Arguments:
#       1. ct, addr to an array of bytes, with length 8, stored in R0
#       2. st, a 64 bit integer:
#           lower 32 bits: stored in R1
#           higher 32 bits: stored in R2
# Global variables: none
# Return value: none
# Used registers: R0, R1, R2, R3, R4-R7
# =============================================================================
PUTU64:
    PUSH        {r4-r7, lr}             @ save R4-R7, lr
    MOV         r6,     r1
    MOV         r7,     r2              @ copy st into R7:R6
    MOV         r5,     r0              @ r5 holds addr to ct
    MOV         r4,     #0              @ set counter i = 0
PUTU64_LOOP:
    MOV         r0,     r6
    MOV         r1,     r7              @ load st into R1:R0
    MOV         r2,     r4
    LSL         r2,     r2,     #3      @ 8*i
    SUB         r2,     r2,     #56     @ 8*i - 56
    NEG         r2,     r2              @ 56 - 8*i = shift offset
# st >> offset:
    BL          LSR_64                  @ result = R1:R0
# only take the lowest 8 bit:
    MOV         r2,     #0xff
    AND         r0,     r0,     r2      @ (uint8_t) result
# store to ct[i]:
    STRB        r0,     [r5, r4]        @ store to ct[i]
# increment i:
    ADD         r4,     r4,     #1
    CMP         r4,     #8              @ i == 8
    BNE         PUTU64_LOOP
# done
    POP         {r4-r7}                 @ restore R4-R7
    POP         {r2}                    @ lr
    BX          r2                      @ return
# =============================================================================
# Procedure: joltikKeySetupEnc128
# Arguments:
#       1. rtweakey: a 32-bit ptr to an array of round tweakeys, stored in R0,
#       whose elements are 64-bit integers, stored according to the convention.
#       2. Tweakey: a 32-bit ptr to an array of bytes, stored in R1
#       3. no_tweakeys: number of tweakeys, stored in R2 
# Global variables: rcon
# Return value: a 32-bit integer, stored in R0
# Used registers: R0, R1, R2, R3, R4-R7
# =============================================================================
joltikKeySetupEnc128:
    PUSH        {r0-r7, lr}             @ save R0-R7, lr
# stack layout:
#   (low) r0, r1, r2, r3, r4, r5, r6, r7, lr (high)
    MOV         r7,     sp              @ r7 is now the stack pointer
    MOV         r4,     r2              @ r4 now holds no_tweakey
# create local vars:
# stack layout:
#   (low) Nr, alpha[4], tweakey[3], r0, r1, r2, r3, r4, r5, r6, r7, lr (high)
# ptr:    r6                        r7(sp)
    MOV         r2,     #24
    SUB         r6,     r7,     r2      @ reserve tweakey[3], save to r7
    SUB         r6,     r6,     #4      @ reserve alpha[4], we don't need
                                        @ the last one, though, for aligning
    SUB         r6,     r6,     #4      @ reserve Nr
                                        @ now r6 is the frame pointer
    MOV         sp,     r6              @ many routine calls, update sp
# init tweakey[3]:
# tweakey[0] = GETU64(Tweakey+0);
    MOV         r5,     r1              @ now r5 holds addr to Tweakey
    MOV         r0,     r5
    BL          GETU64                  @ result = R1:R0
    STR         r0,     [r6, #8]        @ store the lower half of tweakey[0]
    STR         r1,     [r6, #12]       @ store the higher half of tweakey[0]
# tweakey[1] = GETU64(Tweakey+8);
    MOV         r0,     r5              @ idem
    ADD         r0,     r0,     #8      @ r0 holds addr to Tweakey[8]
    BL          GETU64                  @ result = R1:R0
    STR         r0,     [r6, #16]       @ store the lower half of tweakey[1]
    STR         r1,     [r6, #20]       @ store the higher half of tweakey[1]
# same for both cases, do it first
    MOV         r0,     #1
    STRB        r0,     [r6, #4]        @ alpha[0] = 1
    MOV         r0,     #2
    STRB        r0,     [r6, #5]        @ alpha[1] = 2
    MOV         r0,     #4
    STRB        r0,     [r6, #6]        @ alpha[2] = 4, alpha[2] doesn't matter
                                        @ when 2 == no_tweakeys
# switch over no_tweakeys:
    CMP         r4,     #2              @ no_tweakeys == 2
    BNE         JKSE128_NO_TWEAKEYS_3
    MOV         r4,     #24             @ Nr = 24
    MOV         r0,     #0
    MOV         r1,     #0              @ tweak[2] = R1:R0 = 0
    B           JKSE128_NO_TWEAKEYS_DONE
JKSE128_NO_TWEAKEYS_3: # we don't handle exception, no_tweakeys is 2 or 3
# tweakey[2] = GETU64(Tweakey+16);
    MOV         r4,     #32             @ Nr = 32
    MOV         r0,     r5
    ADD         r0,     r0,     #16     @ r0 holds addr to Tweakey[16]
    BL          GETU64                  @ result is R1:R0
JKSE128_NO_TWEAKEYS_DONE:
# tweakey[2] = R1:R0, Nr = R4
    STR         r0,     [r6, #24]       @ store the lower half of tweakey[2]
    STR         r1,     [r6, #28]       @ store the higher half of tweakey[2]
    STR         r4,     [r6]            @ store Nr
# for each rounds:
    MOV         r4,     #0              @ set counter r = 0
    LDR         r5,     [r6, #40]       @ load no_tweakeys
# for(r=0, r <= Nr, r++) {
JKSE128_LOOP:
# rtweakey[r] = tweakey[0] ^ tweakey[1] ^ tweakey[2] ^ rcon[r];
    LDR         r0,     [r6, #8]        @ load the lower half of tweakey[0]
    LDR         r1,     [r6, #12]       @ load the higher half of tweakey[0]
    LDR         r2,     [r6, #16]       @ load the lower half of tweakey[1]
    LDR         r3,     [r6, #20]       @ load the higher half of tweakey[1]
    BL          XOR_64                  @ result = R1:R0
    LDR         r2,     [r6, #24]       @ load the lower half of tweakey[2]
    LDR         r3,     [r6, #28]       @ load the higher half of tweakey[2]
    BL          XOR_64                  @ result = R1:R0
    LDR         r2,     =rcon
    MOV         r3,     r4
    LSL         r3,     r3,     #2      @ each element of rcon is 4 byte
    ADD         r2,     r2,     r3      @ r2 = addr to rcon[r]
    LDR         r3,     [r2]            @ load the higher half of rcon[r]
    MOV         r2,     #0              @ the lower half of rcon[r] is zero
    BL          XOR_64                  @ result = R1:R0
    LDR         r2,     [r6, #32]       @ load addr to rtweakey into r2
    MOV         r3,     r4
    LSL         r3,     r3,     #3      @ each element of rtweakey is 8 byte
    ADD         r2,     r2,     r3      @ r2, addr to lower half of rtweakey[r]
    STR         r0,     [r2]            @ store the lower half of rtweakey[r]
    STR         r1,     [r2, #4]        @ and the higher half
# update tweakey:
# tweakey[0]:
    LDR         r0,     [r6, #8]        @ load the lower half of tweakey[0]
    LDR         r1,     [r6, #12]       @ load the higher half of tweakey[0]
    BL          H                       @ result = R1:R0
    LDRB        r2,     [r6]            @ load alpha[0]
    BL          G                       @ result = R1:R0
    STR         r0,     [r6, #8]        @ store the lower half of tweakey[0]
    STR         r1,     [r6, #12]       @ stroe the higher half of tweakey[0]
# tweakey[1]:
    LDR         r0,     [r6, #16]       @ load the lower half of tweakey[1]
    LDR         r1,     [r6, #20]       @ load the higher half of tweakey[1]
    BL          H                       @ result = R1:R0
    LDRB        r2,     [r6, #5]        @ load alpha[1]
    BL          G                       @ result = R1:R0
    STR         r0,     [r6, #16]       @ store the lower half of tweakey[1]
    STR         r1,     [r6, #20]       @ stroe the higher half of tweakey[1]
# done with the first two:
    CMP         r5,     #3              @ no_tweakeys == 3
    BNE         JKSE128_UPDATE_TWEAKEY_DONE
# tweakey[2]:
    LDR         r0,     [r6, #24]       @ load the lower half of tweakey[2]
    LDR         r1,     [r6, #28]       @ load the higher half of tweakey[2]
    BL          H                       @ result = R1:R0
    LDRB        r2,     [r6, #6]        @ load alpha[2]
    BL          G                       @ result = R1:R0
    STR         r0,     [r6, #24]       @ store the lower half of tweakey[2]
    STR         r1,     [r6, #28]       @ stroe the higher half of tweakey[2]
JKSE128_UPDATE_TWEAKEY_DONE:
# increment r
    ADD         r4,     r4,     #1
    LDR         r0,     [r6]            @ load Nr
    CMP         r4,     r0              @ r <= Nr
    BLE         JKSE128_LOOP
# }
# done, return Nr
    MOV         lr,     r0              @ lr holds Nr
    MOV         sp,     r7              @ restore sp
    POP         {r0-r7}                 @ restore R0-R7
    POP         {r2}                    @ lr
    MOV         r0,     lr              @ r0 holds Nr
    BX          r2                      @ return
# =============================================================================
# Procedure: joltikKeySetupDec128
# Arguments:
#       1. rtweakey: a 32-bit ptr to an array of round tweakeys, stored in R0,
#       whose elements are 64-bit integers, stored according to the convention.
#       2. Tweakey: a 32-bit ptr to an array of bytes, stored in R1
#       3. no_tweakeys: number of tweakeys, stored in R2 
# Global variables: TmcH, TmcL
# Return value: a 32-bit integer, stored in R0
# Used registers: R0, R1, R2, R3, R4-R7
# =============================================================================
joltikKeySetupDec128:
    PUSH        {r0-r7, lr}             @ save R0-R7, lr
# stack layout:
#   (low) r0, r1, r2, r3, r4, r5, r6, r7, lr (high)
# ptr:    r7(sp)
    MOV         r7,     sp              @ now r7 is the stack pointer
# Nr=joltikKeySetupEnc128 (rtweakey, Tweakey, no_tweakeys);
    BL          joltikKeySetupEnc128    @ drop the bomb, Nr = r0
    MOV         r4,     r0              @ now r4 holds Nr
# invert the order:
    LDR         r5,     [r7]            @ load addr to rtweakey into r5
    MOV         r6,     #0              @ set i = 0
# for (i = 0, j = Nr; i < j; ++i, --j) {
JKSD128_SWAP_LOOP:
    MOV         r2,     r6
    LSL         r2,     r2,     #3      @ each elements in rtweakey is 8 byte
    LDR         r0,     [r5, r2]        @ load lower half of rtweakey[i]
    ADD         r2,     r2,     #4
    LDR         r1,     [r5, r2]        @ load high half of rtweakey[i]
    MOV         r2,     r6
    SUB         r2,     r2,     r4      @ i - Nr
    NEG         r2,     r2              @ Nr - i
    LSL         r2,     r2,     #3      @ idem
    ADD         r2,     r2,     #4
    LDR         r3,     [r5, r2]        @ load high half of rtweakey[Nr-i]
    STR         r1,     [r5, r2]        @ store high half of rtweakey[i]
    SUB         r2,     r2,     #4
    LDR         r1,     [r5, r2]        @ load lower half of rtweakey[Nr-i]
    STR         r0,     [r5, r2]        @ store lower half of rtweakey[i]
# now rtweakey[Nr-i] = R3:R1
    MOV         r2,     r6
    LSL         r2,     r2,     #3      @ idem
    STR         r1,     [r5, r2]        @ store lower half of rtweakey[i]
    ADD         r2,     r2,     #4
    STR         r3,     [r5, r2]        @ store higher half of rtweakey[i]
# increment i
    ADD         r6,     r6,     #1
    LSR         r0,     r4,     #1      @ calc Nr/2
    CMP         r6,     r0              @ i == Nr/w
    BNE         JKSD128_SWAP_LOOP
# apply inverse MixColumn transform:
    MOV         r6,     #1              @ set i = 1
# for (i = 1; i <= Nr; i++) {
JKSD128_MIXCOL_LOOP:
    MOV         r2,     r6
    LSL         r2,     r2,     #3      @ each elements in rtweakey is 8 byte
    LDR         r0,     [r5, r2]        @ load lower half of rtweakey[i]
    ADD         r2,     r2,     #4
    LDR         r1,     [r5, r2]        @ load higher half of rtweakey[i]
# perform inverse mix column transformation:
    BL          inverse_mix_col         @ result = R1:R0
# write back:
    MOV         r3,     r6
    LSL         r3,     r3,     #3      @ idem
    STR         r0,     [r5, r3]        @ store lower half of result
    ADD         r3,     r3,     #4
    STR         r1,     [r5, r3]        @ store the high half of result
# increment i
    ADD         r6,     r6,     #1
    CMP         r6,     r4              @ i <= Nr
    BLE         JKSD128_MIXCOL_LOOP
# done, return Nr
    MOV         lr,     r4              @ lr holds Nr
    POP         {r0-r7}                 @ restore R0-R7
    POP         {r2}                    @ lr
    MOV         r0,     lr              @ r0 holds Nr
    BX          r2                      @ return
        .ltorg                          @ insert a literal pool
# =============================================================================
# Procedure: aesTweakEncrypt
# Arguments:
#       1. tweakey_size, 32-bit integer, stored in R0
#       2. pt, addr to a byte array of size 8, stored in R1
#       3. key, addr to a byte array of size tweakey_size/64, stored in R2
#       4. ct, addr to a byte array of size 8, stored in R3
# Global variables: TeH, TeL
# Return value: none
# Used registers: R0, R1, R2, R3, R4-R7
# =============================================================================
        .global aesTweakEncrypt
        .type aesTweakEncrypt STT_FUNC
aesTweakEncrypt:
    PUSH        {r0-r7, lr}             @ save R0-R7, lr
# stack layout:
#   (low) r0, r1, r2, r3, r4, r5, r6, r7, lr (high)
# ptr:    r7(sp)
    MOV         r7,     sp              @ now r7 is the stack pointer
# reserve local vars:
    SUB         r7,     r7,     #100
    SUB         r7,     r7,     #168    @ Nr, uint64_t rk[33], 4 + 8*33 = 268
    MOV         sp,     r7              @ update sp
# stack layout:
#   (low) Nr, rk[33], r0, r1, r2, r3, r4, r5, r6, r7, lr (high)
# ptr:    r7
    MOV         r1,     r2              @ r1 = key
    MOV         r2,     r0
    LSR         r2,     r2,     #6      @ r2 = tweakey_size/64
    MOV         r0,     r7
    ADD         r0,     r0,     #4      @ r0 = addr to rk
# Nr=joltikKeySetupEnc128 (rk, key, tweakey_size/64);
    BL          joltikKeySetupEnc128    @ drop the bomb, Nr = r0
    STR         r0,     [r7]            @ store Nr
# s = GETU64(pt) ^ rk[0];
    MOV         r1,     #100
    ADD         r1,     r1,     #172    @ 4 + 33*8 + 4 = 272
    LDR         r0,     [r7, r1]        @ load addr to pt
    BL          GETU64                  @ result = R1:R0
    LDR         r2,     [r7, #4]        @ load lower half of rk[0]
    LDR         r3,     [r7, #8]        @ load higher half of rk[0]
    BL          XOR_64                  @ s = R1:R0
    MOV         r6,     r1
    MOV         r5,     r0              @ copy s into R6:R5
# for(i=1; i<=Nr; ++i) {
    MOV         r4,     #1              @ set counter i = 1
TE_LOOP:
# s0 = (((s>>56ULL)&0xf0))^((s>>40ULL)&0xf);
    MOV         r0,     r5
    MOV         r1,     r6              @ copy s into R1:R0
    MOV         r2,     #56             @ off1
    MOV         r3,     #40             @ off2
    BL          calc_s                  @ s0 = R0
# TeH[s0]:
    LDR         r1,     =TeH            @ load addr to TeH
    LSL         r0,     r0,     #1      @ each element of TeH is 2 bytes
    LDRH        r0,     [r1, r0]        @ load TeH[s0]
    PUSH        {r0}                    @ save TeH[s0]
# s1 = (((s>>16ULL)&0xf0))^((s>> 0ULL)&0xf);
    MOV         r0,     r5
    MOV         r1,     r6              @ copy s into R1:R0
    MOV         r2,     #16             @ off1
    MOV         r3,     #0              @ off2
    BL          calc_s                  @ s1 = R0
# TeL[s1]:
    LDR         r1,     =TeL
    LSL         r0,     r0,     #1
    LDRH        r0,     [r1, r0]        @ load TeL[s1]
    POP         {r1}                    @ load TeH[s0]
# (uint64_t)(TeH[s0] ^ TeL[s1]) << 48ULL
    EOR         r0,     r1,     r0
    MOV         r1,     #0              @ extend to 64-bit, R1:R0
    MOV         r2,     #48             @ shift offset
    BL          LSL_64                  @ result = R1:R0
    PUSH        {r0-r1}                 @ save tmp
# s2 = (((s>>40ULL)&0xf0))^((s>>24ULL)&0xf);
    MOV         r0,     r5
    MOV         r1,     r6              @ copy s into R1:R0
    MOV         r2,     #40             @ off1
    MOV         r3,     #24             @ off2
    BL          calc_s                  @ s2 = R0
# TeH[s2]:
    LDR         r1,     =TeH
    LSL         r0,     r0,     #1
    LDRH        r0,     [r1, r0]        @ load TeH[s2]
    PUSH        {r0}                    @ save it
# s3 = (((s>> 0ULL)&0xf0))^((s>>48ULL)&0xf);
    MOV         r0,     r5
    MOV         r1,     r6              @ copy s into R1:R0
    MOV         r2,     #0              @ off1
    MOV         r3,     #48             @ off2
    BL          calc_s                  @ s3 = R0
# TeL[s3]:
    LDR         r1,     =TeL
    LSL         r0,     r0,     #1
    LDRH        r0,     [r1, r0]        @ load TeL[s3]
    POP         {r1}                    @ load TeH[s2]
# (uint64_t)(TeH[s2]^TeL[s3]) << 32ULL
    EOR         r0,     r1,     r0
    MOV         r1,     #0              @ extend to R1:R0
    MOV         r2,     #32
    BL          LSL_64                  @ result = R1:R0
# tmp ^= result:
    POP         {r2-r3}                 @ load tmp into R3:R2
    BL          XOR_64                  @ result = R1:R0
    PUSH        {r0-r1}                 @ save tmp
# s4 = (((s>>24ULL)&0xf0))^((s>> 8ULL)&0xf); 
    MOV         r0,     r5
    MOV         r1,     r6              @ copy s into R1:R0
    MOV         r2,     #24             @ off1
    MOV         r3,     #8              @ off2
    BL          calc_s                  @ s4 = R0
# TeH[s4]:
    LDR         r1,     =TeH
    LSL         r0,     r0,     #1
    LDRH        r0,     [r1, r0]        @ load TeH[s4]
    PUSH        {r0}                    @ save it
# s5 = (((s>>48ULL)&0xf0))^((s>>32ULL)&0xf);
    MOV         r0,     r5
    MOV         r1,     r6              @ copy s into R1:R0
    MOV         r2,     #48             @ off1
    MOV         r3,     #32             @ off2
    BL          calc_s                  @ s5 = R0
# TeL[s5]:
    LDR         r1,     =TeL
    LSL         r0,     r0,     #1
    LDRH        r0,     [r1, r0]        @ load TeL[s5]
    POP         {r1}                    @ load TeH[s4]
# (uint64_t)(TeH[s4]^TeL[s5]) << 16ULL
    EOR         r0,     r1,     r0
    MOV         r1,     #0              @ extend to R1:R0
    MOV         r2,     #16
    BL          LSL_64                  @ result = R1:R0
# tmp ^= result:
    POP         {r2-r3}                 @ load tmp into R3:R2
    BL          XOR_64                  @ result = R1:R0
    PUSH        {r0-r1}                 @ save tmp
# s6 = (((s>> 8ULL)&0xf0))^((s>>56ULL)&0xf);
    MOV         r0,     r5
    MOV         r1,     r6              @ copy s into R1:R0
    MOV         r2,     #8              @ off1
    MOV         r3,     #56             @ off2
    BL          calc_s                  @ s6 = R0
# TeH[s6]:
    LDR         r1,     =TeH
    LSL         r0,     r0,     #1
    LDRH        r0,     [r1, r0]        @ load TeH[s6]
    PUSH        {r0}                    @ save it
# s7 = (((s>>32ULL)&0xf0))^((s>>16ULL)&0xf);
    MOV         r0,     r5
    MOV         r1,     r6              @ copy s into R1:R0
    MOV         r2,     #32             @ off1
    MOV         r3,     #16             @ off2
    BL          calc_s                  @ s7 = R0
# TeL[s7]:
    LDR         r1,     =TeL
    LSL         r0,     r0,     #1
    LDRH        r0,     [r1, r0]        @ load TeL[s7]
    POP         {r1}                    @ load TeH[s6]
# (uint64_t)(TeH[s6]^TeL[s7]) << 0ULL
    EOR         r0,     r1,     r0
    MOV         r1,     #0              @ extend to R1:R0
# tmp ^= result:
    POP         {r2-r3}                 @ load tmp into R3:R2
    BL          XOR_64                  @ result = R1:R0
                                        @ at this point r7 = sp
# stack layout:
#   (low) Nr, rk[33], r0, r1, r2, r3, r4, r5, r6, r7, lr (high)
# ptr:    r7
# tmp ^= rk[i]:
    MOV         r3,     r4
    LSL         r3,     r3,     #3      @ each element of rk is 8 bytes
    ADD         r3,     r3,     #4      @ skip Nr
    LDR         r2,     [r7, r3]        @ load lower half of rk[i]
    ADD         r3,     r3,     #4
    LDR         r3,     [r7, r3]        @ load higher half of rk[i]
    BL          XOR_64                  @ result = R1:R0
# update s:
    MOV         r5,     r0
    MOV         r6,     r1
# increment i
    ADD         r4,     r4,     #1
    LDR         r0,     [r7]            @ load Nr
    CMP         r4,     r0              @ i <= Nr
    BLE         TE_LOOP
# PUTU64(ct, s);
    MOV         r1,     #100
    ADD         r1,     r1,     #180    @ 4 + 33*8 + 4 + 4 + 4 = 280
    LDR         r0,     [r7, r1]        @ load addr to ct into r0
    MOV         r1,     r5
    MOV         r2,     r6              @ copy s into R2:R1
    BL          PUTU64                  @ ct is updated
# done
    ADD         r7,     r7,     #100
    ADD         r7,     r7,     #168    @ 4 + 33*8 = 268
    MOV         sp,     r7              @ restore sp
    POP         {r0-r7}                 @ restore R0-R7
    POP         {r2}                    @ lr
    BX          r2                      @ return
# =============================================================================
# Procedure: calc_s
# Arguments:
#       1. s: a 64-bit integer:
#           lower half stored in R0
#           higher half stored in R1
#       2. off1: first offset, stored in R2
#       3. off2: second offset, stored in R3
# Global variables: none
# Return value: s, stored in R0
# Used registers: R0, R1, R2, R3, R4-R7
# =============================================================================
calc_s:
# si = ((s >> off1) & 0xf0) ^ ((s >> off2) & 0xf)
    PUSH        {r4-r7, lr}             @ save R4-R7, lr
    MOV         r5,     r0
    MOV         r6,     r1              @ copy s into R6:R5
    MOV         r7,     r3              @ save the off2
# first part
    BL          LSR_64                  @ result = R1:R0
    MOV         r2,     #0xf0
    AND         r0,     r0,     r2
    MOV         r4,     r0              @ save the first part
# second part
    MOV         r0,     r5
    MOV         r1,     r6              @ copy s into R1:R0
    MOV         r2,     r7              @ load off2
    BL          LSR_64                  @ result = R1:R0
    MOV         r2,     #0xf
    AND         r0,     r0,     r2      @ second part = r0
    EOR         r0,     r0,     r4      @ si = r0
# done
    POP         {r4-r7}                 @ restore R4-R7
    POP         {r2}                    @ lr
    BX          r2                      @ return
# =============================================================================
# Procedure: aesTweakDecrypt
# Arguments:
#       1. tweakey_size, 32-bit integer, stored in R0
#       2. ct, addr to a byte array of size 8, stored in R1
#       3. key, addr to a byte array of size tweakey_size/64, stored in R2
#       4. pt, addr to a byte array of size 8, stored in R3
# Global variables: TdH, TdL
# Return value: none
# Used registers: R0, R1, R2, R3, R4-R7
# =============================================================================
        .global aesTweakDecrypt
        .type aesTweakDecrypt STT_FUNC
aesTweakDecrypt:
    PUSH        {r0-r7, lr}             @ save R0-R7, lr
# stack layout:
#   (low) r0, r1, r2, r3, r4, r5, r6, r7, lr (high)
# ptr:    r7(sp)
    MOV         r7,     sp              @ now r7 is the stack pointer
# reserve local vars:
    SUB         r7,     r7,     #100
    SUB         r7,     r7,     #168    @ Nr, uint64_t rk[33], 4 + 8*33 = 268
    MOV         sp,     r7              @ update sp
# stack layout:
#   (low) Nr, rk[33], r0, r1, r2, r3, r4, r5, r6, r7, lr (high)
# ptr:    r7
    MOV         r1,     r2              @ r1 = key
    MOV         r2,     r0
    LSR         r2,     r2,     #6      @ r2 = tweakey_size/64
    MOV         r0,     r7
    ADD         r0,     r0,     #4      @ r0 = addr to rk
# Nr=joltikKeySetupDnc128 (rk, key, tweakey_size/64);
    BL          joltikKeySetupDec128    @ Nr = r0
    STR         r0,     [r7]            @ store Nr
# s = GETU64(ct) ^ rk[0];
    MOV         r1,     #100
    ADD         r1,     r1,     #172    @ 4 + 33*8 + 4 = 272
    LDR         r0,     [r7, r1]        @ load addr to ct
    BL          GETU64                  @ result = R1:R0
    LDR         r2,     [r7, #4]        @ load lower half of rk[0]
    LDR         r3,     [r7, #8]        @ load higher half of rk[0]
    BL          XOR_64                  @ s = R1:R0
# inverse mix column:
    BL          inverse_mix_col         @ s = R1:R0
    MOV         r5,     r0
    MOV         r6,     r1              @ copy s into R6:R5
# for(i=1; i<=Nr; ++i) {
    MOV         r4,     #1              @ set counter i = 1
TD_LOOP:
# s0 = (((s>>56ULL)&0xf0))^((s>>8ULL)&0xf);
    MOV         r0,     r5
    MOV         r1,     r6              @ copy s into R1:R0
    MOV         r2,     #56             @ off1
    MOV         r3,     #8              @ off2
    BL          calc_s                  @ s0 = R0
# TdH[s0]:
    LDR         r1,     =TdH            @ load addr to TdH
    LSL         r0,     r0,     #1      @ each element of TeH is 2 bytes
    LDRH        r0,     [r1, r0]        @ load TdH[s0]
    PUSH        {r0}                    @ save TdH[s0]
# s1 = (((s>>16ULL)&0xf0))^((s>> 32ULL)&0xf);
    MOV         r0,     r5
    MOV         r1,     r6              @ copy s into R1:R0
    MOV         r2,     #16             @ off1
    MOV         r3,     #32             @ off2
    BL          calc_s                  @ s1 = R0
# TdL[s1]:
    LDR         r1,     =TdL
    LSL         r0,     r0,     #1
    LDRH        r0,     [r1, r0]        @ load TdL[s1]
    POP         {r1}                    @ load TdH[s0]
# (uint64_t)(TdH[s0] ^ TdL[s1]) << 48ULL
    EOR         r0,     r1,     r0
    MOV         r1,     #0              @ extend to 64-bit, R1:R0
    MOV         r2,     #48             @ shift offset
    BL          LSL_64                  @ result = R1:R0
    PUSH        {r0-r1}                 @ save tmp
# s2 = (((s>>40ULL)&0xf0))^((s>>56ULL)&0xf);
    MOV         r0,     r5
    MOV         r1,     r6              @ copy s into R1:R0
    MOV         r2,     #40             @ off1
    MOV         r3,     #56             @ off2
    BL          calc_s                  @ s2 = R0
# TdH[s2]:
    LDR         r1,     =TdH
    LSL         r0,     r0,     #1
    LDRH        r0,     [r1, r0]        @ load TdH[s2]
    PUSH        {r0}                    @ save it
# s3 = (((s>> 0ULL)&0xf0))^((s>>16ULL)&0xf);
    MOV         r0,     r5
    MOV         r1,     r6              @ copy s into R1:R0
    MOV         r2,     #0              @ off1
    MOV         r3,     #16             @ off2
    BL          calc_s                  @ s3 = R0
# TdL[s3]:
    LDR         r1,     =TdL
    LSL         r0,     r0,     #1
    LDRH        r0,     [r1, r0]        @ load TdL[s3]
    POP         {r1}                    @ load TdH[s2]
# (uint64_t)(TdH[s2]^TdL[s3]) << 32ULL
    EOR         r0,     r1,     r0
    MOV         r1,     #0              @ extend to R1:R0
    MOV         r2,     #32
    BL          LSL_64                  @ result = R1:R0
# tmp ^= result:
    POP         {r2-r3}                 @ load tmp into R3:R2
    BL          XOR_64                  @ result = R1:R0
    PUSH        {r0-r1}                 @ save tmp
# s4 = (((s>>24ULL)&0xf0))^((s>>40ULL)&0xf); 
    MOV         r0,     r5
    MOV         r1,     r6              @ copy s into R1:R0
    MOV         r2,     #24             @ off1
    MOV         r3,     #40             @ off2
    BL          calc_s                  @ s4 = R0
# TdH[s4]:
    LDR         r1,     =TdH
    LSL         r0,     r0,     #1
    LDRH        r0,     [r1, r0]        @ load TdH[s4]
    PUSH        {r0}                    @ save it
# s5 = (((s>>48ULL)&0xf0))^((s>> 0ULL)&0xf);
    MOV         r0,     r5
    MOV         r1,     r6              @ copy s into R1:R0
    MOV         r2,     #48             @ off1
    MOV         r3,     #0              @ off2
    BL          calc_s                  @ s5 = R0
# TdL[s5]:
    LDR         r1,     =TdL
    LSL         r0,     r0,     #1
    LDRH        r0,     [r1, r0]        @ load TdL[s5]
    POP         {r1}                    @ load TdH[s4]
# (uint64_t)(TeH[s4]^TeL[s5]) << 16ULL
    EOR         r0,     r1,     r0
    MOV         r1,     #0              @ extend to R1:R0
    MOV         r2,     #16
    BL          LSL_64                  @ result = R1:R0
# tmp ^= result:
    POP         {r2-r3}                 @ load tmp into R3:R2
    BL          XOR_64                  @ result = R1:R0
    PUSH        {r0-r1}                 @ save tmp
# s6 = (((s>> 8ULL)&0xf0))^((s>>24ULL)&0xf);
    MOV         r0,     r5
    MOV         r1,     r6              @ copy s into R1:R0
    MOV         r2,     #8              @ off1
    MOV         r3,     #24             @ off2
    BL          calc_s                  @ s6 = R0
# TdH[s6]:
    LDR         r1,     =TdH
    LSL         r0,     r0,     #1
    LDRH        r0,     [r1, r0]        @ load TdH[s6]
    PUSH        {r0}                    @ save it
# s7 = (((s>>32ULL)&0xf0))^((s>>48ULL)&0xf);
    MOV         r0,     r5
    MOV         r1,     r6              @ copy s into R1:R0
    MOV         r2,     #32             @ off1
    MOV         r3,     #48             @ off2
    BL          calc_s                  @ s7 = R0
# TdL[s7]:
    LDR         r1,     =TdL
    LSL         r0,     r0,     #1
    LDRH        r0,     [r1, r0]        @ load TdL[s7]
    POP         {r1}                    @ load TdH[s6]
# (uint64_t)(TdH[s6]^TdL[s7]) << 0ULL
    EOR         r0,     r1,     r0
    MOV         r1,     #0              @ extend to R1:R0
# tmp ^= result:
    POP         {r2-r3}                 @ load tmp into R3:R2
    BL          XOR_64                  @ result = R1:R0
                                        @ at this point r7 = sp
# stack layout:
#   (low) Nr, rk[33], r0, r1, r2, r3, r4, r5, r6, r7, lr (high)
# ptr:    r7
# tmp ^= rk[i]:
    MOV         r3,     r4
    LSL         r3,     r3,     #3      @ each element of rk is 8 bytes
    ADD         r3,     r3,     #4      @ skip Nr
    LDR         r2,     [r7, r3]        @ load lower half of rk[i]
    ADD         r3,     r3,     #4
    LDR         r3,     [r7, r3]        @ load higher half of rk[i]
    BL          XOR_64                  @ result = R1:R0
# update s:
    MOV         r5,     r0
    MOV         r6,     r1
# increment i
    ADD         r4,     r4,     #1
    LDR         r0,     [r7]            @ load Nr
    CMP         r4,     r0              @ i <= Nr
    BLE         TD_LOOP
# inverse mix column:
    MOV         r0,     r5
    MOV         r1,     r6              @ move s into R1:R0
    BL          inverse_mix_col         @ s = R1:R0
    MOV         r5,     r0
    MOV         r6,     r1              @ move s into R6:R5
# PUTU64(pt, s);
    MOV         r1,     #100
    ADD         r1,     r1,     #180    @ 4 + 33*8 + 4 + 4 + 4 = 280
    LDR         r0,     [r7, r1]        @ load addr to pt into r0
    MOV         r1,     r5
    MOV         r2,     r6              @ copy s into R2:R1
    BL          PUTU64                  @ pt is updated
# done
    ADD         r7,     r7,     #100
    ADD         r7,     r7,     #168    @ 4 + 33*8 = 268
    MOV         sp,     r7              @ restore sp
    POP         {r0-r7}                 @ restore R0-R7
    POP         {r2}                    @ lr
    BX          r2                      @ return
# =============================================================================
# Procedure: inverse_mix_col
# Arguments:
#       an 64-bit integer s
#       1. lower half stored in R0
#       2. higher half stored in R1
# Global variables: TmcH, TmcL
# Return value:
#       an 64-bit integer
#       1. lower half stored in R0
#       2. higher half stored in R1
# Used registers: R0, R1, R2, R3, R4-R7
# =============================================================================
inverse_mix_col:
    PUSH        {r4-r7, lr}             @ save R4-R7, lr
    MOV         r7,     r1
    MOV         r6,     r0              @ copy s into R7:R6
# s0 = (s>>56ULL)&0xff;
    MOV         r2,     #56             @ shift offset
    BL          LSR_64                  @ result = R1:R0
    MOV         r2,     #0xff
    AND         r0,     r0,     r2      @ s0 = r0, 32-bit integer
# TmcH[s0]:
    LDR         r1,     =TmcH           @ load addr to TmcH
    LSL         r0,     r0,     #1      @ each elements in TmcH is 2 byte
    LDRH        r4,     [r1, r0]        @ load TmcH[s0]
# s1 = (s>>48ULL)&0xff;
    MOV         r0,     r6
    MOV         r1,     r7              @ load s into R1:R0
    MOV         r2,     #48             @ shift offset
    BL          LSR_64                  @ result = R1:R0
    MOV         r2,     #0xff
    AND         r0,     r0,     r2      @ s1 = r0, 32-bit integer
# TmcL[s1]:
    LDR         r1,     =TmcL           @ load addr to TmcL
    LSL         r0,     r0,     #1      @ idem
    LDRH        r0,     [r1, r0]        @ load TmcL[s1]
# (TmcH[s0] ^ TmcL[s1]) << 48:
    EOR         r0,     r4,     r0
    MOV         r1,     #0              @ expand to 64-bit integer, R1:R0
    MOV         r2,     #48             @ shift offset
    BL          LSL_64                  @ result = R1:R0
# tmp = result
    MOV         r4,     r0
    MOV         r5,     r1              @ tmp = R5:R4
# s2 = (s>>40ULL)&0xff;
    MOV         r0,     r6
    MOV         r1,     r7              @ load s into R1:R0
    MOV         r2,     #40             @ shift offset
    BL          LSR_64                  @ result = R1:R0
    MOV         r2,     #0xff
    AND         r0,     r0,     r2      @ s2 = r0, 32-bit integer
# TmcH[s2]:
    LDR         r1,     =TmcH           @ load addr to TmcH
    LSL         r0,     r0,     #1      @ each elements in TmcH is 2 bytes
    LDRH        r3,     [r1, r0]        @ load TmcH[s2]
    PUSH        {r3}                    @ save it
# s3 = (s>>32ULL)&0xff;
    MOV         r0,     r6
    MOV         r1,     r7              @ load s into R1:R0
    MOV         r2,     #32             @ shift offset
    BL          LSR_64                  @ result = R1:R0
    MOV         r2,     #0xff
    AND         r0,     r0,     r2      @ s3 = r0, 32-bit integer
# TmcL[s3]:
    LDR         r1,     =TmcL           @ load addr to TmcL
    LSL         r0,     r0,     #1      @ each elements in TmcL is 2 bytes
    LDRH        r0,     [r1, r0]        @ load TmcL[s3]
# (TmcH[s2] ^ TmcL[s3]) << 32:
    POP         {r3}                    @ load TmcH[s2]
    EOR         r0,     r3,     r0
    MOV         r1,     #0              @ expand to 64-bit, R1:R0
    MOV         r2,     #32             @ shift offset
    BL          LSL_64                  @ result = R1:R0
# tmp ^= result:
    MOV         r2,     r4
    MOV         r3,     r5
    BL          XOR_64                  @ result = R1:R0
# write back:
    MOV         r4,     r0
    MOV         r5,     r1
# s4 = (s>>24ULL)&0xff;
    MOV         r0,     r6
    MOV         r1,     r7              @ load s into R1:R0
    MOV         r2,     #24             @ shift offset
    BL          LSR_64                  @ result = R1:R0
    MOV         r2,     #0xff
    AND         r0,     r0,     r2      @ s4 = r0, 32-bit integer
# TmcH[s4]:
    LDR         r1,     =TmcH           @ load addr to TmcH
    LSL         r0,     r0,     #1      @ each elements in TmcH is 2 bytes
    LDRH        r3,     [r1, r0]        @ load TmcH[s4]
    PUSH        {r3}                    @ save it
# s5 = (s>>16ULL)&0xff;
    MOV         r0,     r6
    MOV         r1,     r7              @ load s into R1:R0
    MOV         r2,     #16             @ shift offset
    BL          LSR_64                  @ result = R1:R0
    MOV         r2,     #0xff
    AND         r0,     r0,     r2      @ s5 = r0, 32-bit integer
# TmcL[s5]:
    LDR         r1,     =TmcL           @ load addr to TmcL
    LSL         r0,     r0,     #1      @ each elements in TmcL is 2 bytes
    LDRH        r0,     [r1, r0]        @ load TmcL[s5]
# (TmcH[s4] ^ TmcL[s5]) << 16:
    POP         {r3}                    @ load TmcH[s4]
    EOR         r0,     r3,     r0
    MOV         r1,     #0              @ expand to 64-bit, R1:R0
    MOV         r2,     #16             @ shift offset
    BL          LSL_64                  @ result = R1:R0
# tmp ^= result:
    MOV         r2,     r4
    MOV         r3,     r5
    BL          XOR_64                  @ result = R1:R0
# write back:
    MOV         r4,     r0
    MOV         r5,     r1
#s6 = (s>> 8ULL)&0xff;
    MOV         r0,     r6
    MOV         r1,     r7              @ load s into R1:R0
    MOV         r2,     #8              @ shift offset
    BL          LSR_64                  @ result = R1:R0
    MOV         r2,     #0xff
    AND         r0,     r0,     r2      @ s6 = r0, 32-bit integer
# TmcH[s6]:
    LDR         r1,     =TmcH           @ load addr to TmcH
    LSL         r0,     r0,     #1      @ each elements in TmcH is 2 bytes
    LDRH        r3,     [r1, r0]        @ load TmcH[s6]
                                        @ no need to save, not calling LSR_64
#s7 = (s>> 0ULL)&0xff;
    MOV         r0,     r6              @ s = R0, no need to load higher half
    MOV         r1,     #0xff
    AND         r0,     r0,     r1      @ s7 = r0, 32-bit integer
# TmcL[s7]:
    LDR         r1,     =TmcL           @ load addr to TmcL
    LSL         r0,     r0,     #1      @ each elements in TmcL is 2 bytes
    LDRH        r0,     [r1, r0]        @ load TmcL[s7]
# (TmcH[s6] ^ TmcL[s7]) << 0:
    EOR         r0,     r3,     r0
    MOV         r1,     #0              @ expand to 64-bit, no need to shift
# tmp ^= result:
    MOV         r2,     r4
    MOV         r3,     r5
    BL          XOR_64                  @ result = R1:R0
# done, no need to move result
    POP         {r4-r7}                 @ restore R4-R7
    POP         {r2}                    @ lr
    BX          r2                      @ return
