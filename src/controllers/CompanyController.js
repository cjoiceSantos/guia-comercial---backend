const connection = require('../database/connection');
const bcrypt = require('bcrypt');

module.exports = {

    async insert(request, response) {
        const image_name = request.file.filename;
        const { body } = request

        const {
            cnpj,
            name,
            description,
            instagram,
            whatsapp,
            category_id,
            locality, number, city, uf,
            email,
            password,
        } = body;

        try {
            const evaluation = 0;
            const complements = '';
            const category = await connection('category').where('id', category_id).select('*').first();

            if (!category) {
                return response.status(404).json({ error: 'No category with this ID' })
            }

            const [user_id] = await connection('user')
                .insert({
                    email,
                    password: bcrypt.hashSync(password, 10),
                    created_at: new Date(),
                    updated_at: new Date(),
                })

            if (!user_id) {
                return response.status(404).json({ error: 'User cannot be created!' })
            }

            const [company_id] = await connection('company').insert({
                cnpj,
                name,
                description,
                evaluation,
                instagram,
                whatsapp,
                image_name,
                user_id
            });

            await connection('company_category')
                .insert({ company_id, category_id });

            await connection('address')
                .insert({
                    locality,
                    number,
                    complements,
                    city,
                    uf,
                    company_id
                });

            return response.json({
                cnpj,
                name,
                instagram,
                whatsapp,
                email,
                password,
                category_id,
                image_name,
                address: {
                    locality, number, complements, city, uf
                },
                user: {
                    id: user_id,
                    email,
                }
            });
        }
        catch (err) {
            return response.status(500)
                .json({ error: err })
        }
    },


    async index(request, response) {
        const { page = 1 } = request.query;
        const [count] = await connection('company').count();
        const company = await connection('company')
            .join('company_category', 'company_category.company_id', '=', 'company.id')
            .join('category', 'category.id', '=', 'company_category.category_id')
            .join('address', 'address.company_id', '=', 'company.id')
            .join('user', 'user.id', '=', 'company.user_id')
            .limit(9) //mostra 5 registros
            .offset((page - 1) * 9) //busca com paginação 5 em 5 registros
            .select(['company.*', 'category.name_category', 'address.*', 'user.email']);

        response.header('X-Total-Count', count['count(*)']);
        return response.json(company);
    },

    async delete(request, response) {
        const user_id = request.headers.authorization;
        const id = request.params.id;

        const company = await connection('company').where({ 'id': id, 'user_id': user_id }).select('id').first();

        if (!company) {
            return response.status(404).json({ error: 'No Company with this ID' });
        }

        await connection('address').where({ 'company_id': id }).delete();
        await connection('company_category').where({ 'company_id': id }).delete();
        await connection('company').where({ 'id': id, 'user_id': user_id }).delete();
        response.status(200).send("Company deleted with sucess");
    },

    async update(request, response) {
        const user_id = request.headers.authorization;
        const id = request.params.id;

        const { cnpj,
            name,
            description,
            instagram,
            whatsapp,
            email,
            locality,
            number,
            complements,
            city,
            uf
        } = request.body;

        const company = await connection('company').where({ 'id': id, 'user_id': user_id }).select('*').first();

        if (!company) {
            return response.status(404).json({ error: 'No Company with this ID' });
        }

        await connection('company')
            .where({ 'id': id, 'user_id': user_id })
            .update({
                cnpj,
                name,
                description,
                instagram,
                whatsapp,
                email
            });

        await connection('address')
            .where('company_id', id)
            .update({
                locality,
                number,
                complements,
                city,
                uf
            });

        return response.status(200).send("Company updated with sucess");
    },



}
