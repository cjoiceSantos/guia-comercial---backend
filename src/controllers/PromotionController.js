const connection = require('../database/connection');

module.exports = {
    async insert(request, response){
        const {start_date, end_date, coupon_amount, coupon_count, title, value_real, value_discount } = request.body;
        const company_id = request.params.company_id; 
        const user_id = request.headers.authorization;

        const company = await connection('company')
            .where({'id' : company_id, 'user_id' : user_id})
            .select('*')
            .first();
        if(!company){
            return response.status(404).json({error: 'User has no company with that ID'}); 
        }

        const [id] = await connection('promotions').insert({
            start_date, 
            end_date, 
            coupon_amount,
            coupon_count,
            title, 
            value_real, 
            value_discount, 
            'company_id' : company_id
        });
        return response.json(id);
    },
    
    //com paginação - 9 por página
    async index(request, response){
        const {page = 1} = request.query;
        const [count] = await connection('promotions').count();

        const promotions = await connection('promotions')
            .join('company', 'company.id', '=', 'promotions.company_id')
            .limit(9) //mostra 5 registros
            .offset((page-1)*9) //busca com paginação 5 em 5 registros
            .select(['promotions.*', 'company.name', 'company.evaluation'])

        response.header('X-Total-Count', count['count(*)']);
        return response.json(promotions);
    },

    async listForCompany(request, response){
        const company_id = request.params.company_id;
        const user_id = request.headers.authorization;
        const {page = 1} = request.query;
        const [count] = await connection('promotions').count();

        const company = await connection('company')
            .where({'id' : company_id, 'user_id' : user_id})
            .select('*')
            .first();
        if(!company){
            return response.status(404).json({error: 'User has no company with that ID'}); 
        }

        const promotions = await connection('promotions')
            .join('company', 'company.id', '=', 'promotions.company_id') 
            .limit(9) //mostra 5 registros
            .offset((page-1)*9) //busca com paginação 5 em 5 registros
            .select(['promotions.*', 'company.name', 'company.evaluation'])
            .where({'company_id' : company_id});

        response.header('X-Total-Count', count['count(*)']);
        return response.json(promotions);
    },

    async delete(request, response){
        const { company_id , id } = request.params;
        const user_id = request.headers.authorization;

        const promotion = await connection('promotions')
            .join('company', 'company.id','=','promotions.company_id')
            .where({
                'promotions.id':id, 
                'promotions.company_id':company_id, 
                'company.user_id':user_id
            }).select('promotions.*').first();
            
        if (!promotion){
            return response.status(404).json({error: 'No promotion with this ID'});  
        }
        //rever a questao de verificar o hearder,authorization
        await connection('promotions')
            .join('company', 'company.id','=','promotions.company_id')
            .where({
                'promotions.id' : id, 
                'promotions.company_id' : company_id 
            }).delete();
            
        return response.status(200).send("Promotion deleted with sucess");
       
    },

    async update(request, response){
        const { company_id , id } = request.params;
        const user_id = request.headers.authorization; 
        const {start_date, end_date, coupon_amount, coupon_count} = request.body;

        const promotion = await connection('promotions')
            .join('company', 'company.id','=','promotions.company_id')
            .where({
                'promotions.id':id, 
                'promotions.company_id':company_id, 
                'company.user_id':user_id
            }).select('promotions.*').first();
            
        if (!promotion){
            return response.status(404).json({error: 'No promotion with this ID'});  
        }
        
        await connection('promotions')
           .where({
                'id':id, 
                'company_id':company_id
            })
            .update({
                start_date, 
                end_date, 
                coupon_amount,
                coupon_count      
        });
        return response.status(200).send("Promotion updates with sucess");
    }

}