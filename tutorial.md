# How to use Julia on TARDIS

In this tutorial, ...

# Set up Cluster
First, you have to connect to the VPN of the MPI:

```console
sudo openconnect vpn.mpib-berlin.mpg.de
```

And then in a new console window to tardis:

```console
ssh xxx@tardis.mpib-berlin.mpg.de
```

As long as you are connected via VPN, you find the tardis documentation [here](https://tardis.mpib-berlin.mpg.de/).

We now need to set up a remote directory. This depends on your os and file manager, but you should find a way to add a remote directory over ssh, and get a dialogue that looks something like this:

![](figures/tardis_network_folder.png)

# Some slurm basics

Slurm (Simple Linus Utility for Resource Management) is a so-called "resource manager". Basically, you have to tell slurm how many ressources you want to use, and slurm will allocate those resources on the cluster for you. This way, you don't have to think about what specific part of the cluster you want to use (and you don't need extensive knowledge of the cluster architecture). Slurm is also a "job scheduler", meaning if many persons are using the cluster at the same time, slurm schedules the tasks and ensures smooth and fair scheduling of the work.[^1]

We can ask for
- Nodes
    - Sockets
        - Cores
    - GPUs
    - Memory
- Time

From the tardis documentation, we find that we have

- 832 Intel® Xeon® CPU E5-2670 CPU **cores**(no HT) inside 48 Dell m6x0 blade **servers**  
- 7 dedicated **nodes** housing 24 Nvidia **GPUs**  
- 10.6TB total amount of **memory**
- 32TB of attached NFS storage for software
- 747 TB of attached BeeGFS storage

available.

> *Show the tardis docs*

When we log in to the cluster, we are on the so-called "login node", a node that simply exists for the purpose to do "housekeeping" on the cluster. **NEVER** do computations on the login node, as this will make life worse for all other cluster users.

Instead, we submit a slurm job. If we want an interactive job to do some quick testing, we can to something like

```console
srun -p test --pty /bin/bash
```

which gives us a terminal on one of the nodes of the *test* queue.

To submit a real job, we first need to decide how many resources we need:

- `--mem=`*MB*: memory per node



#SBATCH --partition test
#SBATCH --time 0:10:0
#SBATCH --nodes 1
#SBATCH --ntasks-per-node 2
#SBATCH --cpus-per-task 2
#SBATCH --mem 8GB
#SBATCH --workdir /home/mpib/ernst/SEFA/cluster

There are many more advanced options available (for example `--cores-per-socket`). Also see this overview on [srun flags](https://slurm.schedmd.com/srun.html).

Basic slurm commands for Job allocation:

- `sbatch`: Submit for later execution
- `salloc`: interactive mode (shell)
- `srun`: launch job (now)
- `sattach`: I/O???

We typically use `sbatch` to submit our jobs, and `salloc`

# Get Julia/Singularity up and running

Some software is preinstalled on the cluster. However, we may want to be able to use software that has not been installed by the admin. For this purpose, we can use Singularity. For using Julia, Aaron has built a docker container and hosts it on GitLab:

```console
singularity pull docker://registry.git.mpib-berlin.mpg.de/peikert/sem-jl-docker:latest
```

To be able to install new julia packages in the container, we need to convert the container to a writeable one (called "sandbox"):

```console
singularity build --sandbox my_container.simg sem-jl-docker_latest.sif
```



# Container Folder

[^1]: This is partly taken from [this introductory series about slurm on youtube](https://www.youtube.com/watch?v=NH_Fb7X6Db0).