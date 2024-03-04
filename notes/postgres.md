
### SQL

Formating sql strings inside vim:
```vim
:'<,'>!sqlformat --reindent_aligned -
```

### SQLAlchemy

Simple script to connect to a PostgreSQL database using sqlalchemy:
```python
from sqlalchemy import create_engine
from sqlalchemy.engine.url import URL
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import scoped_session, sessionmaker

db_url = URL(
    "postgresql+psycopg2",
    host="<HOST NAME>",
    port="<PORT>",
    database="<DATABASE>",
    username="<USERNAME>",
)

engine = create_engine(db_url)
db_session = scoped_session(
    sessionmaker(autocommit=False, autoflush=False, bind=engine)
)

Base = declarative_base()
Base.query = db_session.query_property()
Base.metadata.create_all(bind=engine)


def scalar(sql: str, args={}):
    return db_session.execute(sql, args).scalar()


def fetchall(sql: str, args={}):
    return db_session.execute(sql, args).fetchall()


def first(sql: str, args={}):
    return db_session.execute(sql, args).first()
```

### DB Search Queries

Find tables with given column pattern:
```sql
select t.table_schema,
       t.table_name,
       c.column_name
  from information_schema.tables t
 inner join information_schema.columns c
    on c.table_name = t.table_name
   and c.table_schema = t.table_schema
 where c.column_name ilike '%last_action_ts%'
   and t.table_schema not in ('information_schema', 'pg_catalog')
   and t.table_type = 'BASE TABLE'
 order by t.table_schema;
```


### DB Management Queries

My currently running queries:
```sql
select pid,
       now() - pg_stat_activity.query_start as duration,
       state,
       quey
  from pg_stat_activity
 where usename = 'dtobar';
```


Stop a query:
```sql
select pg_cancel_backend(__pid__);
```

A force terminate that could lead to a database refresh:
```sql
-- select pg_terminate_backend(__pid__);
```

Idle queries:
```sql
select * from pg_stat_activity where state != 'idle';
```

Blocking queries (i think):
```sql
with active as (
        select
                pid,
                pg_blocking_pids(pid) as blocking_pids
        from pg_stat_activity
    where state = 'active'
                and usename not in ('rdsrepladmin', 'datadog-agent', 'kafka_connect_source', 'kafka_connect_sink')
                and age(now(), query_start) > '1 second'::interval
),
blocking_pids as (
    select
        elements as pid
    from active, unnest(active.blocking_pids) as elements
)
select
        pid,
        age(now(), query_start),
        usename,
        application_name,
        state,
        substring(regexp_replace(regexp_replace(query, '^\s+', '', 'g'), '[\r\n]+|\s{2,}', ' ', 'g'), 0, 80) || '...' as query,
        pg_blocking_pids(pid) as blocking_pids
from pg_stat_activity
where pid in (
        select pid from active
        union
        select pid from blocking_pids
    )
order by 2 desc;
```
