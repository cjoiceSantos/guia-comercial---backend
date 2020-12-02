
exports.up = function(knex) {
    return knex.schema.table('category', function (table) {
        table.string('image_name')
    });
};

exports.down = function(knex) {
    return knex.schema.table('category', function (table){
        table.dropColumn('image_name');
    });
};
