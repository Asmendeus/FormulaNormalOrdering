si = Subscript{:site}(:i)
sj = Subscript(:site, :j)
sk = Site(:k)

ca = Subscript{:cell}(:a)
cb = Subscript(:cell, :b)

@testset "Subscript property" begin
    @test getSubType(si) == :site
    @test getSubType(ca) == :cell

    @test getSubLabel(sk) == :k
    @test getSubLabel(ca) == :a
end
