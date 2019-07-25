#!/bin/bash

# Restore previous PYTHONPATH env vars if they were set

unset PYTHONPATH
if [[ -n "${_CONDA_SET_PYTHONPATH}" ]]; then
    export PYTHONPATH=${_CONDA_SET_PYTHONPATH}
    unset _CONDA_SET_PYTHONPATH
fi

unset OTB_APPLICATION_PATH
if [[ -n "${_CONDA_SET_OTB_APPLICATION_PATH}" ]]; then
    export OTB_APPLICATION_PATH=${_CONDA_SET_OTB_APPLICATION_PATH}
    unset _CONDA_SET_OTB_APPLICATION_PATH
fi

