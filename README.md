# Date ranges overlap validations example

A check if two date or time ranges A and B overlap needs to cover a lot of cases:

* A partially overlaps B
* A surrounds B
* B surrounds A
* A occurs entirely after B
* B occurs entirely after A

One trick to cover all these cases with a single expression is to see if the start date of each range is looking at the end date of the other range in the same direction.

This ruby snippet explains the trick:

```ruby
# Check if two intervals overlap
def overlap?(lhs, rhs)
  (lhs.start_date - rhs.end_date) * (rhs.start_date - lhs.end_date) >= 0
end
```

A query that will return all dates overlapping given interval:

```sql
SELECT * FROM intervals WHERE TIME_DIFF(intervals.start_date, given_start_date) * TIME_DIFF(given_end_date, intervals.end_date) >= 0
```

You may want to use `DATE_DIFF` instead of `TIME_DIFF` if you are
comparing just dates.
