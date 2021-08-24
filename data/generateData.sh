
getClassDetail(){
    # I could do this with tail but then i would have to read the file twice to get the count.
    cat classDetail.csv | grep -v teacherName
}

dte="2021-08-17"
for classDetail in $(getClassDetail); do
    teacherName=$(echo $classDetail | cut -d ',' -f 1)
    classCount=$(echo $classDetail | cut -d ',' -f 2)
    grade=$(echo $classDetail | cut -d ',' -f 3)
    for n in {1..$classCount}; do
        # "studentIdent", "teacher", "grade", "covidStatus", "optout", "tracingContact"
        echo $dte,$(echo $(echo $teacherName | cut -c 1-3) '-stu-' $n | tr -d ' '),$teacherName,$grade,false,false,false
    done
done

#for n in {1..160}; do
    #echo "studentIdent", "teacher", "grade", "covidStatus", "optout", "tracingContact"
#done