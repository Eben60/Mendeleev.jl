using Dates

m = true
p = false
t0 = time()
if m #p
    using Mendeleev
else
    using PeriodicTable
end
Δt = time()-t0
@show Δt
