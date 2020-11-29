
exports.up = function(knex) {
    return knex.schema.createTable('company', function(table){
        table.increments('id');
        table.string('cnpj').notNullable();
        table.string('name').notNullable();
        table.string('description').notNullable();
        table.decimal('evaluation').notNullable();
        table.string('instagram').notNullable();
        table.string('whatsapp').notNullable();
        table.string('email').notNullable();

        table.integer('user_id').unsigned().notNullable();
        table.foreign('user_id').references('id').inTable('user');
    });
};

exports.down = function(knex) {
  return knex.schema.dropTable('company');
};