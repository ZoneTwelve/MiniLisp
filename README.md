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
