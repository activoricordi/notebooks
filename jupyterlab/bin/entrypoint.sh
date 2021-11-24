#!/bin/bash

CMD="jupyter lab --allow-root --port=8888 --ip=0.0.0.0 --no-browser"

if [[ -v PASSWORD ]]; then
  PASSWORD=$(python -c "import IPython; print(IPython.lib.security.passwd('$PASSWORD'))")
  CMD="$CMD --NotebookApp.token='' --NotebookApp.password='${PASSWORD}'"
fi


source /venv/bin/activate && \
python -c "import numpy; print('success!')" && \
echo "Installed software:" && \
echo " Python Version: " && python --version && \
echo " Pip Version: " && pip --version && \
echo " Pip Version: " && jupyter --version

# Check Node is installed
echo
echo "NODE Version:" && node --version && which node && \
echo "NPM Version:" && npm --version && which npm

echo
echo "Installed Python packages:" && pip list -l

echo
echo "Configure Jupyterlab"
# Enable Jupyter server extension
jupyter serverextension enable --py jupyterlab --sys-prefix && \
jupyter notebook --generate-config && \
jupyter --paths  && \
jupyter nbextension enable --py --sys-prefix ipyevents && \
jupyter nbextension enable --py --sys-prefix widgetsnbextension && \
# Lab extension install
jupyter labextension install jupyter-threejs --no-build && \
jupyter labextension install jupyterlab-theme-solarized-dark --no-build && \
jupyter labextension install mind-map --no-build && \
jupyter labextension install --no-build @ijmbarr/jupyterlab_spellchecker && \
# Lab extension update
jupyter labextension update --all && \
jupyter lab build -y --dev-build=False --minimize=False && \
jupyter lab clean && \
jlpm cache clean && \
npm cache clean --force && \
rm -rf $HOME/.node-gyp && \
rm -rf $HOME/.local && \
echo "Environment Activated"

echo
echo "Installed Juypter extensions"
jupyter labextension list

echo
exec $CMD "$@"
