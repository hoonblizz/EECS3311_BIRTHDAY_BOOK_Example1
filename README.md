# EECS3311_BIRTHDAY_BOOK_Example1
2018W EECS3311 York University. Modified sample from prof example.

## Description
Modified sample from basic birthday book example from prof. 
The following has been modified. 

1. model data type is changed to REL
```
REL [NAME, BIRTHDAY]
```
2. imp (implementation) type is changed to TUPLE of Arrays (Inefficient but just for practise)
```
ARRAY [TUPLE [name: NAME; bday: BIRTHDAY]]
```
3. Design Pattern is changed to **Singleton**.

---

### How to add Singleton design pattern?
* expanded class **BIRTHDAY_BOOK_ACCESS** added
```
expanded class
 BIRTHDAY_BOOK_ACCESS

feature
 data: BIRTHDAY_BOOK
  once
   create Result.make
 end
end
```

* In **BIRTHDAY_BOOK** class, restrict **make** and other features
```
create {BIRTHDAY_BOOK_ACCESS} make
```

* when you test, make sure to have BIRTHDAY_BOOK_ACCESS and create BIRTHDAY_BOOK from there.
No Need to create because BIRTHDAY_BOOK_ACCESS is an **expanded** class. 
```
local
 bb: BIRTHDAY_BOOK
 bb_access: BIRTHDAY_BOOK_ACCESS
do
 bb := bb_access.data
end

```
