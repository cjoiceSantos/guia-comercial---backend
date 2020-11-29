
exports.up = function(knex) {
    return knex.schema.createTable('address', function(table){
        table.increments();
        table.string('locality').notNullable();
        table.decimal('number').notNullable();
        table.string('complements').notNullable();
        table.string('city').notNullable();
        table.string('uf',2).notNullable();
        
        table.integer('company_id').unsigned().notNullable();
        table.foreign('company_id').references('id').inTable('company');
    });
};

exports.down = function(knex) {
    return knex.schema.dropTable('address');
};