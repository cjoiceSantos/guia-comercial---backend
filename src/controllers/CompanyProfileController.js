const connection = require('../database/connection');

module.exports = {

    async listForCategory(request, response){
    const id = request.params.id;
    const {page = 1} = request.query;
    const count = await connection('company').count();

    const category = await connection('category').select('*').where('id', id).first();
    if(!category){
        return response.status(404).json({error: 'No categories found with this ID'});
    }  

    const companies = await connection('company')
        .join('company_category', 'company_category.company_id','=', 'company.id')
        .join('category', 'category.id','=','company_category.category_id')
        .join('address','address.company_id','=','company.id')
        .where('company_category.category_id', id)
        .limit(9) //mostra 5 registros
        .offset((page-1)*9) //busca com paginação 5 em 5 registros
        .select(['company.*', 'category.name_category','address.*']);

    response.header('X-Total-Count', count['count(*)']);
    return response.json(companies);
    },

    async listForEvaluation(request, response) {
        const {page = 1} = request.query;
        const count = await connection('company').count();

        const companies = await connection('company')
            .join('company_category', 'company_category.company_id','=', 'company.id')
            .join('category', 'category.id','=','company_category.category_id')
            .join('address','address.company_id','=','company.id')
            .join('user', 'user.id', '=', 'company.user_id')
            .limit(9) //mostra 5 registros
            .offset((page-1)*9) //busca com paginação 5 em 5 registros
            .select(['company.*', 'category.name_category','address.*', 'user.first_name', 'user.surname'])
            .orderBy('company.evaluation', 'desc');

        response.header('X-Total-Count', count['count(*)']);
        return response.status(200).json(companies);
    },

    async listBySearchTerm(request, response){
        const {page = 1} = request.query;
        const count = await connection('company').count();
        const term = request.params.term;

        const companies = await connection('company')
            .join('company_category', 'company_category.company_id','=', 'company.id')
            .join('category', 'category.id','=','company_category.category_id')
            .join('address','address.company_id','=','company.id')
            .join('user', 'user.id', '=', 'company.user_id')
            .where('company.name', 'like', `%${term}%`)
            .limit(9) //mostra 5 registros
            .offset((page-1)*9) //busca com paginação 5 em 5 registros
            .select(['company.*', 'category.name_category','address.*', 'user.first_name', 'user.surname'])
          

        response.header('X-Total-Count', count['count(*)']);
        return response.status(200).json(companies);

    },

    async evaluateCompany(request, response){
        const {evaluation} = request.body;
        const {id} = request.params;
        const user_id = request.headers.authorization;

        const company = await connection('company')
            .where({id, 'user_id' : user_id})
            .select('*')
            .first();
        
            if(!company){
            return response.status(404).json({error : 'Company not found'});
        }

        await connection('company')
            .where({id, 'user_id' : user_id})
            .update({
                evaluation
            });

        return response.status(200).send('Company updated with sucess');
    },
    
}

