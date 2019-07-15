function Base.isapprox(x::DoubleFloat{T}, y::T; atol::Real=0.0, rtol::Real=atol>0 ? 0 : eps(T)^(37/64), nans::Bool=false, norm::Function=norm) where {T<:IEEEFloat}
    return isapprox(x, DoubleFloat{T}(y), atol=atol, rtol=rtol, nans=nans, norm=norm)
end
function Base.isapprox(x::T, y::DoubleFloat{T}; atol::Real=0.0, rtol::Real=atol>0 ? 0 : eps(T)^(37/64), nans::Bool=false, norm::Function=norm) where {T<:IEEEFloat}
    return isapprox(DoubleFloat{T}(x), y, atol=atol, rtol=rtol, nans=nans, norm=norm)
end
function Base.isapprox(x::DoubleFloat{T}, y::DoubleFloat{T}; atol::Real=0.0, rtol::Real=atol>0 ? 0 : eps(DoubleFloat{T})^(37/64), nans::Bool=false, norm::Function=norm) where {T<:IEEEFloat}
    x == y || (isfinite(x) && isfinite(y) && abs(x-y) <= max(max(1.0e-32, atol), rtol*max(abs(x), abs(y)))) || (nans && isnan(x) && isnan(y))
end

Base.isapprox(x::DoubleFloat{T}, y::F; atol::Real=0.0, rtol::Real=atol>0.0 ? 0.0 : eps(max(abs(x), abs(y)))^(37/64), nans::Bool=false, norm::Function=norm) where {T<:IEEEFloat, F<:Real} =
    isapprox(promote(x, y)..., atol=atol, rtol=rtol, nans=nans, norm=norm)

Base.isapprox(x::F, y::DoubleFloat{T}; atol::Real=0.0, rtol::Real=atol>0.0 ? 0.0 : eps(max(abs(x), abs(y)))^(37/64), nans::Bool=false, norm::Function=norm) where {T<:IEEEFloat, F<:Real} =
    isapprox(promote(x, y)..., atol=atol, rtol=rtol, nans=nans, norm=norm)


function Base.lerpi(j::Integer, d::Integer, a::DoubleFloat{T}, b::DoubleFloat{T}) where {T}
    t = DoubleFloat{T}(j)/d
    a = fma(-t, a, a)
    return fma(t, b, a)
end

function Base.clamp(x::DoubleFloat{T}, lo::DoubleFloat{T}, hi::DoubleFloat{T}) where {T}
     lo <= x <= hi && return x
     lo <= x && return hi
     return lo
end
function Base.clamp(x::DoubleFloat{T}, lo::T, hi::T) where {T}
     lo <= x <= hi && return x
     lo <= x && return hi
     return lo
end
function Base.clamp(x::T, lo::DoubleFloat{T}, hi::DoubleFloat{T}) where {T}
     lo <= x <= hi && return x
     lo <= x && return hi
     return lo
end


# for compatibility with old or unrevised outside linalg functions
function Base.:(+)(v::Vector{DoubleFloat{T}}, x::T) where {T}
    return v .+ x
end
function Base.:(-)(v::Vector{DoubleFloat{T}}, x::T) where {T}
    return v .- x
end
function Base.:(+)(m::Matrix{DoubleFloat{T}}, x::T) where {T}
    return m .+ x
end
function Base.:(-)(m::Matrix{DoubleFloat{T}}, x::T) where {T}
    return m .- x
end
