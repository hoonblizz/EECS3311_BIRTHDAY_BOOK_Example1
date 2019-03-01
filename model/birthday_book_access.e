note
	description: "Summary description for {BIRTHDAY_BOOK_ACCESS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

expanded class
	BIRTHDAY_BOOK_ACCESS

feature
	data: BIRTHDAY_BOOK
		once
			create Result.make
		end
end
