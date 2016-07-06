{.passL: "-framework Foundation".}
{.passL: "-lgsl".}

type
  Gsl_rng_type = object
    name: int
  Gsl_rng = object
    typ: Gsl_rng_type

proc gsl_rng_alloc(T: ptr Gsl_rng_type) : ptr Gsl_rng  {.header: "<gsl/gsl_rng.h>", importc: "gsl_rng_alloc", varargs.}

proc gsl_rng_env_setup() : ptr Gsl_rng_type {.header: "<gsl/gsl_rng.h>", importc: "gsl_rng_env_setup", varargs.}

proc gsl_ran_gaussian(r : ptr Gsl_rng, sigma : float) : float {.header: "<gsl/gsl_randist.h>", importc: "gsl_ran_gaussian", varargs.}

let rng = gsl_rng_alloc(gsl_rng_env_setup())

for i in 0..100:
  let x = gsl_ran_gaussian(rng, 1.0)
  echo $x
