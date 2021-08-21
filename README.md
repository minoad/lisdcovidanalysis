# LISD Covid Predictive Analysis

Analysis of covid data related to Leander ISD

Its been a long time since i have developed using a windows machine.  Some delays as i have to look up trivial things like wget on windows.

## Questions to answer

1. Based on historical data, what is the likelyhood of my child becoming infected with COVID on a week by week basis?
1. Is there a restfull api to collect the data or do we need to webscrape?
1. Maybe bigquery already includes this data in a dataset somewhere?

## Data Tool Requirements

1. Compare risk to the predicted date of vaccine release for 5+ and create a value proposition including risk vs the value of attending school.

## Data Collection

### Collect using wget

```powershell
Invoke-WebRequest https://view-awesome-table.com/-MgIH6QvYgeB84hfaQyF/view -OutFile wgetResult.txt
```

