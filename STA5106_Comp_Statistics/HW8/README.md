Random Number Generation (RNG): 1) Psuedo-random numbers from Uniform(0,1); 2) Inverse Transformation.  

**main_1_2.m:** Generate Uniform(0, 1) with Congruential Generators given m, a.  
**main_3.m:** Generate Weibull(1, 0.5) with Inverse Transform method.  
**main_4.m:** Generate samples from Exp(1), then look into how often the latest sample is larger than all before. This frequency turns out to be a Poisson distribution.  
**unif_gen.m:** Function. Generate Uniform(0,1) with Congruential Generators, i.e. psuedo-random by modulo operation.  
**weibull_gen.m:** Function: Generate Weibull distribution.  
**rng_gen.py:** Same as unif_gen.m and weibull_gen.m.
