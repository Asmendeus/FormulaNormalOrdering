s1 = Subscript{:certain, :site}(1)
s2 = Subscript(:certain, :site, 2)
s3 = Site{:certain}(3)
s4 = Site(:certain, 4)

c1 = Subscript{:certain, :cell}(1)
c2 = Subscript(:certain, :cell, 2)

@testset "Subscript property" begin
    @test getSubType(s1) == :certain
    @test getSubType(c1) == :certain

    @test getSubDim(s2) == :site
    @test getSubDim(c2) == :cell

    @test getSubLabel(s3) == 3
    @test getSubLabel(c2) == 2
end
