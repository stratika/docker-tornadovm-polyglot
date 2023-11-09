# docker-tornadovm-graalpython
Docker build scripts for TornadoVM with GraalPy on GPUs.
The size of the image is 11.2GB and it has a build image of [TornadoVM (GraalVM 23.1.0)](https://github.com/beehive-lab/TornadoVM/commit/fe269d9b16d9b0b1ac981c80dfec2a5cf7c14206) with GraalPython ([tag: graal-23.1.0](https://github.com/oracle/graalpython/releases/tag/graal-23.1.0)) and OpenCL driver for Nvidia GPUs.

To build the container you can use a script as follows:
```bash
./buildDockerAndLaunch.sh --help
Please run:
  ./buildDockerAndLaunch.sh --build	          #to build the image, or
  ./buildDockerAndLaunch.sh <command>		      #to launch the built image or execute a command, or
  ./buildDockerAndLaunch.sh --deleteVolume	  #to delete the generated volume, or
  ./buildDockerAndLaunch.sh --help		        #to print help message
```

To build the container, try:
```bash
./buildDockerAndLaunch.sh --build
```

To try an example of running a python example from [here](https://github.com/beehive-lab/TornadoVM/blob/master/tornado-assembly/src/examples/polyglotTruffle/mxmWithTornadoVM.py) in the container with TornadoVM use:
```bash
./buildDockerAndLaunch.sh tornado --printKernel --truffle python /tornado-dev/tornado/bin/sdk/examples/polyglotTruffle/mxmWithTornadoVM.py
```
The output will be:
```bash
WARNING: Using incubator modules: jdk.incubator.vector
Running with tornadoVM
Hello TornadoVM from Python!
#pragma OPENCL EXTENSION cl_khr_fp64 : enable  
#pragma OPENCL EXTENSION cl_khr_int64_base_atomics : enable  
__kernel void mxm(__global long *_kernel_context, __constant uchar *_constant_region, __local uchar *_local_region, __global int *_atomics, __global uchar *a, __global uchar *b, __global uchar *c, __private int N)
{
  int i_28, i_27, i_19, i_13, i_12, i_10, i_9, i_8, i_7, i_6, i_5, i_4, i_3, i_34, i_33; 
  ulong ul_23, ul_2, ul_1, ul_17, ul_0, ul_32; 
  float f_24, f_25, f_18, f_26, f_11; 
  long l_29, l_14, l_30, l_21, l_22, l_20, l_15, l_31, l_16; 

  // BLOCK 0
  ul_0  =  (ulong) a;
  ul_1  =  (ulong) b;
  ul_2  =  (ulong) c;
  i_3  =  get_global_size(0);
  i_4  =  get_global_size(1);
  i_5  =  get_global_id(0);
  i_6  =  get_global_id(1);
  // BLOCK 1 MERGES [0 8 ]
  i_7  =  i_6;
  for(;i_7 < 512;)
  {
    // BLOCK 2
    i_8  =  i_7 << 9;
    // BLOCK 3 MERGES [2 7 ]
    i_9  =  i_5;
    for(;i_9 < 512;)
    {
      // BLOCK 4
      i_10  =  i_9 + 512;
      // BLOCK 5 MERGES [4 6 ]
      f_11  =  0.0F;
      i_12  =  0;
      for(;i_12 < 512;)
      {
        // BLOCK 6
        i_13  =  i_8 + i_12;
        l_14  =  (long) i_13;
        l_15  =  l_14 << 2;
        l_16  =  l_15 + 24L;
        ul_17  =  ul_0 + l_16;
        f_18  =  *((__global float *) ul_17);
        i_19  =  i_10 + i_12;
        l_20  =  (long) i_19;
        l_21  =  l_20 << 2;
        l_22  =  l_21 + 24L;
        ul_23  =  ul_1 + l_22;
        f_24  =  *((__global float *) ul_23);
        f_25  =  f_18 + f_24;
        f_26  =  f_11 + f_25;
        i_27  =  i_12 + 1;
        f_11  =  f_26;
        i_12  =  i_27;
      }  // B6
      // BLOCK 7
      i_28  =  i_9 + i_8;
      l_29  =  (long) i_28;
      l_30  =  l_29 << 2;
      l_31  =  l_30 + 24L;
      ul_32  =  ul_2 + l_31;
      *((__global float *) ul_32)  =  f_11;
      i_33  =  i_3 + i_9;
      i_9  =  i_33;
    }  // B7
    // BLOCK 8
    i_34  =  i_4 + i_7;
    i_7  =  i_34;
  }  // B8
  // BLOCK 9
  return;
}  //  kernel

Total time (s): 0.5230000019073486
Total time (s): 0.006999969482421875
Total time (s): 0.003000020980834961
Total time (s): 0.002000093460083008
Total time (s): 0.0019998550415039062
```
