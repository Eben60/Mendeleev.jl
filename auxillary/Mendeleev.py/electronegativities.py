# models.py #388
def zeff(
        self, n: int = None, o: str = None, method: str = "slater", alle: bool = False
    ) -> Union[float, None]:
        """
        Return the effective nuclear charge for ``(n, s)``
        Args:
            method: Method to calculate the screening constant, the choices are
                - `slater`, for Slater's method as in Slater, J. C. (1930).
                    Atomic Shielding Constants. Physical Review, 36(1), 57–64.
                    `doi:10.1103/PhysRev.36.57 <http://www.dx.doi.org/10.1103/PhysRev.36.57>`_
                - `clementi` for values of screening constants from Clementi, E.,
                    & Raimondi, D. L. (1963). Atomic Screening Constants from SCF
                    Functions. The Journal of Chemical Physics, 38(11), 2686.
                    `doi:10.1063/1.1733573 <http://www.dx.doi.org/10.1063/1.1733573>`_
                    and Clementi, E. (1967). Atomic Screening Constants from SCF
                    Functions. II. Atoms with 37 to 86 Electrons. The Journal of
                    Chemical Physics, 47(4), 1300.
                    `doi:10.1063/1.1712084 <http://www.dx.doi.org/10.1063/1.1712084>`_
            n: Principal quantum number
            o: Orbital label, (s, p, d, ...)
            alle: Use all the valence electrons, i.e. calculate screening for an
                extra electron when method='slater', if method='clementi' this
                option is ignored
        """

        # identify the valence s,p vs d,f
        # if n is None: yes it is
        n = self.ec.max_n()

        # if o is None: yes it is
            # take the shell with max `l` for a given `n`
        o = ORBITALS[max(get_l(x[1]) for x in self.ec.conf.keys() if x[0] == n)]

        # if method.lower() == "slater": yes it is
        return self.atomic_number - self.ec.slater_screening(n=n, o=o, alle=alle)

#############


    def slater_screening(self, n, o, alle=False):
        """
        Calculate the screening constant using the approach introduced by
        Slater in Slater, J. C. (1930). Atomic Shielding Constants. Physical
        Review, 36(1), 57-64.
        `doi:10.1103/PhysRev.36.57 <http://www.dx.doi.org/10.1103/PhysRev.36.57>`_
        Args:
          n : int
            Principal quantum number
          o : str
            orbtial label, (s, p, d, ...)
          alle : bool
            Use all the valence electrons, i.e. calculate screening for
            an extra electron
        """

        ne = 0 if alle else 1
        coeff = 0.3 if n == 1 else 0.35
        if o in ["s", "p"]:
            # get the number of valence electrons - 1
            vale = float(
                sum(v for k, v in self.conf.items() if k[0] == n and k[1] in ["s", "p"])
                - ne
            )
            n1 = sum(v * 0.85 for k, v in self.conf.items() if k[0] == n - 1)
            n2 = sum(float(v) for k, v in self.conf.items() if k[0] in range(1, n - 1))

        elif o in ["d", "f"]:
            # get the number of valence electrons - 1
            vale = float(
                sum(v for k, v in self.conf.items() if k[0] == n and k[1] == o) - ne
            )

            n1 = sum(float(v) for k, v in self.conf.items() if k[0] == n and k[1] != o)
            n2 = sum(float(v) for k, v in self.conf.items() if k[0] in range(1, n))

        else:
            raise ValueError("wrong valence subshell: ", o)

        return n1 + n2 + vale * coeff
###########

self.ec = ElectronicConfiguration(self.econf)
