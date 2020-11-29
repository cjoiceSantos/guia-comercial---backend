
exports.up = function(knex) {
    return knex.schema.createTable('company_category', function(table){
        table.integer('company_id').unsigned().notNullable();
        table.integer('category_id').unsigned().notNullable();
        
        table.foreign('company_id').references('id').inTable('company');
        table.foreign('category_id').references('id').inTable('category');
    });
};

exports.down = function(knex) {
    return knex.schema.dropTable('company_category');
};