#!/bin/bash

JUPYTER_PATH="jupyter"

if [ -f ./extensions.txt ]; then
  echo "INFO: Found extensions.txt file in folder /. Installing via \"jupyter extension install --user\""
  cat extensions.txt | xargs -I {} jupyter {} install --no-build
else
  echo "INFO: extensions.txt not found in folder / --> Continuing"
fi

${JUPYTER_PATH} --paths
${JUPYTER_PATH} nbextension enable --py --sys-prefix ipyevents
${JUPYTER_PATH} nbextension enable --py --sys-prefix widgetsnbextension
${JUPYTER_PATH} nbextensions_configurator enable --user
${JUPYTER_PATH} labextension update --all
${JUPYTER_PATH} labextension install @jupyterlab/debugger
${JUPYTER_PATH} labextension install @krassowski/jupyterlab-lsp
${JUPYTER_PATH} labextension install jupyter-threejs --no-build 
${JUPYTER_PATH} labextension install @lckr/jupyterlab_variableinspector --no-build 
${JUPYTER_PATH} labextension install jupyterlab-system-monitor --no-build 
${JUPYTER_PATH} labextension install jupyterlab-topbar-extension --no-build 
${JUPYTER_PATH} labextension install @jupyterlab/toc --no-build 
${JUPYTER_PATH} labextension install jupyter-matplotlib --no-build 
${JUPYTER_PATH} labextension install @jupyterlab/celltags --no-build 
${JUPYTER_PATH} labextension install @krassowski/jupyterlab_go_to_definition  --no-build 
${JUPYTER_PATH} labextension install @finos/perspective-jupyterlab --no-build 
${JUPYTER_PATH} labextension install ipytree --no-build 
${JUPYTER_PATH} labextension install ipysheet --no-build 
${JUPYTER_PATH} labextension install jupyterlab-cell-flash --no-build 
${JUPYTER_PATH} labextension install jupyterlab-theme-solarized-dark --no-build 
${JUPYTER_PATH} labextension install @deathbeds/jupyterlab-font-anonymous-pro --no-build
${JUPYTER_PATH} labextension install @deathbeds/jupyterlab-font-dejavu-sans-mono --no-build
${JUPYTER_PATH} labextension install @deathbeds/jupyterlab-font-fira-code --no-build
${JUPYTER_PATH} labextension install mind-map --no-build
${JUPYTER_PATH} labextension install qgrid --no-build
${JUPYTER_PATH} serverextension enable --py jupyterlab --sys-prefix
${JUPYTER_PATH} lab build -y --dev-build=False --minimize=False
${JUPYTER_PATH} lab clean
jlpm cache clean
npm cache clean --force
rm -rf $HOME/.node-gyp
rm -rf $HOME/.local
${JUPYTER_PATH} labextension list

# ${JUPYTER_PATH} labextension install --no-build @jupyter-widgets/jupyterlab-manager@2.0
# ${JUPYTER_PATH} labextension install --no-build jupyterlab-spreadsheet
# ${JUPYTER_PATH} labextension install --no-build spreadsheet-editor
# ${JUPYTER_PATH} labextension install --no-build jupyterlab_commands
# ${JUPYTER_PATH} labextension install --no-build jupyterlab-execute-time
# ${JUPYTER_PATH} labextension install --no-build @bokeh/jupyter_bokeh
# ${JUPYTER_PATH} labextension install --no-build @jupyter-voila/jupyterlab-preview
# ${JUPYTER_PATH} labextension install --no-build jupyterlab_powerpoint
# ${JUPYTER_PATH} labextension install --no-build jupyterlab_filetree
# ${JUPYTER_PATH} labextension install --no-build jupyterlab_templates
# ${JUPYTER_PATH} labextension install --no-build jupyterlab-drawio
# ${JUPYTER_PATH} labextension install --no-build @jupyterlab/dataregistry-extension
# ${JUPYTER_PATH} labextension install --no-build @ryantam626/jupyterlab_code_formatter
# ${JUPYTER_PATH} labextension install --no-build @agoose77/jupyterlab-markup
# ${JUPYTER_PATH} labextension install --no-build jupyterlab_tensorboard
# ${JUPYTER_PATH} labextension install --no-build jupyterlab-flake8
# ${JUPYTER_PATH} labextension install @deathbeds/jupyterlab-fonts --no-build
# ${JUPYTER_PATH} serverextension enable --py jupyterlab_git
# ${JUPYTER_PATH} serverextension enable --py jupyterlab_code_formatter --sys-prefix
# ${JUPYTER_PATH} serverextension enable --py jupyterlab_templates --sys-prefix
# ${JUPYTER_PATH} serverextension enable --py jupyterlab_commands --sys-prefix
# ${JUPYTER_PATH} serverextension enable --py jupyterlab_powerpoint --sys-prefix
# ${JUPYTER_PATH} labextension install --no-build @ijmbarr/jupyterlab_spellchecker
# ${JUPYTER_PATH} labextension install --no-build @aquirdturtle/collapsible_heading
