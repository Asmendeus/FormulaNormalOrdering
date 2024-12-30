si = Subscript{:symbol, :site}(:i)
sj = Subscript(:symbol, :site, :j)
sk = Site{:symbol}(:k)
sl = Site(:symbol, :l)

ca = Subscript{:symbol, :cell}(:a)
cb = Subscript(:symbol, :cell, :b)

@testset "Subscript property" begin
    @test getSubType(si) == :symbol
    @test getSubType(ca) == :symbol

    @test getSubDim(sj) == :site
    @test getSubDim(cb) == :cell

    @test getSubLabel(sk) == :k
    @test getSubLabel(ca) == :a
end
