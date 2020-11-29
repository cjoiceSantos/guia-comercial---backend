
exports.up = function(knex) {
    return knex.schema.createTable('promotions', function(table){
        table.increments();
        table.date('start_date').notNullable();
        table.date('end_date').notNullable();
        table.decimal('coupon_amount').notNullable();
        table.decimal('coupon_count').notNullable();

        table.integer('company_id').unsigned().notNullable();
        table.foreign('company_id').references('id').inTable('company');
    });
};

exports.down = function(knex) {
    return knex.schema.dropTable('promotions');
};
