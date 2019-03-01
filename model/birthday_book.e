note
	description: "[
		Keep track of birthdays for friends.
		Model is FUN[NAME,BIRTHDAY]
		Efficient implementation with hash table
	]"
	author: "JSO"
	date: "$Date$"
	revision: "$Revision$"

class
	BIRTHDAY_BOOK

inherit

	ANY
		redefine
			out
		end

create {BIRTHDAY_BOOK_ACCESS} make

feature {BIRTHDAY_BOOK_ACCESS, ES_TEST} -- implementation

	imp: ARRAY [TUPLE [name: NAME; bday: BIRTHDAY]]

	make
			-- create a birthday book
		do
			create imp.make_empty
			imp.compare_objects
		ensure
			model.is_empty
		end

feature -- model

	model: REL [NAME, BIRTHDAY]
			-- model is a function from NAME --> BIRTHDAY
			-- abstraction function
			-- Abstraction Function from an object's concrete implementation
			-- to the abstract value it represent
		local
			l_name: NAME
			l_date: BIRTHDAY
			i: INTEGER
		do
			create Result.make_empty

			-- Loop for # of names (because name is unique but they should be the same)
			-- and attach them to model
			from i := 1
			until i > imp.upper
			loop
				l_name := imp[i].name
				l_date := imp[i].bday
				check attached l_date as l_date_attached then
					Result.extend ([l_name, l_date_attached])
				end
				i := i + 1
			end

			--from
			--	imp.start
			--until
			--	imp.after
			--loop
			--	l_name := imp.key_for_iteration
			--	l_date := imp [l_name]
			--	check attached l_date as l_date2 then
			--		Result.extend ([l_name, l_date2])
			--	end
			--	imp.forth
			--end
			--imp.start
		end

feature

	put (a_name: NAME; d: BIRTHDAY)
			-- add birthday for `a_name' at date `d'
			-- or overrride current birthday with new
		local
			i: INTEGER
			keep_looping: BOOLEAN
		do
			keep_looping := true
			-- Check for name if it's duplicating
			-- if duplicating, change bday value in the index of a_name
			print("%NCompare count and upper: " + imp.count.out + " and " + imp.upper.out)
			if imp.upper > 0 then
				from i := 1
				until i > imp.upper
				loop

					print("%NPut [" + a_name.out + ", " + d.out + "] => " + i.out)
					if keep_looping then
						if imp[i].name ~ a_name then
							imp.put ([a_name, d], i)
							keep_looping := false
						elseif i ~ imp.upper then
							imp.force ([a_name, d], imp.count + 1)
						end
					end
					i := i + 1
				end
			else
				imp.force ([a_name, d], imp.count + 1)
			end

			--if not imp.has_key (a_name) then
			--	imp.extend (d, a_name)
			--else
			--	imp.replace (d, a_name)
			--end
		ensure
			model_override:
				model ~ (old model.deep_twin).overriden_by ([a_name, d])
			model_extended:
				model ~ (old model.deep_twin).extended ([a_name, d])
		end

	remind (d: BIRTHDAY): ARRAY [NAME]
			-- returns an array of names with birthday `d'
		local
			l_name: NAME
			l_date: BIRTHDAY
			i: INTEGER
		do
			create Result.make_empty
			Result.compare_objects

			from i := 1
			until i > imp.upper
			loop
				if imp[i].bday ~ d then
					l_name := imp[i].name
					Result.force (l_name, Result.count + 1)
				end
				i := i + 1
			end
			--from
			--	imp.start
			--until
			--	imp.after
			--loop
			--	l_name := imp.key_for_iteration
			--	l_date := imp [l_name]
			--	if l_date ~ d then
			--		Result.force (l_name, i)
			--		i := i + 1
			--	end
			--	imp.forth
			--end
		ensure
			remind_count:
				Result.count = model.range_restricted_by (d).count --(model @> (d)).count
			remind_model_range_restiction:
				across model.range_restricted_by (d).domain as cr all
					Result.has (cr.item)
				end
			model_unchanged:
				model ~ old model.deep_twin
		end

	count: INTEGER
		do
			Result := imp.count
		end

feature

	out: STRING
		do
			Result := model.out
		end

invariant
	count =  model.count
	model.count = imp.count
	across model as cursor all
	   imp.has ([cursor.item.first, cursor.item.second])
	end

end
