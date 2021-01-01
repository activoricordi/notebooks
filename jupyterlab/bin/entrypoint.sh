#!/bin/bash

CMD="jupyter lab --allow-root --ip=0.0.0.0 --no-browser --notebook-dir=/opt/env/workspace"

if [[ -v PASSWORD ]]; then
  PASSWORD=$(python -c "import IPython; print(IPython.lib.security.passwd('$PASSWORD'))")
  CMD="$CMD --NotebookApp.token='' --NotebookApp.password='${PASSWORD}'"
fi

echo
echo "Installed software:"
python --version
pip --version
jupyter --version
echo "Node $(node --version)"
echo "NPM $(npm -v)"

echo
echo "Installed Python packages:"
pip list -l

echo
echo "Installed Juypter extensions"
jupyter labextension list

echo
exec $CMD "$@"