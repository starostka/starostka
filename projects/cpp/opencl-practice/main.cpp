#include <stdio.h>
#include <stdlib.h>

#ifdef __APPLE__
#include <OpenCL/opencl.h>
#else
#include <CL/cl.h>
#endif

#define MAX_SOURCE_SIZE (0x100000)

int main(void)
{
    // int i;
    const int LIST_SIZE = 1024;
    int *A = (int *)malloc(sizeof(int) * LIST_SIZE);
    int *B = (int *)malloc(sizeof(int) * LIST_SIZE);
    for (int i = 0; i < LIST_SIZE; i++)
    {
        A[i] = i;
        B[i] = LIST_SIZE - i;
    }

    // load kernel
    FILE *fp;
    char *source_str;
    size_t source_size;

    fp = fopen("vector_add_kernel.c", "r");
    if (!fp)
    {
        fprintf(stderr, "failed to load kernel\n");
        exit(1);
    }

    // load device information
    source_str = (char *)malloc(MAX_SOURCE_SIZE);
    source_size = fread(source_str, 1, MAX_SOURCE_SIZE, fp);
    fclose(fp);

    cl_platform_id platform_id = NULL;
    cl_device_id device_id = NULL;
    cl_uint ret_num_devices;
    cl_uint ret_num_platforms;
    cl_int ret = clGetPlatformIDs(1, &platform_id, &device_id);
    ret = clGetDeviceIDs(platform_id, CL_DEVICE_TYPE_DEFAULT, 1, &device_id, &ret_num_devices);

    // create opencl context 
    cl_context context = clCreateContext(NULL, 1, &device_id, NULL, NULL, &ret);
    // create opencl command
    cl_command_queue command_queue = clCreateCommandQueue(context, device_id, 0, &ret);

    // create memory buffers for each vector
    cl_mem a_mem_obj = clCreateBuffer(context, CL_MEM_READ_ONLY, LIST_SIZE * sizeof(int), NULL, &ret);
    cl_mem b_mem_obj = clCreateBuffer(context, CL_MEM_READ_ONLY, LIST_SIZE * sizeof(int), NULL, &ret);
    cl_mem c_mem_obj = clCreateBuffer(context, CL_MEM_WRITE_ONLY, LIST_SIZE * sizeof(int), NULL, &ret);

    // copy values to their buffers
    ret = clEnqueueWriteBuffer(command_queue, a_mem_obj, CL_TRUE, 0, LIST_SIZE * sizeof(int), A, 0, NULL, NULL);
    ret = clEnqueueWriteBuffer(command_queue, b_mem_obj, CL_TRUE, 0, LIST_SIZE * sizeof(int), B, 0, NULL, NULL);

    // create program from kernel source
    cl_program program = clCreateProgramWithSource(context, 1, (const char **)&source_str, (const size_t *)&source_size, &ret);

    // build the program
    ret = clBuildProgram(program, 1, &device_id, NULL, NULL, NULL);

    // create openCL kernel
    cl_kernel kernel = clCreateKernel(program, "vector_add", &ret);

    // set kernel arguments
    ret = clSetKernelArg(kernel, 0, sizeof(cl_mem), (void *)&a_mem_obj);
    ret = clSetKernelArg(kernel, 1, sizeof(cl_mem), (void *)&b_mem_obj);
    ret = clSetKernelArg(kernel, 2, sizeof(cl_mem), (void *)&c_mem_obj);

    // execute the opencl on list
    size_t global_item_size = LIST_SIZE;
    size_t local_item_size = 64;
    ret = clEnqueueReadBuffer(command_queue, c_mem_obj, CL_TRUE, 0, LIST_SIZE * sizeof(int), C, 0, NULL, NULL);

    // display result
    for(int i = 0; i < LIST_SIZE, i++) {
        printf("%d + %d = %d\n", A[i], B[i], C[i]);
    }

    // clean
    ret = clFlush(command_queue);
    ret = clFinish(command_queue);
    ret = clReleaseKernel(kernel);
    ret = clReleaseProgram(program);
    ret = clReleaseMemObject(a_mem_obj);
    ret = clReleaseMemObject(b_mem_obj);
    ret = clReleaseMemObject(c_mem_obj);
    ret = clReleaseCommandQueue(command_queue);
    ret = clReleaseContext(context);
    free(A);
    free(B);
    free(C);
    return 0;
}