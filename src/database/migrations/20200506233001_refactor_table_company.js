
exports.up = function(knex) {
    return knex.schema.table('company', function (table) {
        table.string('image_name').notNullable();
    })
};

exports.down = function(knex) {
    return knex.schema.table('company', function (table){
        table.dropColumn('image_name');
    })
};
