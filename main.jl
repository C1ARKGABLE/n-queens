import Statistics
"The Board"
mutable struct Board
	size::Int
	b::Array{Int}
	moves::Int
	restarts::Int
	restart::Bool


	function Board(size, restarts = 0, restart = false, moves = 0)
		new(size, [rand(1:size) for i in 1:size], moves, restarts, restart)
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
function Hueristic_Score(b,size)
	h = 0
	for i in 1:size

		for j in i + 1:size
			if b[i] === b[j]
				h += 1
			end
			offset = j - i
			if b[i] === b[j] - offset || b[i] === b[j] + offset
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
				# Skip this row
                continue
			end

			b_copy = deepcopy(b.b)
            b_copy[col] = row
            moves[Location(row, col)] = Hueristic_Score(b_copy,b.size)
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
			push!(best_moves, key)
		end
	end

	best_move = best_moves[begin]
	b.b[best_move.y] = best_move.x
	
	b.moves += 1

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
		return x
	catch e
		if isa(e, ArgumentError)
			println("Input was not an int")
		end
		println("Using 8 as default value")
		return 8
	end
end

"Get Bool input"
function get_r()
	println("Do you want random restarts on failure?")
	try
		x = parse(Bool, readline())
		return x
	catch e
		if isa(e, ArgumentError)
			println("Input was not a Bool")
		end
		println("Using false as default value")
		return false
	end
end

"Main function that plays the game"
function main(n, restart)
	
	b = Board(n, 0, restart)
	# Print_Board(b)
	# println("-------------")
	steps_to_fail = 0

	while (old_score = Hueristic_Score(b.b,b.size)) > 0
		Move!(b)
		score = Hueristic_Score(b.b,b.size)

		if b.restart && score >= old_score
			# println("-"^10)
			# println(b)
			steps_to_fail += b.moves
			b = Board(n, b.restarts + 1, restart, b.moves)
			# println(b)
		elseif score >= old_score
			return b, true, steps_to_fail
		else

		end
	end
	return b, false, steps_to_fail
    # println("Solution:")
	# Print_Board(b)
end

function loop()
	total = 0
	f_total = 0
	fail = 0
	restarts = 0
	iter = 500
	r = get_r()
	n = get_n()
	for i = 1:iter
		b, failed, steps = main(n, r)
		f_total += steps
		if failed
			fail += 1
			f_total += b.moves
		else
			total += b.moves
			restarts += b.restarts
		end
	end
	total /= (iter - fail)
	if r 
		f_total /= restarts
	else
		f_total /= fail
	end

	println("Average moves to success $total")
	println("Average moves to failure $f_total")
	println("Restarted $restarts times") 
	println("Fails $fail")
end

loop()


