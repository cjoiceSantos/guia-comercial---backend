
exports.up = function (knex) {
  return knex.schema.table('company', function (table) {
    table.dropColumn('email')
    table.timestamps()
  })
};

exports.down = function (knex) {
  return knex.schema.table('company', function (table) {
    table.dropColumn('created_at')
    table.dropColumn('updated_at')
    table.string('email')
  })
};
