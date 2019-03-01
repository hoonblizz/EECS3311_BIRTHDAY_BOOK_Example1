note
	description: "Test BIRTHDAY_BOOK"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TESTS
inherit
	ES_TEST

create
	make

feature {NONE} -- Initialization

	make
			-- create test suite
		do
			add_boolean_case (agent t1)
		end

feature -- tests


	t1: BOOLEAN
		local
			feb17: BIRTHDAY
			bb: BIRTHDAY_BOOK
			bb_access: BIRTHDAY_BOOK_ACCESS
			a: ARRAY[NAME]
			l_name: NAME
			l_birthday: BIRTHDAY
			jack,jill,max,hoon,jason: NAME
		do
			comment("t1: test birthday book")
			create jack.make ("Jack"); create jill.make ("Jill")
			create max.make ("Max")
			create feb17.make (02, 17) -- Feb 17
			bb := bb_access.data
			print("%NCreate Done...")
			-- add birthdays for Jack and Jill
			bb.put (jack, [14,01])  -- Jan 14
			bb.put (jill, [17,02])  -- Feb 17
			print("%NAdding Birthdays done..." + bb.out)
			Result := bb.model.count = 2
				and bb.model[jack].has ([14,01])-- ~ [14,01]
				and bb.model[jill].has ([17,02]) -- ~ [17,02]
				and bb.out ~ "{ Jack -> (14,1), Jill -> (17,2) }"
			check Result end
			print("%NCheck Adding Birthdays done...")
			-- Add birthday for Max
			bb.put (max, [17,02])
			assert_equal ("Max's birthday", bb.model[max].as_array[1], feb17)
			--print("%NAdding Max Birthday done...")
			-- Whose birthday is Feb 17th?
			a := bb.remind ([17,02])
			Result := a.count = 2
				and a.has (max)
				and a.has (jill)
				and not a.has (jack)
			check Result end
			print("%NCheck all Birthdays done..." + bb.out)
			-- check efficienthash table implementation
			across bb.model as cursor loop
				l_name := cursor.item.first
				l_birthday := cursor.item.second
				check
					bb.imp.has ([l_name, l_birthday])
				end
			end

			create hoon.make ("Hoon"); create jason.make ("Jason")
			
			bb.put (hoon, [22,07])  -- Jan 14
			bb.put (jason, [10,03])
			print("%Nbb: " + bb.out)


		end

end
