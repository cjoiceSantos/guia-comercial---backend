
exports.up = function(knex) {
    return knex.schema.table('promotions', function (table) {
        table.string('title').notNullable();
        table.decimal('value_real').notNullable();
        table.decimal('value_discount').notNullable();
    });
};

exports.down = function(knex) {
    return knex.schema.table.dropColumns('title','value_real','value_discount');
};
