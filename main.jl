"The Board"
mutable struct Board
	size::Int
	b
	# solutions

	function Board(size)
		new(size, [rand(1:size) for i in 1:size])
	end
end
"Location Tuple"
mutable struct Location
    x::Int
    y::Int

end
"Print the Board... Rotated 90 degrees because lshift"
function Print_Board(b)
	for i in b.b
		println(lpad(string(1 << (i - 1), base = 2), b.size, "0"))
	end
end
"Get the Hueristic Score by counting how many challengers there are"
function Hueristic_Score(b)
	h = 0
	for i in 1:b.size

		for j in i + 1:b.size
			if b.b[i] === b.b[j]
				h += 1
			end
			offset = j - i
			if b.b[i] === b.b[j] - offset || b.b[i] === b.b[j] + offset
				h += 1
			end
		end
	end
	return h
end
"Move the board in accordance with the best score"
function Move!(b)
    
	moves = Dict{Location,Int64}()
    for col in 1:b.size
        best_move = b.b[col]

        for row in 1:b.size
            if b.b[col] == row
                # We don't need to evaluate the current
                # position, we already know the h-value
                continue
			end

			b_copy = deepcopy(b)
            # Move the queen to the new row
            b_copy.b[col] = row
            moves[Location(row, col)] = Hueristic_Score(b_copy)
		end
	end

    best_moves = []
    h_to_beat = Inf
	for (key, value) in moves
        if value < h_to_beat
			h_to_beat = value
		end
	end

	for (key, value) in moves
	
		if value == h_to_beat
			# println(key)
			push!(best_moves, key)
		end
	end

	best_move = best_moves[begin]
	b.b[best_move.y] = best_move.x

    return b
end  
"Get user input"
function get_n()
	println("What value for 'n' would you like to use:")
	try
		x = parse(Int, readline())
		if x == 2 || x == 3
			println("No solution exists for $x.")
			Base.exit()
		end
		return 
	catch e
		if isa(e, ArgumentError)
			println("Input was not an int")
		end
		println("Using 8 as default value")
		return 8
	end
end
"Main function that plays the game"
function main()
	n = get_n()
	b = Board(n)
	while Hueristic_Score(b) > 0
		Move!(b)
	end
	println("Solution:")
	Print_Board(b)
    end

    
main()


