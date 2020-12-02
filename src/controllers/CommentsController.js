const connection = require('../database/connection');

module.exports = {

    async insert(request, response){
        const {text_comment} = request.body;
        const {company_id} = request.params;
        const person_id = request.headers.authorization;
    
        const company = await connection('company')
            .where({'id' : company_id})
            .select('id')
            .first();
        
        if(!company){
            return response.status(404).json({error : 'Error comment'});
        }

        const [id] = await connection('comments')
            .insert({
                text_comment,
                'person_id': person_id,
                company_id
            });
        return response.status(200).send("Comments register with sucess");
    },

    async index(request, response){
        const company_id = request.params.company_id;
        const {page = 1} = request.query;
        const [count] = await connection('comments').count();

        const company = await connection('company')
            .where('id', company_id)
            .select('id')
            .first();
        
        if(!company){
            return response.status(404).json({error : 'Error comment'});
        }

        const comments = await connection('comments')
            .join('people', 'people.user_id', '=', 'comments.person_id') 
            .limit(4) 
            .offset((page-1)*4)
            .select(['comments.*'])
            .where('company_id', company_id);

        response.header('X-Total-Count', count['count(*)']);
        return response.json(comments);
    },

    async delete(request, response){
        const {company_id, id} = request.params;
        const user_id = request.headers.authorization;

        const comment = await connection('comments')
            .where({id, company_id, 'user_id' : user_id })
            .select('*')
            .first();
        
        if(!comment){
            return response.status(404).json({error : 'Comment not found'});
        }

        await connection('comments').where({id, company_id, 'user_id' : user_id }).delete();
        return response.status(200).send("Comment removided")
    },

   

}