module ScreeningConstantsTests
using Mendeleev, Test

ScreenConst = Mendeleev.ScreenConst
ScreenConstants = Mendeleev.ScreenConstants

e1_s1 = ScreenConst(126, 1, 's', 1.0)
e1_s2 = ScreenConst(126, 2, 's', 2.0)
e1_p1 = ScreenConst(126, 1, 'p', 3.0)
e2_s1 = ScreenConst(128, 1, 's', 4.0)

scs = ScreenConstants([e1_s1, e1_s2, e1_p1])

scs19 = ScreenConstants([(19, 1, :s, 0.5105), (19, 2, :p, 3.9728), (19, 2, :s, 5.9938),
                        (19, 3, :p, 11.2744), (19, 3, :s, 10.3201), (19, 4, :s, 15.5048)])


@test_throws DomainError ScreenConstants([e1_s1, e1_s2, e1_p1, e2_s1])
@test_throws DomainError e1_s1 < e2_s1
@test_throws KeyError scs[1,5]

@test e1_s1 < e1_s2
@test e1_s1 < e1_p1
@test !(e1_p1 < e1_s1)
@test scs[2,1] == ScreenConst(126, 2,1, 2.0)
@test scs[2,1] == scs["2s"]

# @test

end # module
