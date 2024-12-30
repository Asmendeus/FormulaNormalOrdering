si = Subscript{:symbol, :site}(:i)
sj = Subscript(:symbol, :site, :j)
sk = Site{:symbol}(:k)
sl = Site(:symbol, :l)

ca = Subscript{:symbol, :cell}(:a)
cb = Subscript(:symbol, :cell, :b)

@testset "Subscript property" begin
    @test getType(si) == :symbol
    @test getType(ca) == :symbol

    @test getSubDim(sj) == :site
    @test getSubDim(cb) == :cell

    @test getSubLabel(sk) == :k
    @test getSubLabel(ca) == :a
end
