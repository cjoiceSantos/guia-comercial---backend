const connection = require('../database/connection');

module.exports = {

    async insert(request, response){
        const { name_category } = request.body;
        const image_name  = request.file.filename;

        const [id] = await connection('category').insert({
            name_category,
            image_name
        });
        return response.json(id);
    },
    
    //com paginação - 9 por página
    async index(request, response){
        const {page = 1} = request.query;
        const [count] = await connection('category').count();

        const category = await connection('category')
            .limit(6) 
            .offset((page-1)*6) 
            .select('*');

        response.header('X-Total-Count', count['count(*)']);
        return response.json(category);
    },

    async delete(request, response){
        const { id } = request.params;  
        const category = await connection('category').where('id',id).select('*').first();
        
        if (!category){
            return response.status(404).json({error: 'No category with this ID'});  
        }
        
        await connection('category').where('id',id).delete();
        response.status(200).send("category deleted with sucess");
    },

}