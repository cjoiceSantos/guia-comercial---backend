
exports.up = function (knex) {
  return knex.schema.createTable('people', function (table) {
    table.increments('id')
    table.string('cpf')
    table.string('first_name')
    table.string('last_name')
    table.timestamp('birth_date')
    table.enu('gender', ['male', 'female', 'other'])
    table.timestamps()

    table.integer('user_id')
      .unsigned()
      .notNullable()

    table.foreign('user_id')
      .references('id')
      .inTable('user')
  })
};

exports.down = function (knex) {
  return knex.schema.dropTable('people')
};
