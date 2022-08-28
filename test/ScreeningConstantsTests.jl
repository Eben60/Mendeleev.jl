module ScreeningConstantsTests
using Mendeleev, Test

ScreenConst = Mendeleev.ScreenConst
ScreenConstants = Mendeleev.ScreenConstants

K = ELEMENTS_M[:K]

K_s1 = ScreenConst(19, 1, :s, 0.5105)

# fictional elements beyond good and evil
e1_s1 = ScreenConst(526, 1, 's', 1.0)
e1_s2 = ScreenConst(526, 2, 's', 2.0)
e1_p1 = ScreenConst(526, 1, 'p', 3.0)
e2_s1 = ScreenConst(528, 1, 's', 4.0)

scs = ScreenConstants([e1_s1, e1_s2, e1_p1])

@test_throws DomainError ScreenConstants([e1_s1, e1_s2, e1_p1, e2_s1])
@test_throws DomainError e1_s1 < e2_s1
@test_throws KeyError scs[1,5]

@test e1_s1 < e1_s2
@test e1_s1 < e1_p1
@test !(e1_p1 < e1_s1)
@test scs[2,1] == ScreenConst(526, 2,1, 2.0)

@test K.sconst[2, 2] == K.sconst[2, 'p'] == K.sconst[2, "p"] == K.sconst["2p"]
@test repr(K.sconst["2p"]) == "K 2p: 3.9728"
@test K.sconst["2p"].screening == 3.9728

end # module
