#!/bin/bash

# When building 32-bits on 64-bit system this flags is not automatically set by conda-build
if [ $ARCH == 32 -a "${OSX_ARCH:-notosx}" == "notosx" ]; then
    export CFLAGS="${CFLAGS} -m32"
    export CXXFLAGS="${CXXFLAGS} -m32"
fi

BUILD_DIR=${SRC_DIR}/build
mkdir ${BUILD_DIR}
cd ${BUILD_DIR}

cmake \
    -G "Ninja" \
    ${CMAKE_ARGS} \
    -D CMAKE_BUILD_TYPE:STRING=RELEASE \
    -D BUILD_SHARED_LIBS:BOOL=ON \
    -D BUILD_TESTING:BOOL=OFF \
    -D BUILD_EXAMPLES:BOOL=OFF \
    -D ITK_USE_SYSTEM_EXPAT:BOOL=ON \
    -D ITK_USE_SYSTEM_HDF5:BOOL=ON \
    -D ITK_USE_SYSTEM_JPEG:BOOL=ON \
    -D ITK_USE_SYSTEM_PNG:BOOL=ON \
    -D ITK_USE_SYSTEM_TIFF:BOOL=ON \
    -D ITK_USE_SYSTEM_ZLIB:BOOL=ON \
    -D ITK_USE_KWSTYLE:BOOL=OFF \
    -D ITK_FORBID_DOWNLOADS:BOOL=ON \
    -D ITK_TEMPLATE_VISIBILITY_DEFAULT:BOOL=ON \
    -D ITK_USE_FFTWD:BOOL=ON \
    -D ITK_USE_FFTWF:BOOL=ON \
    -D ITK_USE_SYSTEM_FFTW:BOOL=ON \
    -D ITKGroup_Core:BOOL=OFF \
    -D ITK_BUILD_DEFAULT_MODULES:BOOL=OFF \
    -D Module_ITKCommon:BOOL=ON \
    -D Module_ITKTestKernel:BOOL=ON \
    -D Module_ITKFiniteDifference:BOOL=ON \
    -D Module_ITKGPUCommon:BOOL=ON \
    -D Module_ITKGPUFiniteDifference:BOOL=ON \
    -D Module_ITKImageAdaptors:BOOL=ON \
    -D Module_ITKImageFunction:BOOL=ON \
    -D Module_ITKMesh:BOOL=ON \
    -D Module_ITKQuadEdgeMesh:BOOL=ON \
    -D Module_ITKSpatialObjects:BOOL=ON \
    -D Module_ITKTransform:BOOL=ON \
    -D Module_ITKTransformFactory:BOOL=ON \
    -D Module_ITKIOTransformBase:BOOL=ON \
    -D Module_ITKIOTransformInsightLegacy:BOOL=ON \
    -D Module_ITKIOTransformMatlab:BOOL=ON \
    -D Module_ITKAnisotropicSmoothing:BOOL=ON \
    -D Module_ITKAntiAlias:BOOL=ON \
    -D Module_ITKBiasCorrection:BOOL=ON \
    -D Module_ITKBinaryMathematicalMorphology:BOOL=ON \
    -D Module_ITKColormap:BOOL=ON \
    -D Module_ITKConvolution:BOOL=ON \
    -D Module_ITKCurvatureFlow:BOOL=ON \
    -D Module_ITKDeconvolution:BOOL=ON \
    -D Module_ITKDenoising:BOOL=ON \
    -D Module_ITKDisplacementField:BOOL=ON \
    -D Module_ITKDistanceMap:BOOL=ON \
    -D Module_ITKFastMarching:BOOL=ON \
    -D Module_ITKFFT:BOOL=ON \
    -D Module_ITKGPUAnisotropicSmoothing:BOOL=ON \
    -D Module_ITKGPUImageFilterBase:BOOL=ON \
    -D Module_ITKGPUSmoothing:BOOL=ON \
    -D Module_ITKGPUThresholding:BOOL=ON \
    -D Module_ITKImageCompare:BOOL=ON \
    -D Module_ITKImageCompose:BOOL=ON \
    -D Module_ITKImageFeature:BOOL=ON \
    -D Module_ITKImageFilterBase:BOOL=ON \
    -D Module_ITKImageFusion:BOOL=ON \
    -D Module_ITKImageGradient:BOOL=ON \
    -D Module_ITKImageGrid:BOOL=ON \
    -D Module_ITKImageIntensity:BOOL=ON \
    -D Module_ITKImageLabel:BOOL=ON \
    -D Module_ITKImageSources:BOOL=ON \
    -D Module_ITKImageStatistics:BOOL=ON \
    -D Module_ITKLabelMap:BOOL=ON \
    -D Module_ITKMathematicalMorphology:BOOL=ON \
    -D Module_ITKPath:BOOL=ON \
    -D Module_ITKQuadEdgeMeshFiltering:BOOL=ON \
    -D Module_ITKSmoothing:BOOL=ON \
    -D Module_ITKSpatialFunction:BOOL=ON \
    -D Module_ITKThresholding:BOOL=ON \
    -D Module_ITKEigen:BOOL=ON \
    -D Module_ITKNarrowBand:BOOL=ON \
    -D Module_ITKNeuralNetworks:BOOL=ON \
    -D Module_ITKOptimizers:BOOL=ON \
    -D Module_ITKOptimizersv4:BOOL=ON \
    -D Module_ITKPolynomials:BOOL=ON \
    -D Module_ITKStatistics:BOOL=ON \
    -D Module_ITKRegistrationCommon:BOOL=ON \
    -D Module_ITKGPURegistrationCommon:BOOL=ON \
    -D Module_ITKGPUPDEDeformableRegistration:BOOL=ON \
    -D Module_ITKMetricsv4:BOOL=ON \
    -D Module_ITKPDEDeformableRegistration:BOOL=ON \
    -D Module_ITKRegistrationMethodsv4:BOOL=ON \
    -D Module_ITKClassifiers:BOOL=ON \
    -D Module_ITKConnectedComponents:BOOL=ON \
    -D Module_ITKDeformableMesh:BOOL=ON \
    -D Module_ITKKLMRegionGrowing:BOOL=ON \
    -D Module_ITKLabelVoting:BOOL=ON \
    -D Module_ITKLevelSets:BOOL=ON \
    -D Module_ITKLevelSetsv4:BOOL=ON \
    -D Module_ITKMarkovRandomFieldsClassifiers:BOOL=ON \
    -D Module_ITKRegionGrowing:BOOL=ON \
    -D Module_ITKSignedDistanceFunction:BOOL=ON \
    -D Module_ITKVoronoi:BOOL=ON \
    -D Module_ITKWatersheds:BOOL=ON \
    -D "CMAKE_SYSTEM_PREFIX_PATH:FILEPATH=${PREFIX}" \
    -D "CMAKE_INSTALL_PREFIX=${PREFIX}" \
    "${SRC_DIR}"

ninja -j 4 

cmake \
    -D CMAKE_INSTALL_PREFIX=$PREFIX \
    -P ${BUILD_DIR}/cmake_install.cmake


