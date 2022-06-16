using Primes

"""
 padded_num pads numbers with spaces to with right aligment.
"""
function padded_num(n::Integer, npadding::Integer)
    nd = ndigits(n)    # number of digits
    sp = " "^(npadding - nd) # space
    return sp*string(n)
end

"""
 prime_bounds returns bounds of the primes for table display.
 For the special case where the smallest prime in ps is 2, the lower bound is one.
 The cutoff is for the larget possible number for the maximum. This is n for table display.
"""
function prime_bounds(ps, cutoff)
    minp, maxp = extrema(ps)

    lpb = minp == 2 ? 1 : minp  # lower prime bound
    upb = min(nextprime(maxp+1) - 1, cutoff) # upper prime bound
    return lpb, upb
end

"""
    prime_array(n::Integer, io = stdout; 
            width::Integer = displaysize(io)[2],
            delim = " ",
            print_line_bounds = false
        )

    prints out a table of primes between 1:n inclusively. \ 
    The the print output can be changed but I would reccomend to that the width is changed maually set.
    print_line_bounds is a flag that determines wether the bounds of the primes are printed \
    at every row. For example the primes 2 5 7 would have a bound of 1-10.
"""
function prime_array(n::Integer, io = stdout; 
        width::Integer = displaysize(io)[2], # screen width
        delim = " ",
        print_line_bounds = false
    )

    nd = ndigits(n) # digits of n
    ps = primes(n)
    md = maximum(ndigits, ps) # max digit count
    dl = length(delim) # delimiter length

    rrd  = "-" # row range delimiter
    rrhd = ":" # row range cut delimiter

    rhl = print_line_bounds ? (2*nd + length(rrd) + length(rrhd)) : 0  # row header length

    for pp in Iterators.partition(ps, div(width - rhl, md+dl))
        if print_line_bounds
            minp, maxp = prime_bounds(pp, n)
            print(io, padded_num(minp, nd), rrd, padded_num(maxp, nd), rrhd)
        end

        foreach(pp) do p
            print(io, padded_num(p, md), delim)
        end
        println(io)
    end
end
