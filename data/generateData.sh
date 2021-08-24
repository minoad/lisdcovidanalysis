
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
    if ! [[ $result -ge 0 ]]; then
        result = -1
    fi
    echo $result
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
assignCovidStatus()(
    for studentEntry in $(generateStudentData); do
        # If the last teacher and the current teacher are different, get the cumulative case count
        # TODO: Add date and grade ands to the logic
        if [[ $teacher != $(echo $studentEntry | cut -d ',' -f 3) ]]; then
            #echo $teacher $(echo $studentEntry | cut -d ',' -f 3)
            ## TODO: if -1, an error has occured
            local caseCount=$(getCaseCountPerDayPerClass $(echo $studentEntry | cut -d ',' -f 1) $(echo $studentEntry | cut -d ',' -f 3) $(echo $studentEntry | cut -d ',' -f 4))
            #echo $caseCount
        fi
        local dte=$(echo $studentEntry | cut -d ',' -f 1)
        local teacher=$(echo $studentEntry | cut -d ',' -f 3)
        local grade=$(echo $studentEntry | cut -d ',' -f 4)
        #echo $caseCount
        # if case count > 0, we still have positives to distribute
        if [[ caseCount -gt 0 ]]; then
            local state=true
        else;
            local state=false
        fi
        echo $studentEntry,$state
        local caseCount=$(($caseCount -1))
    done
)

assignCovidStatus