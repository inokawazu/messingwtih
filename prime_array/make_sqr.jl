using Primes

function padded_num(n::Integer, npadding::Integer)
    nd = ndigits(n)    # number of digits
    sp = " "^(npadding - nd) # space
    return sp*string(n)
end

function prime_bounds(ps, cutoff)
    minp, maxp = extrema(ps)

    lpb = minp == 2 ? 1 : minp  # lower prime bound
    upb = min(nextprime(maxp+1) - 1, cutoff) # upper prime bound
    return lpb, upb
end

function prime_array(n::Integer, io = stdout; 
        scw::Integer = displaysize(io)[2], # screen width
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

    for pp in Iterators.partition(ps, div(scw - rhl, md+dl))
        if print_line_bounds
            minp, maxp = prime_bounds(pp, n)
            print(io, padded_num(minp, nd), "-", padded_num(maxp, nd), ":")
        end

        foreach(pp) do p
            print(io, padded_num(p, md), delim)
        end
        println(io)
    end
    
    # reshape(ps, w, h)
end
