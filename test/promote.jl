@testset "promote 1" begin
  @test typeof(promote(one(Double64), one(Double32))[1]) === Double64
  @test typeof(promote(one(Double64), one(Double16))[1]) === Double64
  @test typeof(promote(one(Double32), one(Double16))[1]) === Double32  
  
  @test typeof(promote(one(Double64), one(BigInt))[1]) === BigInt
  @test typeof(promote(one(Double32), one(BigInt))[1]) === BigInt
  @test typeof(promote(one(Double16), one(BigInt))[1]) === BigInt
  
  @test typeof(promote(one(Double64), one(BigFloat))[1]) === BigFloat
  @test typeof(promote(one(Double32), one(BigFloat))[1]) === BigFloat
  @test typeof(promote(one(Double16), one(BigFloat))[1]) === BigFloat

  @test promote_type(Double64, Double32) === Double64
  @test promote_type(Double64, Double16) === Double64
  @test promote_type(Double32, Double16) === Double32
end  

@testset "promote 2" begin

 f2 = 2.0
  
  @test promote_type(DoubleFloat{Float64}, DoubleFloat{Float32}) == DoubleFloat{Float64}
  @test promote_type(DoubleFloat{Float64}, DoubleFloat{Float16}) == DoubleFloat{Float64}
  @test promote_type(DoubleFloat{Float32}, DoubleFloat{Float16}) == DoubleFloat{Float32}

  @test promote_type(DoubleFloat{Float64}, BigFloat) == BigFloat
  @test promote_type(DoubleFloat{Float32}, BigFloat) == BigFloat
  @test promote_type(DoubleFloat{Float16}, BigFloat) == BigFloat

  @test promote_type(DoubleFloat{Float64}, BigInt) == BigInt
  @test promote_type(DoubleFloat{Float32}, BigInt) == BigInt
  @test promote_type(DoubleFloat{Float16}, BigInt) == BigInt

  @test promote(DoubleFloat{Float64}(f2), DoubleFloat{Float32}(f2))[2] == DoubleFloat{Float64}(f2)
  @test promote(DoubleFloat{Float64}(f2), DoubleFloat{Float16}(f2))[2] == DoubleFloat{Float64}(f2)
  @test promote(DoubleFloat{Float32}(f2), DoubleFloat{Float16}(f2))[2] == DoubleFloat{Float32}(f2)

  @test promote(DoubleFloat{Float64}(f2), BigFloat(f2))[2] == DoubleFloat{Float64}(f2)
  @test promote(DoubleFloat{Float32}(f2), BigFloat(f2))[2] == DoubleFloat{Float32}(f2)
  @test promote(DoubleFloat{Float16}(f2), BigFloat(f2))[2] == DoubleFloat{Float16}(f2)

  @test promote(DoubleFloat{Float64}(f2), BigInt(f2))[2] == DoubleFloat{Float64}(f2)
  @test promote(DoubleFloat{Float32}(f2), BigInt(f2))[2] == DoubleFloat{Float32}(f2)
  @test promote(DoubleFloat{Float16}(f2), BigInt(f2))[2] == DoubleFloat{Float16}(f2)

end
