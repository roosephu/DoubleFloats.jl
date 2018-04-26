
zero_accurate = Double{Float64, Accuracy}(0.0)
zero_performant = Double{Float64, Performance}(0.0)
one_accurate = Double{Float64, Accuracy}(1.0)
one_performant = Double{Float64, Performance}(1.0)

pi_accurate   = Double{Float64, Accuracy}(pi)
pi_performant = Double{Float64, Performance}(pi)
phi_accurate   = Double{Float64, Accuracy}(phi)
phi_performant = Double{Float64, Performance}(phi)

@test pi_accurate   == Double(pi)
@test pi_performant == FastDouble(pi)

@test abs(inv(inv(pi_accurate)) - pi_accurate) <= eps(LO(pi_accurate))
@test abs(inv(inv(pi_performant)) - pi_performant) <= eps(LO(pi_performant))
@test abs(phi_accurate - (phi_accurate*phi_accurate - 1.0)) <= eps(LO(phi_accurate))

a = Base.TwicePrecision(3.0) / Base.TwicePrecision(7.0)
b = Double{Float64, Accuracy}(3.0) / Double{Float64, Accuracy}(7.0)
c = Base.TwicePrecision(17.0) / Base.TwicePrecision(5.0)
d = Double{Float64, Accuracy}(17.0) / Double{Float64, Accuracy}(5.0)

@test a.hi == b.hi
@test a.lo == b.lo
@test (a+c).hi == (b+d).hi
@test (a+c).lo == (b+d).lo
@test (a-c).hi == (b-d).hi
@test abs((a-c).lo - (b-d).lo) <= eps((a-c).lo)
@test (a*c).hi == (b*d).hi
@test (a*c).lo == (b*d).lo
@test (a/c).hi == (b/d).hi
@test (a/c).lo == (b/d).lo


@test zero(Double{Float64}) == Double(0.0, 0.0)
@test one(Double{Float64}) == Double(1.0, 0.0)
@test zero(Double(0.0, 0.0)) == Double(0.0, 0.0)
@test one(Double(0.0, 0.0)) == Double(1.0, 0.0)

@test round(Double(123456.0, 1.0e-17), RoundUp) == Double(123457.0, 0.0)
@test round(Double(123456.0, -1.0e-17), RoundUp) == Double(123456.0, 0.0)
@test round(Double(123456.0, -1.0e-17), RoundDown) == Double(123455.0, 0.0)

@test typemax(Double) == Double(typemax(Float64))
@test realmin(Double) == Double(realmin(Float64))

@test isnan(FastDouble(Inf) + FastDouble(-Inf))
@test isinf(FastDouble(Inf) + FastDouble(Inf))
@test isnan(Double(NaN) - 1)

@test typeof(rand(Double)) == Double{Float64, Accuracy}
@test typeof(rand(FastDouble)) == Double{Float64, Performance}