module ActiveRecord
  module Tasks
    class PostgreSQLDatabaseTasks
      def drop
        raise "Nah, I won't drop the production database" if Rails.env.production?
        establish_master_connection
        connection.select_all "select pg_terminate_backend(pg_stat_activity.pid) from pg_stat_activity where datname='#{configuration['database']}';"
        connection.drop_database configuration['database']
      end
    end
  end
end
