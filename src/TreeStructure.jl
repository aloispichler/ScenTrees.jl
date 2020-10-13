<<<<<<< HEAD

using Distributions, Statistics, PyPlot, Random
rng = MersenneTwister(01012019);

#This defines the tree structure.
mutable struct Tree
    name::String                        # name of the tree
    parent::Vector{Int64}               # parents of nodes in the tree
    children::Vector{Vector{Int64}}     # successor nodes of each parent
    state::Matrix{Float64}              # states of nodes in the tree
    probability::Matrix{Float64}        # probability to go from one node to another

    """
    	child(parent::Vector{Int64})

    Returns a vector of successors of each of the parent nodes.
    """
    function child(parent::Vector{Int64})
        allchildren = Vector{Vector{Int64}}([])
        for node in unique(parent)
            push!(allchildren, [i for i = 1 : length(parent) if parent[i] == node])
=======
"""
This defines the tree structure.
A tree has a name, a list of parents, a list of states, list of probabilities, and a list of children.
Name - a string representing the name of the tree.
List of parents - shows the parent of each node in the tree.
List of states - contains the state of each node in the tree.
List of probabilities - shows the conditional probability of moving from one node to another.
List of children - contains the children of every parent node.
"""

using Distributions
using Statistics
using PyPlot

mutable struct Tree                                                                               #Tree structure
    name::String                                                                                       #name of the tree
    parent::Vector{Int64}                                                                    # parents of nodes in the tree
    children::Vector{Vector{Int64}}                                             # successor nodes of each parent
    state::Matrix{Float64}                                                                 # states of nodes in the tree
    probability::Matrix{Float64}                                                     #probability to go from one node to another
"""
The following function will create an array for the children of each of the parent nodes.
We need this array fo children for performance purposes in the stochastic approximation step.
So that instead of having it as a fucntion, we rather have it as an array so that we can only access the array
"""
    function Children(parent::Vector{Int64})
        allchildren = Vector{Vector{Int64}}([])
        for node in unique(parent)
            push!(allchildren,[i for i = 1:length(parent) if parent[i] == node])
>>>>>>> Deploy kirui93/ScenTrees.jl to github.com/kirui93/ScenTrees.jl.git:gh-pages
        end
        return allchildren
    end
    Tree(name::String,parent::Vector{Int64},
    children::Vector{Vector{Int64}},
<<<<<<< HEAD
    state::Matrix{Float64}, probability::Matrix{Float64})=new(name, parent, child(parent), state, probability)

    """
    	Tree(identifier::Int64)

    Returns some examples of predefined trees.
    - These are (0, 302, 303, 304, 305, 306, 307, 402, 404, 405).
    - You can call any of the above tree and plot to see the properties of the tree.
    """
=======
    state::Matrix{Float64},probability::Matrix{Float64})=new(name,parent,Children(parent),state,probability)
"""
The following are some examples of predefined trees
"""
>>>>>>> Deploy kirui93/ScenTrees.jl to github.com/kirui93/ScenTrees.jl.git:gh-pages
    function Tree(identifier::Int64)
        self= new()
        if identifier==0
            self.name = "Empty Tree"
<<<<<<< HEAD
            self.parent = zeros(Int64 , 0)
            self.children = child(self.parent)
            self.state = zeros(Float64, 0)'
            self.probability = ones(Float64, 0)'
        elseif identifier == 302
            self.name = "Tree 1x2x2"
            self.parent =[0,1,1,2,2,3,3]
            self.children = child(self.parent)
=======
            self.parent = zeros(Int64,0)
            self.children = Children(self.parent)
            self.state = zeros(Float64,0)'
            self.probability = ones(Float64,0)'
        elseif identifier == 302
            self.name = "Tree 1x2x2"
            self.parent =[0,1,1,2,2,3,3]
            self.children = Children(self.parent)
>>>>>>> Deploy kirui93/ScenTrees.jl to github.com/kirui93/ScenTrees.jl.git:gh-pages
            self.state = [2.0 2.1 1.9 4.0 1.0 3.0]'
            self.probability = [1.0 0.5 0.5 0.5 0.5 0.5 0.5]'
        elseif identifier == 303
            self.name = "Tree 1x1x4"
            self.parent = [0,1,2,2,2,2]
<<<<<<< HEAD
            self.children = child(self.parent)
=======
            self.children = Children(self.parent)
>>>>>>> Deploy kirui93/ScenTrees.jl to github.com/kirui93/ScenTrees.jl.git:gh-pages
            self.state = [3.0 3.0 6.0 4.0 2.0 0.0]'
            self.probability = [1.0 1.0 0.25 0.25 0.25 0.25]'
        elseif identifier == 304
            self.name = "Tree 1x4x1x1"
            self.parent = [0,1,2,0,4,5,0,7,8,0,10,11]
<<<<<<< HEAD
            self.children = child(self.parent)
=======
            self.children = Children(self.parent)
>>>>>>> Deploy kirui93/ScenTrees.jl to github.com/kirui93/ScenTrees.jl.git:gh-pages
            self.state = [0.1 2.1 3.0 0.1 1.9 1.0 0.0 -2.9 -1.0 -0.1 -3.1 -4.0]'
            self.probability = [0.14 1.0 1.0 0.06 1.0 1.0 0.48 1.0 1.0 0.32 1.0 1.0]'
        elseif identifier == 305
            self.name = "Tree 1x1x4"
            self.parent = [0,1,2,2,2,2]
<<<<<<< HEAD
            self.children = child(self.parent)
=======
            self.children = Children(self.parent)
>>>>>>> Deploy kirui93/ScenTrees.jl to github.com/kirui93/ScenTrees.jl.git:gh-pages
            self.state = [0.0 10.0 28.0 22.0 21.0 20.0]'
            self.probability = [1.0 1.0 0.25 0.25 0.25 0.25]'
        elseif identifier == 306
            self.name = "Tree 1x2x2"
            self.parent = [0,1,1,2,2,3,3]
<<<<<<< HEAD
            self.children = child(self.parent)
=======
            self.children = Children(self.parent)
>>>>>>> Deploy kirui93/ScenTrees.jl to github.com/kirui93/ScenTrees.jl.git:gh-pages
            self.state = [0.0 10.0 10.0 28.0 22.0 21.0 20.0]'
            self.probability = [1.0 0.5 0.5 0.5 0.5 0.5 0.5]'
        elseif identifier == 307
            self.name = "Tree 1x4x1"
            self.parent = [0,1,1,1,1,2,3,4,5]
<<<<<<< HEAD
            self.children = child(self.parent)
=======
            self.children = Children(self.parent)
>>>>>>> Deploy kirui93/ScenTrees.jl to github.com/kirui93/ScenTrees.jl.git:gh-pages
            self.state = [0.0 10.0 10.0 10.0 10.0 28.0 22.0 21.0 20.0]'
            self.probability = [1.0 0.25 0.25 0.25 0.25 1.0 1.0 1.0 1.0]'
        elseif identifier == 401
            self.name = "Tree 1x1x2x2"
            self.parent = [0,1,2,2,3,3,4,4]
<<<<<<< HEAD
            self.children = child(self.parent)
=======
            self.children = Children(self.parent)
>>>>>>> Deploy kirui93/ScenTrees.jl to github.com/kirui93/ScenTrees.jl.git:gh-pages
            self.state = [10.0 10.0 8.0 12.0 9.0 6.0 10.0 13.0]'
            self.probability = [1.0 1.0 0.66 0.34 0.24 0.76 0.46 0.54]'
        elseif identifier == 402
            self.name = "Tree 1x2x2x2"
            self.parent = [0,1,1,2,2,3,3,4,4,5,5,6,6,7,7]
<<<<<<< HEAD
            self.children = child(self.parent)
            self.state = [10.0 12.0 8.0 15.0 11.0 9.0 5.0 18.0 16.0 13.0 11.0 10.0 7.0 6.0 3.0]'
            self.probability = [1.0 0.8 0.7 0.3 0.2 0.8 0.4 0.6 0.2 0.5 0.5 0.4 0.6 0.7 0.3]'
        elseif identifier == 4022
            self.name = "Tree 1x2x2x2"
            self.parent = [0,1,1,2,2,3,3,4,4,5,5,6,6,7,7]
            self.children = child(self.parent)
            self.state = [10.0 0.0; 12.0 1.0; 8.0 -1.0; 15.0 2.0; 11.0 1.0; 9.0 -0.5; 5.0 -2.0; 18.0 3.0; 16.0 1.8; 13.0 0.9; 11.0 0.2; 10.0 0.0; 7.0 -1.2; 6.0 -2.0; 3.0 -3.2]
            self.probability = [1.0 0.8 0.7 0.3 0.2 0.8 0.4 0.6 0.2 0.5 0.5 0.4 0.6 0.7 0.3]'
        elseif identifier ==404
            self.name = "Tree 1x2x2x2"
            self.parent = [0,1,1,2,2,3,3,4,4,5,5,6,6,7,7]
            self.children = child(self.parent)
=======
            self.children = Children(self.parent)
            #self.state= [10.0 11.0 8.0 12.0 9.0 6.0 10.0 13.0 10.01 8.01 12.01 9.01 4.0 11.0 12.99]'
            self.state = [10.0 12.0 8.0 15.0 11.0 9.0 5.0 18.0 16.0 13.0 11.0 10.0 7.0 6.0 3.0]'
            self.probability = [1.0 0.8 0.7 0.3 0.2 0.8 0.4 0.6 0.2 0.5 0.5 0.4 0.6 0.7 0.3]'
        elseif identifier ==404
            self.name = "Tree 1x2x2x2"
            self.parent = [0,1,1,2,2,3,3,4,4,5,5,6,6,7,7]
            self.children = Children(self.parent)
>>>>>>> Deploy kirui93/ScenTrees.jl to github.com/kirui93/ScenTrees.jl.git:gh-pages
            self.state = (0.2+0.6744).*[0.0 1.0 -1.0 2.0 0.1 0.0 -2.0 3.0 1.1 0.9 -1.1 1.2 -1.2 -0.8 -3.2]'
            self.probability = [1.0 0.3 0.7 0.2 0.8 0.1 0.9 0.5 0.5 0.6 0.4 0.4 0.6 0.3 0.7]'
        elseif identifier == 405
            self.name = "Tree 5"
            self.parent = [0,1,2,3,3,2,6,6,6,1,10,10,11,12,12,12]
<<<<<<< HEAD
            self.children = child(self.parent)
=======
            self.children = Children(self.parent)
>>>>>>> Deploy kirui93/ScenTrees.jl to github.com/kirui93/ScenTrees.jl.git:gh-pages
            self.state = [7.0 12.0 14.0 15.0 13.0 9.0 11.0 10.0 8.0 4.0 6.0 2.0 5.0 0.0 1.0 3.0]'
            self.probability = [1.0 0.7 0.4 0.7 0.3 0.6 0.2 0.3 0.5 0.3 0.2 0.8 1.0 0.3 0.5 0.2]'
        end
        return self
    end
<<<<<<< HEAD

    """
    	Tree(bstructure::Vector{Int64}, dimension=Int64[])

    Returns a tree according to the specified branching vector and the dimension.

    Args:
    - bstructure - the branching structure of the scenario tree.
    - dimension - describes how many values (states) in each node.

    The branching vector must start with 1 for the root node.
    """
    function Tree(bstructure::Vector{Int64}, dimension=Int64[])
=======
"""
Instead of having a predefined tree, we can just provide the topology of the tree and then using it, we produce the tree.
Given the bushiness of the tree, the following function produces the tree.
For example, bushiness = 1x2x3x3 means that we have 18 leaves at the end and at stage 1, we have 1 node, 
stage 2 has 2x1 nodes, stage 3 has 3x2x1 nodes and stage 4 has 3x3x2x1 nodes.
We generate normal random  variables for the states of the nodes of the tree.
"""
    function Tree(spec::Vector{Int64}, dimension=Int64[])
>>>>>>> Deploy kirui93/ScenTrees.jl to github.com/kirui93/ScenTrees.jl.git:gh-pages
        self = new()
        if isempty(dimension)
            dimension = 1
        end
<<<<<<< HEAD
        leaves = bstructure
        for stage = 1 : length(bstructure)
            if stage == 1
                leaves = 1
                self.name = "Tree $(bstructure[1])"
                self.parent = zeros(Int64, bstructure[1])
                self.children = child(self.parent)
                self.state = randn(rng, bstructure[1], dimension)
                self.probability = ones(bstructure[1], 1)
            else
                leaves = leaves * bstructure[stage-1]
                newleaves = vec(ones(Int64, bstructure[stage]) .* transpose(length(self.parent) .+ (1 .- leaves : 0)))
                self.parent =  vcat(self.parent, newleaves)
                self.children = child(self.parent)
                self.state = vcat(self.state, randn(length(newleaves), dimension))
                self.name = "$(self.name)x$(bstructure[stage])"
                tmp = rand(rng, Uniform(0.3, 1.0), bstructure[stage], leaves)
                tmp = tmp ./ (transpose(ones(1, bstructure[stage])) .* sum(tmp, dims = 1))
                self.probability = vcat(self.probability, vec(tmp))
=======
        leaves = spec
        for stage = 1 : length(spec)
            if stage == 1
                leaves = 1
                self.name = "Tree $(spec[1])"
                self.parent = zeros(Int64,spec[1])
                self.children = Children(self.parent)
                self.state = randn(spec[1],dimension)
                self.probability = ones(spec[1],1)
            else
                leaves = leaves * spec[stage-1]
                newleaves = vec(ones(Int64,spec[stage]) .* transpose(length(self.parent) .+ (1 .- leaves:0)))
                self.parent =  vcat(self.parent, newleaves)
                self.children = Children(self.parent)
                self.state = vcat(self.state,randn(length(newleaves),dimension))
                self.name = "$(self.name)x$(spec[stage])"
                tmp = rand(Uniform(0.3,1.0), spec[stage], leaves)
                tmp = tmp ./ (transpose(ones(1,spec[stage])) .* sum(tmp,dims=1))
                self.probability = vcat(self.probability,vec(tmp))
>>>>>>> Deploy kirui93/ScenTrees.jl to github.com/kirui93/ScenTrees.jl.git:gh-pages
            end
        end
        return self
    end
end

"""
<<<<<<< HEAD
	stage(trr::Tree, node=Int64[])

Returns the stage of each node in the tree.

Args:
- trr - an instance of a Tree.
- node - the number of node in the scenario tree you want to know its stage.
"""
function stage(trr::Tree, node = Int64[])
=======
The stage function returns the stage of each node in the tree
"""

function stage(trr::Tree,node = Int64[])
>>>>>>> Deploy kirui93/ScenTrees.jl to github.com/kirui93/ScenTrees.jl.git:gh-pages
    if isempty(node)
        node = 1 : length(trr.parent)
    elseif isa(node, Int64)
        node = Int64[node]
    end
    #stage = zeros(length(collect(node))) #you can also use this
    stage = zero(node)
<<<<<<< HEAD
    for i = 1 : length(node)
=======
    for i = 1:length(node)
>>>>>>> Deploy kirui93/ScenTrees.jl to github.com/kirui93/ScenTrees.jl.git:gh-pages
        pred = node[i]
        while pred > 0 && trr.parent[pred] > 0
            pred = trr.parent[pred]
            stage[i] += 1
        end
    end
    return stage
end

"""
<<<<<<< HEAD
	height(trr::Tree)

Returns the height of the tree which is just the maximum number of the stages of each node.

Args:
- trr - an instance of a Tree.
=======
The following function returns the height of the tree
which is just the maximum number of the stages of each node
>>>>>>> Deploy kirui93/ScenTrees.jl to github.com/kirui93/ScenTrees.jl.git:gh-pages
"""
function height(trr::Tree)
    return maximum(stage(trr))
end

"""
<<<<<<< HEAD
	leaves(trr::Tree,node=Int64[])

Returns the leaf nodes, their indexes and the conditional probabilities.

Args:
- trr - an instance of a Tree.
- node - a node in the tree you want to its children.
"""
function leaves(trr::Tree, node = Int64[])
    nodes = 1 : length(trr.parent)
    leaves = setdiff(nodes, trr.parent)
    #leaves are all nodes which are not parents
    #setdiff(A,B) finds all the elements that belongs to A and are not in B
    omegas = 1 : length(leaves)
=======
The following function produces the terminal nodes of the tree. 
The terminal nodes or the leaves are all those nodes which doesn't have children nodes. 
They are the nodes which are not parents.
The function also returns the indexes (omegas) of these nodes as well as the conditional probabilities (prob) of reaching of the leaves from the root node
"""
function leaves(trr::Tree, node = Int64[])
    nodes = 1:length(trr.parent)
    leaves = setdiff(nodes,trr.parent)
    #leaves are all nodes which are not parents
    #setdiff(A,B) finds all the elements that belongs to A and are not in B
    omegas = 1:length(leaves)
>>>>>>> Deploy kirui93/ScenTrees.jl to github.com/kirui93/ScenTrees.jl.git:gh-pages
    if !isempty(node) && isa(node,Int64)
        node = Int64[node]
    end
    if !isempty(node) && (0 ∉ node)
        omegas = Set{Int64}()
        nodes = leaves
        while any(j !=0 for j ∈ nodes)
<<<<<<< HEAD
            omegas = union(omegas, (ind for (ind, j) ∈ enumerate(nodes) if j ∈ node))
            nodes = Int64[trr.parent[max(0 , j)] for j ∈ nodes]
=======
            omegas = union(omegas,(ind for (ind,j) ∈ enumerate(nodes) if j ∈ node))
            nodes = Int64[trr.parent[max(0,j)] for j ∈ nodes]
>>>>>>> Deploy kirui93/ScenTrees.jl to github.com/kirui93/ScenTrees.jl.git:gh-pages
        end
        omegas = collect(omegas)
    end
    leaves = Int64[leaves[j] for j ∈ omegas]
<<<<<<< HEAD
    prob = ones(Float64 , length(leaves))
    nodes = leaves
    while any(j !=0 for j ∈ nodes)
        prob = prob .* trr.probability[[j for j in nodes]]
        nodes = Int64[trr.parent[max(0 , j)] for j ∈ nodes]
    end
    return leaves, omegas, prob
end

"""
	nodes(trr::Tree,t=Int64[])

Returns the nodes in the tree, generally the range of the nodes in the tree.

Args:
- trr - an instance of a Tree.
- t  - stage in the tree.

Example : nodes(trr,2) - gives all nodes at stage 2.
=======
    prob = ones(Float64,length(leaves))
    nodes = leaves
    while any(j !=0 for j ∈ nodes)
        prob = prob .* trr.probability[[j for j in nodes]]
        nodes = Int64[trr.parent[max(0,j)] for j ∈ nodes]
    end
    return leaves,omegas, prob
end

"""
This function gives the nodes in the tree, generally the range of the nodes in the tree
>>>>>>> Deploy kirui93/ScenTrees.jl to github.com/kirui93/ScenTrees.jl.git:gh-pages
"""
function nodes(trr::Tree, t = Int64[])
    nodes = 1 : length(trr.parent)
    if isempty(t) #if stage t is not given, return all nodes of the tree
        return nodes
    else # else return nodes at the given stage t
        stg = stage(trr)
        return Int64[i for i in nodes if stg[i] == t]
    end
end
<<<<<<< HEAD

"""
	root(trr::Tree,nodes=Int64[])
Returns the root of the tree if the node is not specified.

Args:
- trr - an instance of Tree.
- nodes - node in the tree you want to know the sequence from the root.

If `nodes` is not specified, it returns the root of the tree.

If `nodes` is specified, it returns a sequence of nodes from the root to the specified node.
"""
function root(trr::Tree, nodes = Int64[])
    if isempty(nodes)
        nodes = trr.children[1]
    elseif isa(nodes , Int64)
=======
"""
The root function provides the path from the starting node of the tree to the node indicated.
If the node is not indicated, it will return the starting node (which we call the root node).
Else, it will give a sequence of nodes from the root to the indicated node.
"""
function root(trr::Tree,nodes = Int64[])
    if isempty(nodes)
        nodes = trr.children[1]
    elseif isa(nodes,Int64)
>>>>>>> Deploy kirui93/ScenTrees.jl to github.com/kirui93/ScenTrees.jl.git:gh-pages
        nodes = Int64[nodes]
    end
    root = 1 : length(trr.parent)
    for i in nodes
        iroot = Vector{Int64}([])
        tmp = i
        while tmp > 0
<<<<<<< HEAD
            push!(iroot , tmp)
=======
            push!(iroot,tmp)
>>>>>>> Deploy kirui93/ScenTrees.jl to github.com/kirui93/ScenTrees.jl.git:gh-pages
            tmp = trr.parent[tmp]
        end
        root = Int64[i for i in reverse(iroot) if i in root]
    end
    return root
end

"""
<<<<<<< HEAD
	part_tree(trr::Tree)

Returns a vector of trees in d-dimension.

Args:
- trr - an instance of Tree.
"""
function part_tree(trr::Tree)
    trees = Tree[]
    for col = 1:size(trr.state , 2)
        subtree = Tree("Tree of state $col", trr.parent, trr.children, hcat(trr.state[:,col]), trr.probability)
=======
Sometimes, we are dealing with 2D-state trees and at the end of the stochastic approximation step, we get an aproximated tree with
states in higher dimension. So we can partition the tree into different trees with the same parents, children and probabilities but
different states. The following function helps us to do so.
"""

function partTree(trr::Tree)
    trees = Tree[]
    for col = 1:size(trr.state,2)
        subtree = Tree("Tree of state $col",trr.parent,trr.children,hcat(trr.state[:,col]),trr.probability)
>>>>>>> Deploy kirui93/ScenTrees.jl to github.com/kirui93/ScenTrees.jl.git:gh-pages
        push!(trees,subtree)
    end
    return trees
end

"""
<<<<<<< HEAD
	build_probabilities!(trr::Tree,probabilities::Array{Float64,2})

Returns the probabilities of the nodes without probabilities
if the array of probabilities is less than the length of parents
in the stochastic approximation procedure.
"""
function build_probabilities!(trr::Tree, probabilities::Array{Float64,2})
    leaf, omegas, probaLeaf = leaves(trr)
=======
In the stochastic approximation step, we only iterate over the probabilities of the leaves. The length of the array of probabilities we get at the 
end is smaller than the length of the parents. So we have to build the probabilites for the remaining nodes.
"""
function buildProb!(trr::Tree,probabilities::Array{Float64,2})
    leaf,omegas,probaLeaf = leaves(trr)
>>>>>>> Deploy kirui93/ScenTrees.jl to github.com/kirui93/ScenTrees.jl.git:gh-pages
    if length(probabilities) == length(nodes(trr))
        trr.probability .= probabilities
    else
        probabilities .= max.(0.0,probabilities)
<<<<<<< HEAD
        j = leaf; i = trr.parent[j]; j .= j[i .> 0]; i .= i[i .> 0]
        trr.probability .= zeros(length(trr.state[:,1]), 1)
=======
        j = leaf;i = trr.parent[j];j .= j[i.> 0];i .= i[i .> 0]
        trr.probability .= zeros(length(trr.state[:,1]),1)
>>>>>>> Deploy kirui93/ScenTrees.jl to github.com/kirui93/ScenTrees.jl.git:gh-pages
        trr.probability[j] = probabilities
        while !isempty(i)
            for k = 1:length(i)
                trr.probability[i[k]] = trr.probability[i[k]] + trr.probability[j[k]]
            end
            trr.probability[j] .= trr.probability[j] ./ trr.probability[i]
            trr.probability[isnan.(trr.probability)] .= 0.0
            j = unique(i); i = trr.parent[j]; j = j[i .> 0] ; i = i[i .> 0]
        end
    end
    return trr.probability
end

<<<<<<< HEAD
"""
	tree_plot(trr::Tree,fig=1)

Returns the plot of the input tree annotated with density of
probabilities of reaching the leaf nodes in the tree.
Args:
- trr - A scenario tree.
- fig - Specifies the size of the image you want to be returned, default = 1.

Using the matplotlib version, fig usually takes a tuple. For example, fig = (8,6) produces an image with length = 8 and width = 6.
The user is not obliged to give this specifications as already there is a default value.
"""
function tree_plot(trr::Tree, fig= 1)
=======
function treeplot(trr::Tree, fig= 1)
>>>>>>> Deploy kirui93/ScenTrees.jl to github.com/kirui93/ScenTrees.jl.git:gh-pages
    if !isempty(fig)
        figure(fig)
    end
    #suptitle(trr.name, fontsize = 14)
    trs = subplot2grid((1,4), (0,0), colspan=3)
    title("states")
    stg = stage(trr)
<<<<<<< HEAD
    xticks(1 : height(trr) + 1)         # Set the ticks on the x-axis
    xlabel("stage,time",fontsize=12)
    trs.spines["top"].set_visible(false)         # remove the line of the box at the top
    trs.spines["right"].set_visible(false)		 # remove the line of the box at the right
    for i = 1 : length(trr.parent)
        if stg[i] > 0
            trs.plot([stg[i],stg[i]+1],[trr.state[trr.parent[i]],trr.state[i]],linewidth=1.5)
=======
    xticks(range(1, stop = height(trr) + 1)) #Set the ticks on the x-axis
    xlabel("stage, time")
    trs.spines["top"].set_visible(false) #remove the box
    trs.spines["right"].set_visible(false)
    for i in range(1,stop = length(trr.parent))
        if stg[i] > 0
            trs.plot([stg[i]-1,stg[i]],[trr.state[trr.parent[i]],trr.state[i]])
>>>>>>> Deploy kirui93/ScenTrees.jl to github.com/kirui93/ScenTrees.jl.git:gh-pages
        end
    end
    prs = subplot2grid((1,4), (0,3))
    title("probabilities")
    prs.spines["top"].set_visible(false)
    prs.spines["left"].set_visible(false)
    prs.spines["right"].set_visible(false)

    (Yi,_,probYi) = leaves(trr)
    Yi = [trr.state[i] for i in Yi]
    nY = length(Yi)
<<<<<<< HEAD
    h = 1.05 * std(Yi) / (nY^0.2) + 1e-3         #Silverman rule of thumb
    #trs.set_ylim(minimum(Yi)-h, maximum(Yi)+h)
    #prs.set_ylim(minimum(Yi)-h, maximum(Yi)+h)
    yticks(())                                                                                                             #remove the ticks on probability plot
    t = LinRange(minimum(Yi)-h, maximum(Yi)+h, 100)  #100 points on probability plot
=======
    h = 1.05*std(Yi)/ (nY^0.2) + 1e-3 #Silverman rule of thumb
    trs.set_ylim(minimum(Yi)-h, maximum(Yi)+h)
    prs.set_ylim(minimum(Yi)-h, maximum(Yi)+h)
    yticks(()) #remove the ticks on probability plot
    t = LinRange(minimum(Yi)-h, maximum(Yi)+h, 100) #100 points on probability plot
    #density = zeros(length(collect(t)))
>>>>>>> Deploy kirui93/ScenTrees.jl to github.com/kirui93/ScenTrees.jl.git:gh-pages
    density = zero(t)
    for (i, ti) in enumerate(t)
        for (j, xj) in enumerate(Yi)
            tmp = (xj - ti) / h
            density[i] += probYi[j]* 35/32 * max(1.0 -tmp^2, 0.0)^3 /h #triweight kernel
        end
    end
    plot(density, t)
    prs.fill_betweenx(t, 0 , density)
end

<<<<<<< HEAD
"""
	plot_hd(newtree::Tree)

Returns a plots of trees in higher dimensions.
"""
function plot_hd(newtree::Tree)
    fig = figure(figsize = (10,6))
    stg = stage(newtree)
    for rw = 1:size(newtree.state,2)
      ax = subplot(1,size(newtree.state,2),rw)
      ax.spines["top"].set_visible(false)                                                  #remove the box top
      ax.spines["right"].set_visible(false)                                               #remove the box right
      for i in range(1,stop = length(newtree.parent))
          if stg[i] > 0
              ax.plot([stg[i], stg[i]+1],[newtree.state[:,rw][newtree.parent[i]], newtree.state[:,rw][i]])
=======
function plotD(newtree::Tree)
    fig = figure(1)
    stg = stage(newtree)
    for rw = 1:size(newtree.state,2)
      ax = subplot(size(newtree.state,2),1,rw)
      ax.spines["top"].set_visible(false) #remove the box top
      ax.spines["right"].set_visible(false) #remove the box right
      for i in range(1,stop = length(newtree.parent))
          if stg[i] > 0
              ax.plot([stg[i]-1,stg[i]],[newtree.state[:,rw][newtree.parent[i]],newtree.state[:,rw][i]])
>>>>>>> Deploy kirui93/ScenTrees.jl to github.com/kirui93/ScenTrees.jl.git:gh-pages
          end
          xlabel("stage, time")
          ylabel("states")
      end
<<<<<<< HEAD
      xticks(unique(stg))
    end
end
=======
      #title("Stochastic Approximation Tree")
      xticks(unique(stg))
      #grid(true)
    end
end

#Documentation for the differernt functions in the script
                                                                        
"""
	Tree()
Returns a tree with the name,parents of nodes, children of the parents, states of the nodes and probabilities of transition.
Note that it takes a vector of integers
Fox example, Tree([1,2,3,4])
                                                                        
"""

"""
	stage()
Returns the stage of each node in the tree.
                                                                        
"""

"""
	height()
Returns the height of the tree
                                                                        
"""

"""
	leaves()
Returns the leaves of the tree and their unconditional probabilities
                                                                        
"""

"""
	nodes()
Returns the nodes of the tree
                                                                        
"""

"""
	root()
Returns the root (parent of all nodes) of the tree.
It also returns a sequence of nodes to reach a specific node.
For example;
root(d,5)
Returns a sequence of nodes to reach node 5 in tree d
                                                                        
"""
                                                                        
>>>>>>> Deploy kirui93/ScenTrees.jl to github.com/kirui93/ScenTrees.jl.git:gh-pages
