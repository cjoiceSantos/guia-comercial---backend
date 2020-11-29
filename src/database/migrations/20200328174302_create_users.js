
exports.up = function(knex) {
    return knex.schema.createTable('user', function(table){
        table.increments('id');
        table.string('cpf').notNullable();
        table.string('first_name').notNullable();
        table.string('surname').notNullable();
        table.date('date_of_birth');
        table.string('sexo').notNullable();
        table.boolean('have_company')
        
    });
};

exports.down = function(knex) {
    return knex.schema.dropTable('user');7
};