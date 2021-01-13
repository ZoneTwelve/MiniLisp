# MiniLisp

# 如何執行

```
make run code=main output=program
./program
```

# 自動化測試
```
./auto-test -t testcase -p program -s main
```

## auto-test
  User Commands
Name	
	auto-test - automatic running testcase

SYNOPSIS
	auto-test [OPTION]...

Description
	-p
		using this program to running testcase(include auto compiling output)
	
	-s
		Source code option, using for auto compiling
	
	-t
		choosing this directory to run the testcase.

# returned code
return value meaning
- Error code: 1
  - testing
- Error code: 2
  - testing

# Intro
- program 
  - program start 
- expr 
  - program analysis
- math_*
  - calculation operator (function)
- *_ret
  - date type checker && value return
- condition
  - GreaThen (greater then A)
  - LessThen (less then A)
  - math_equal 
  - if_numb (return number)
  - if_bool (return boolean)
- print
  - print_num
  - print_bool

## 流程:
1. program -> expr program 持續吃 input
2. expr 判斷 是否接觸到 print, math calculation, bool calculation 等 token
3. math do math
4. boolean do boolean
5. from math to boolean throw error, boolean also
