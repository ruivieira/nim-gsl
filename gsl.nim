{.passL: "-framework Foundation".}
{.passL: "-lgsl".}

import sequtils, math

type
  Gsl_rng_type = object
    name: int
  Gsl_rng* = object
    typ: Gsl_rng_type

proc gsl_rng_alloc*(T: ptr Gsl_rng_type) : ptr Gsl_rng  {.header: "<gsl/gsl_rng.h>", importc: "gsl_rng_alloc", varargs.}

proc gsl_rng_env_setup*() : ptr Gsl_rng_type {.header: "<gsl/gsl_rng.h>", importc: "gsl_rng_env_setup", varargs.}

proc gsl_ran_gaussian(r : ptr Gsl_rng, sigma : float) : float {.header: "<gsl/gsl_randist.h>", importc: "gsl_ran_gaussian", varargs.}

proc gsl_ran_gamma(r : ptr Gsl_rng, a : float, b : float): float {.header: "<gsl/gsl_randist.h>", importc: "gsl_ran_gamma", varargs.}

proc rnorm*(r : ptr Gsl_rng, mu: float, sigma: float) : float =
  mu + gsl_ran_gaussian(r, sigma)

proc rnorm*(r : ptr Gsl_rng, n : int, mu: float, sigma: float) : seq[float] =
  var samples: seq[float] = @[]
  for i in 0..<n:
    samples.add(mu + gsl_ran_gaussian(r, sigma))
  samples

proc rgamma*(r: ptr Gsl_rng, a : float, b : float) : float =
  gsl_ran_gamma(r, a, b)

proc rgamma*(r: ptr Gsl_rng, n : int, a: float, b: float) : seq[float] =
  var samples: seq[float] = @[]
  for i in 0..<n:
    samples.add(gsl_ran_gamma(r, a, b))
  samples

proc gsl_stats_variance(data: seq[float], stride: int, n: int): float {.header: "<gsl/gsl_statistics.h>", importc: "gsl_stats_variance", varargs.}

proc mean*(values: seq[float]): float = values.foldr(a + b) / float(values.len())

proc variance*(values: seq[float]): float = gsl_stats_variance(values, values.len(), values.len())

proc sum*(values: seq[float]): float = values.foldr(a + b)

proc pow*(values: seq[float], exponent: float): seq[float] =
  values.mapIt(pow(it, exponent))

# for i in 0..100:
#   let x = gsl_ran_gaussian(rng, 1.0)
#   echo $x
