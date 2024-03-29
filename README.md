# LISD Covid Predictive Analysis

Analysis of covid data related to Leander ISD

Its been a long time since i have developed using a windows machine.  Some delays as i have to look up trivial things like wget on windows.

## Communications

[Principle Newsletter](https://www.smore.com/2jake)

## Questions to answer

1. Based on historical data, what is the likelihood of my child becoming infected with COVID on a week by week basis?

## Data Summary

The predictive table will contain the following schema.

```
"date","studentIdent", "teacher", "grade", "covidStatus", "optout", "tracingContact"
```

The data is generated from a data file which contains the sum of the number of positive cases per class per day.

## Data Tool Requirements

1. Compare risk to the predicted date of vaccine release for 5+ and create a value proposition including risk vs the value of attending school.

## Data Collection

### Data Chain

[Williamson County and Cities Health District, Texas Department of State Health Services](https://experience.arcgis.com/experience/ae30cf23f70b40fda5a4804e7601eee9)
[Williamson County and Cities Health District, Austin Public Health / Travis County](https://www.leanderisd.org/covid19dashboard/)
[Raw positive case data](https://docs.google.com/spreadsheets/d/1zyEfyCwd061b92EK_Pzk7cGw0y04u5s4Bk1XjXKMlJM/edit#gid=0)
[This s is a google sheet which has an ip available](https://developers.google.com/sheets/api/quickstart/python)

### Collect using wget

```powershell
Invoke-WebRequest https://view-awesome-table.com/-MgIH6QvYgeB84hfaQyF/view -OutFile wgetResult.txt
```

## School

[School Site](https://whitestone.leanderisd.org/)

### Class Details

[Maul](https://sites.google.com/leanderisd.org/ms-mauls-class/home)
