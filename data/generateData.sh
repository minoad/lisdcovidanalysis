
getClassDetail(){
    # I could do this with tail but then i would have to read the file twice to get the count.
    cat classDetail.csv | grep -v teacherName
}

# Get the cumulative cases on a specific day
# Unit test: 
## 2021-08-18,smith,20,kindergarten,2
## 2021-08-17,naresh,20,kindergarten,0
getCaseCountPerDayPerClass(){
    dte=$1
    teacher=$2
    grade=$3
    result=$(cat classDetail.csv | grep $dte | grep $teacher | grep $grade | cut -d ',' -f 5)
    # TODO: Add test.  if not valid number return -1
}

# Results in one row per student containing the date, studentid, teachername, grade
generateStudentData(){
    for classDetail in $(getClassDetail); do
        local dte=$(echo $classDetail | cut -d ',' -f 1)
        local teacherName=$(echo $classDetail | cut -d ',' -f 2)
        local classCount=$(echo $classDetail | cut -d ',' -f 3)
        local grade=$(echo $classDetail | cut -d ',' -f 4)
        for n in {1..$classCount}; do
            # "date","studentIdent", "teacher", "grade", "covidStatus", "optout", "tracingContact"
            echo $dte,$(echo $(echo $teacherName | cut -c 1-3) '-stu-' $n | tr -d ' '),$teacherName,$grade #,false,false,false
        done
    done
}

# This is a bit trickier.  This will take a list which includes all of the student data.  For each date we need a counter variable that reads the number of positive cases.
# This will need to distribute the positive cases to n members of the class.  Right now i do not need to worry about summing the total cases per class on a date since the case count is cumulative.
# If this changes and the case count becomes an absolute measurement on any individual day, i will then need to look back through the data file and sum the total number of cases before distributing.
# this bit is annoying.  I hate coding in bash.  If this gets any more complex, rewrite it in Go or python.
#assignCovidStatus

for studentEntry in $(generateStudentData); do
    dte=$(echo $studentEntry | cut -d ',' -f 1)
    teacher=$(echo $studentEntry | cut -d ',' -f 3)
    grade=$(echo $studentEntry | cut -d ',' -f 4)
    # get the number of positive cases for that day
    ## TODO: if -1, an error has occured
    # Only perform this lookup if this teacher name is different than the last teacher name
    caseCount=$(getCaseCountPerDayPerClass $dte $teacher $grade)
    echo $dte $teacher $grade $caseCount
done