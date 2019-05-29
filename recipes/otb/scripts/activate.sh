#!/bin/bash

# Store existing env vars and set to this conda env

if [[ -n "${PYTHONPATH}" ]]; then
    export _CONDA_SET_PYTHONPATH=${PYTHONPATH}
fi

if [ -d ${CONDA_PREFIX}/lib/otb/python/ ]; then
    export PYTHONPATH=${CONDA_PREFIX}/lib/otb/python/:${_CONDA_SET_PYTHONPATH}
fi
