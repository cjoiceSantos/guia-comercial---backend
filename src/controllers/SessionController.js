const connection = require('../database/connection');

module.exports = {
    //Autenticação do usuário
    async create(request, response){
        const { id } = request.body;
        //senha 
        const user = await connection('user').where('id', id ).select('name').first();

        if(!user) {
            return response.status(400).json({error: 'No User found with this ID'});
        }
        return response.json(user);
    }
}