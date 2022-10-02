module IR
using Mendeleev, Test

struct IonicRadius
    atomic_number::Int64
    charge::Int64
    econf::String
    coordination::String
    spin::String
    crystal_radius::Float64
    ionic_radius::Float64
    origin::String
    most_reliable::Int64
end


function Base.show(io::IO, ir::IonicRadius)
    elem = ELEMENTS_M[ir.atomic_number].symbol
    charge = ir.charge
    scharge = charge > 0 ? "+$charge" : "$charge"
    show("$elem $scharge $(ir.econf) $(ir.coordination) $(ir.spin): cryst. rad = $(ir.crystal_radius), ion. rad = $(ir.ionic_radius)")
end


function Base.isless(ir1::IonicRadius, ir2::IonicRadius)
    ir1.atomic_number != ir2.atomic_number && throw(DomainError("cannot compare IonicRadius for different elements"))
    return (ir1.charge, ir1.econf, ir1.coordination, ir1.spin) < (ir2.charge, ir2.econf, ir2.coordination, ir2.spin)
end

# struct IonicRadii; end;





########

# tests

ird26 = [
(26, 2, "3d6", "IV", "HS", 77.0, 63.0, "", 0),
(26, 2, "3d6", "IVSQ", "HS", 78.0, 64.0, "", 0),
(26, 2, "3d6", "VI", "LS", 75.0, 61.0, "estimated, ", 0),
(26, 2, "3d6", "VI", "HS", 92.0, 78.0, "from r^3 vs V plots, ", 1),
(26, 2, "3d6", "VIII", "HS", 106.0, 92.0, "calculated, ", 0),
(26, 3, "3d5", "IV", "HS", 63.0, 49.0, "", 1),
(26, 3, "3d5", "V", "", 72.0, 57.99999999999999, "", 0),
(26, 3, "3d5", "VI", "LS", 69.0, 55.00000000000001, "from r^3 vs V plots, ", 0),
(26, 3, "3d5", "VI", "HS", 78.5, 64.5, "from r^3 vs V plots, ", 1),
(26, 3, "3d5", "VIII", "HS", 92.0, 78.0, "", 0),
(26, 4, "3d4", "VI", "", 72.5, 58.5, "from r^3 vs V plots, ", 0),
(26, 6, "3d2", "IV", "", 39.0, 25.0, "from r^3 vs V plots, ", 0),
]

ird261 = ird26[1]

fe1 = IonicRadius(ird261...)


end
