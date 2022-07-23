require 'newrelic_rpm'

# HACK:
#   * requireするだけで使えるようにMysql2::Clientにモンキーパッチを当てる
module Mysql2
  class Client
    alias_method :original_query, :query

    NR_NOTICE_STATEMENTS = %i(select insert update delete begin commit rollback truncate REPLACE)
    NR_NOTICE_STATEMENTS_REGEX = /#{NR_NOTICE_STATEMENTS.join('|')}/i

    # TODO: 競技時にテーブル名を追記する
    NR_NOTICE_TABLES = %i(tenant id_generator visit_history2)
    NR_NOTICE_TABLES_REGEX = /#{NR_NOTICE_TABLES.join('|')}/i

    # XXX:
    #   * 問題によってはMySQLのserverside prepareを使っているので注意
    #   * mysql2-cs-bindとかに全部置き換えて負荷をapp側に寄せることを考えた方が良いかも
    def query(sql, *args)
      callback = -> (result, metrics, elapsed) do
        NewRelic::Agent::Datastores.notice_sql(sql, metrics, elapsed)
      end

      statement = sql[NR_NOTICE_STATEMENTS_REGEX] || 'other'
      table = sql[NR_NOTICE_TABLES_REGEX] || 'other'
      NewRelic::Agent::Datastores.wrap('MySQL', statement, table, callback) do
        original_query(sql, *args)
      end
    end
  end
end
