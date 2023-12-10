function read_whole_file(filepath)
    open(filepath) do file
        filecontents = read(file, String)
        return filecontents
    end
end

function get_seeds(s)
    seeds_line = first(eachline(IOBuffer(s)))
    seeds = map(x -> parse(Int, x),split(strip(split(seeds_line, ':')[2]), " "))
    return seeds
end

function get_seed_soil_dict(s)
    seed_soil = Dict()
    lines = split(s, '\n')
    start_pos = findfirst(occursin(strip("seed-to-soil map:")), lines)
    end_pos = findfirst(occursin(strip("soil-to-fertilizer map:")), lines)
    println(start_pos)
    println(end_pos)
    seed_to_soil_map = s[start_pos:end_pos]
    print(seed_to_soil_map)
end

function main()
    if length(ARGS) == 0 
        println("No argument given")
        exit(1)
    end
    filepath = ARGS[1]
    s = read_whole_file(filepath)
    seeds = get_seeds(s)
    get_seed_soil_dict(s)
end

if abspath(PROGRAM_FILE) == @__FILE__
    main()
end