#!/bin/bash

SHARED_LIB="ON"
ARM="ON"
OPENMP="ON"
OPENCL="OFF"
QUANTIZATION="OFF"
MODEL_CHECK="ON"
CC=gcc
CXX=g++

if [ -z $TNN_ROOT_PATH ]
then
    TNN_ROOT_PATH=$(cd `dirname $0`; pwd)/..
fi

mkdir build_linux
cd build_linux

cmake ${TNN_ROOT_PATH} \
    -DCMAKE_SYSTEM_NAME=Linux  \
    -DTNN_TEST_ENABLE=ON \
    -DTNN_CPU_ENABLE=ON \
    -DCMAKE_C_COMPILER=$CC \
    -DCMAKE_CXX_COMPILER=$CXX \
    -DTNN_ARM_ENABLE:BOOL=$ARM \
    -DTNN_OPENMP_ENABLE:BOOL=$OPENMP \
    -DTNN_OPENCL_ENABLE:BOOL=$OPENCL \
    -DTNN_QUANTIZATION_ENABLE:BOOL=$QUANTIZATION \
    -DTNN_MODEL_CHECK_ENABLE:BOOL=$MODEL_CHECK	\
    -DTNN_UNIT_TEST_ENABLE=ON \
    -DTNN_COVERAGE=ON \
    -DTNN_BENCHMARK_MODE=ON \
    -DTNN_BUILD_SHARED:BOOL=$SHARED_LIB


make -j4

ctest --output-on-failure -j 2
