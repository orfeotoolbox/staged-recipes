#!/bin/bash

# Restore previous PYTHONPATH env vars if they were set

unset PYTHONPATH
if [[ -n "${_CONDA_SET_PYTHONPATH}" ]]; then
    export PYTHONDATA=${_CONDA_SET_PYTHONPATH}
    unset _CONDA_SET_PYTHONPATH
fi

