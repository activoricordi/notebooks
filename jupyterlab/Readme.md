# Jupyterlab

## Jupyter lab Container

### Size Statistics

| Base Image | Size | Comments |
|:---|:---|:---|
| debian:buster-slim |782.8 MB | |
| eventstreaming_jupyterlab | 2.53 GB | |

### Micromamba

To build the python image, we used *micromamba*.

*micromamba* is a tiny version of the *mamba package manager*. It is a pure C++ package with a separate command line interface. It can be used to bootstrap environments (as an alternative to miniconda), but it's currently experimental. The benefit is that it's very tiny and does not come with a default version of Python.

It provides the following advantages:

* Parallel downloading of repository data and package files using multi-threading.
* **libsolv** for much faster dependency solving, a state of the art library used in the RPM package manager of Red Hat, Fedora and OpenSUSE
* Core parts of **mamba** are implemented in C++ for maximum efficiency
  
The environment.yml file inside the project directory, it is possible to use the following commands to create the environment as a subdirectory.

### Conda Pack

* [conda pack](https://conda.github.io/conda-pack/)
* [conda docker image size](https://pythonspeed.com/articles/conda-docker-image-size/)

### Conda Clean

For Conda, the most thorough cleanup command is 'conda clean --all -fy'. This removes cache files, package tarballs and entire package cache. To ensure only necessary files are saved in each layer. You will want to add this to end of any RUN commands that installs packages with Conda.

### Create a Multi-stage Docker file

Docker 17.05 added support for *multistage builds*.

Following the guidelines to create [smaller python docker images](https://pythonspeed.com/articles/smaller-python-docker-images/) and [faster multi stage builds](https://pythonspeed.com/articles/faster-multi-stage-builds/).

## Docker Compose Buildkit

The latest version of Docker 20.10 in late 2020 includes a great feature called [Docker Buildkit](https://pythonspeed.com/articles/docker-buildkit/). This version of docker compose.

If we use the latest docker desktop and buildkit version.

<details>
<summary>
<a class="btnfire small stroke"><em class="fas fa-chevron-circle-down"></em>&nbsp;&nbsp;Show Code</a>    
</summary>

```shell
COMPOSE_DOCKER_CLI_BUILD=1 DOCKER_BUILDKIT=1 docker-compose build
```

```shell
# eventstreaming_jupyterlab
docker image history img_name
```
</details>
  
## Convert non-root user id

## Libraries

These are the list of libraries:

<details>
<summary>
<a class="btnfire small stroke"><em class="fas fa-chevron-circle-down"></em>&nbsp;&nbsp;Show Libraries</a>    
</summary>

* **dask:** It is a pandas-like application.
* **pandas:** Pandas application
* **numexpr:** Numeric expressions
* **scipy:**
* **scikit-learn:**
* **sympy:**
* **patsy:**
* **statsmodel:**
* **cloudpickle:**
* **dill:**
* **numba:**
* **voila:** Rendering of live Jupyter notebooks with interactive widgets.
* **voila-gridstack:**
* **sqlalchemy:**
* **hdf5:**
* **protobuf:**
* **bottleneck:** A collection of fast NumPy array functions written in C.
* **pytables:** A package for managing hierarchical datasets and designed to efficiently and easily cope with extremely large amounts of data.
* **ipywidgets:** Interactive widgets
* **Facets:** Visualizing machine learning datasets
</details>
  
## Examples

### Jupyter lab Table of Contents

* A new built-in feature from JupyterLab >= 3.0.
* A Table of Contents extension for JupyterLab. This auto-generates a table of contents in the left area when you have a notebook or markdown document open. The entries are clickable, and scroll the document to the heading in question.

### Metadata

* A new built-in feature from JupyterLab >= 3.0.
* The extension celltags is included. It provides a metadata editor in the sidebar.

### Widgets

```python
from ipywidgets import interact, interactive, fixed, interact_manual
import ipywidgets as widgets
w = widgets.IntSlider()
display(w)
w.value
```

```python
w.value = 100
```

### Jupyterlab Spreadsheet

To use the Jupyterlab spreadsheet:

```python
import ipysheet
sheet = ipysheet.sheet()
sheet
```

### Jupyterlab Matplotlib

Leveraging the Jupyter interactive widgets framework, ipympl enables the interactive features of matplotlib in the Jupyter notebook and in JupyterLab.

To enable the ipympl backend, simply use the matplotlib Jupyter magic:

```python
%matplotlib widget
```

### Jupyterlab execute time

## References

<details>
<summary>
<a class="btnfire small stroke"><em class="fas fa-chevron-circle-down"></em>&nbsp;&nbsp;Show Reference List</a>    
</summary>

* [Smaller Docker images with Conda](https://jcristharif.com/conda-docker-tips.html)
* [Jupyterlab](https://github.com/amalic/Jupyterlab)
* [NLP Jupyterlab examples](https://github.com/edbullen/nltk/blob/master/tokenisation.ipynb)
* [Create a Conda environment file](https://docs.conda.io/projects/conda/en/latest/user-guide/tasks/manage-environments.html#create-env-file-manually)
* [Node Docker Multistage](https://codefresh.io/docker-tutorial/node_docker_multistage/)
* [How to write a great Dockerfile for Python apps](https://www.pybootcamp.com/blog/how-to-write-dockerfile-python-apps/)
* [Docker Buildkit](https://pythonspeed.com/articles/docker-buildkit/)

</details>
