# Introduce

This gem will deserialize `LineString` and `MultiLineString` from MySQL using `rgeo` gem.

# Install

```rb
gem 'schedule_as_geometry', github: 'go-staffhive/schedule-as-geometry', branch: 'main'
```

## Usage

- hook `quoting` to `active_record`

```rb
initializer 'active_record.override_mysql_adapter' do
  ActiveSupport.on_load(:active_record) do
    ActiveRecord::ConnectionAdapters::AbstractMysqlAdapter.include ScheduleAsGeometry::ActiveRecord::ConnectionAdapters::MySQL::QuotingOverride
  end
end
```

- include module to model

```rb
class MyModel < ApplicationRecord
  include ScheduleAsGeometry::ActAsLinestringSchedule
end
```

- make column as schedule

```rb
schedule_multi_linestring :schedule # if multi linestring

schedule_linestring :schedule # if linestring
```
