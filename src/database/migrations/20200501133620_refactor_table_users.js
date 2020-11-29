
exports.up = function (knex) {
  return knex.schema.table('user', function (table) {
    table.dropColumn('cpf')
    table.dropColumn('first_name')
    table.dropColumn('surname')
    table.dropColumn('date_of_birth')
    table.dropColumn('sexo')
    table.dropColumn('have_company')

    table.string('email')
    table.string('password')
    table.boolean('email_validated')
      .defaultTo(false)
    table.timestamps()
  })
};

exports.down = function (knex) {
  return knex.schema.table('user', function (table) {
    table.dropColumn('email')
    table.dropColumn('password')
    table.dropColumn('email_validated')
    table.dropColumn('created_at')
    table.dropColumn('updated_at')

    table.string('cpf').notNullable();
    table.string('first_name').notNullable();
    table.string('surname').notNullable();
    table.date('date_of_birth');
    table.string('sexo').notNullable();
    table.boolean('have_company')
  })
};
