
exports.up = function (knex) {
  return knex.schema.table('comments', function (table) {
    table.dropForeign('user_id')

    table.renameColumn('user_id', 'person_id')

    table.foreign('person_id')
      .references('id')
      .inTable('people')
  })
};

exports.down = function (knex) {
  return knex.schema.table('comments', function (table) {
    table.dropForeign('person_id')
    table.renameColumn('person_id', 'user_id')
    table.foreign('user_id')
      .references('id')
      .inTable('user')

  })
};
