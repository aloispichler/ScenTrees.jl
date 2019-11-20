using Statistics
using LinearAlgebra
using PyPlot

mutable struct Lattice
    name::String
    state::Array{Array{Float64,2},1}
    probability::Array{Array{Float64,2},1}
    Lattice(name::String,state::Array{Array{Float64,2},1},probability::Array{Array{Float64,2},1}) = new(name,state,probability)
end

"""
	LatticeApproximation(states::Array{Int64,1},path::Function,nScenarios::Int64)

Returns an approximated lattice according to the samples from the `path` provided to. The function `path` generates one sample from a known distribution with length
equal to the length of states of the lattice.
"""

function LatticeApproximation(states::Array{Int64,1},path::Function,nScenarios::Int64)
    WassersteinDistance = 0.0
    rWasserstein = 2	
    lns = length(states)
    LatState = [zeros(states[j],1) for j = 1:lns]                    # States of the lattice at each time t
    BegPath = path()
    for t = 1:lns                                                   #initialize the states of the nodes of the lattice
        LatState[t] .= BegPath[t]
    end
    LatProb = vcat([zeros(states[1],1)],[zeros(states[j-1],states[j]) for j = 2:lns]) # Probabilities of the lattice at each time t
    #Z = Array{Float64}(undef,lns)                   # initialize a 1D vector to hold the states' values
    #Stochastic approximation step comes in here
    for n = 1:nScenarios
        Z = path()                                                                                                                            #draw a new sample Gaussian path
        idtm1 = 1
        dist = 0.0
        for t = 1:length(states)                                                                                                                  #walk along the gradient
            sumLat = sum(LatProb[t],dims = 2)
            sqStates = 1.3 * sqrt(n) / states[t]
            tmp = Int64[id for (id,ls) in enumerate(sumLat) if ls < sqStates]
            LatState[t][tmp] .= Z[t]                                      # corrective action to include lost nodes
            mindist,indx = findmin(vec(abs.(LatState[t] .- Z[t])))        # find the closest lattice entry
            dist = dist + mindist^2                                       # Euclidean distance for the paths
            LatProb[t][idtm1,indx] = LatProb[t][idtm1,indx] .+ 1.0        # increase the probability
            idtm1 = indx
            LatState[t][indx] = LatState[t][indx] - 2/ (n+nScenarios)^0.75*rWasserstein*mindist^(rWasserstein-1)*(LatState[t][indx] - Z[t])
        end
        dist = dist^(1/2)
        WassersteinDistance = (WassersteinDistance*(n-1) + dist^rWasserstein)/n
    end                                             
    LatProb = LatProb ./ nScenarios						                # scale the probabilities to 1.0
    return Lattice("Lattice Approximation of $states, \n distance=$(round(WassersteinDistance^(1/rWasserstein),digits = 4)/sqrt(nScenarios)) at $(nScenarios) scenarios",LatState,LatProb)
end

"""
	PlotLattice(lt::Lattice)

Returns a plot of a lattice. The arguments is only a lattice.
"""					
function PlotLattice(lt::Lattice,fig = 1)
    if !isempty(fig)
        figure(figsize=(10,6))
    end
    lts = subplot2grid((1,4),(0,0),colspan = 3)
    title("states")
    xlabel("stage,time")
    #ylabel("states")
    xticks(0:length(lt.state)-1)
    lts.spines["top"].set_visible(false)                                                         # remove the box at the top
    lts.spines["right"].set_visible(false)                                                       # remove the box at the right
    for t = 2:length(lt.state)
        for i=1:length(lt.state[t-1])
            for j=1:length(lt.state[t])
                lts.plot([t-2,t-1],[lt.state[t-1][i],lt.state[t][j]])
            end
        end
    end

    prs = subplot2grid((1,4), (0,3))
    title("probabilities")
    prs.spines["top"].set_visible(false)
    prs.spines["left"].set_visible(false)
    prs.spines["right"].set_visible(false)
# Use the states and probabilites at the last stage to plot the marginal distribution
    stts = lt.state[end]   
    n = length(stts)                                    # length of leaves of the lattice.
    h = 1.05*std(stts)/ (n^0.2) + 1e-3                  #Silverman rule of thumb
    lts.set_ylim(minimum(minimum.(lt.state)), maximum(maximum.(lt.state)))
    prs.set_ylim(minimum(minimum.(lt.state)), maximum(maximum.(lt.state)))
    proba = sum(lt.probability[end],dims=1)
    yticks(())                                          #remove the ticks on probability plot
    t = LinRange(minimum(stts)-h, maximum(stts)+h, 100) #100 points on probability plot
    density = zero(t)
    for (i, ti) in enumerate(t)
        for (j, xj) in enumerate(stts)
            tmp = (xj - ti) / h
            density[i] += proba[j]* 35/32 * max(1.0 -tmp^2, 0.0)^3 /h #triweight kernel
        end
    end
    plot(density, t)
    prs.fill_betweenx(t, 0 , density)
end
