
exports.up = function(knex) {
    return knex.schema.createTable('category', function(table){
        table.increments('id');
        table.string('name_category').notNullable();
    });
};

exports.down = function(knex) {
    return knex.schema.dropTable('category');
};