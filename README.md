### BBGD Toy Model - Deployment package

#### Steps to install Julia in your machine

1. 

#### Steps to run this package from the command line on macOS

1. Open Terminal.
2. Type `julia` to launch Julia REPL from the Terminal. 
    - Note: If `julia` is not in the path, type: `export PATH=$PATH:/Applications/Julia-x.x.app/Contents/Resources/julia/bin`, replacing x.x with the number of your Julia version.
    - Type `julia` again. You should see Julia REPL initializing (you will notice this because the Julia logo should appear, and the next command will be preceded by julia>).

```console
mnavarrosudy@MacBook-Pro ~ % julia
zsh: command not found: julia
mnavarrosudy@MacBook-Pro ~ % export PATH=$PATH:/Applications/Julia-1.9.app/Contents/Resources/julia/bin
mnavarrosudy@MacBook-Pro ~ % julia
```

3. Type `pwd()` to print the current working directory.
4. Find the full pathname on your machine for the directory `~/deployment_package/code`. For example, on my machine, the full `"path"` to that directory is `"/Users/mnavarrosudy/Desktop/deployment_package/code"`.
5. Set the working directory as the folder where the scripts are. To do this, type: `cd("path")` where `"path"` is the directory you identified in step 4.
    - Note: That is, following with my example, I type `cd("/Users/mnavarrosudy/Desktop/deployment_package/code")`.

```console
julia> cd("/Users/mnavarrosudy/Desktop/deployment_package/code")
```

6. The main script in `~/deployment_package/code` is `run_model.jl`. We need to load that script to make its functions available for us. To do this, type: `include("run_model.jl")`. 
   - Note: You should see the message *"run_model (generic function with 1 method)"*. This is the function we will use to run the experiments.

```console
julia> include("run_model.jl")
run_model (generic function with 1 method)
```

7. The function `run_model(experiment_num)` receives one input, `experiment_num`, which indicates the ID of the experiment you want to run. 
    - Please consult the file `~/deployment_package/data/experiments.txt` to see the experiments set by default. 
    - The ID of the experiments is the first column in that file. The rest of the columns represent the values of the parameters. 
8. To run the experiment `X`, type: `run_model(X)` (where `X` is an integer corresponding to the ID of the experiment). The results are in `~/deployment_package/results/gmm_values.txt`.

```console
julia> run_model(15)
```