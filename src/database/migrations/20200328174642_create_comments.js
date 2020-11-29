
exports.up = function(knex) {
    return knex.schema.createTable('comments', function(table){
        table.increments('id');
        table.string('text_comment').notNullable();
        table.integer('user_id').unsigned().notNullable();
        table.integer('company_id').unsigned().notNullable();

        table.foreign('user_id').references('id').inTable('user');
        table.foreign('company_id').references('id').inTable('company');
    });
};

exports.down = function(knex) {
    return knex.schema.dropTable('comments');
};