const connection = require('../database/connection');

module.exports = {

    async insert(request, response) {
        const { cpf, first_name, surname, date_of_birth, sexo, have_company } = request.body;

        const [id] = await connection('user').insert({
            cpf,
            first_name,
            surname,
            date_of_birth,
            sexo,
            have_company
        });

        if (!id) {
            return response.status(404).json({ error: "Error when registering user" });
        }
        return response.status(200).json(id);
    },

    async delete(request, response) {
        const id = request.headers.authorization;
        const user = await connection('user').where('id', id).select('*').first();

        if (!user) {
            return response.status(404).json({ error: 'No User with this ID' });
        }

        await connection('user').where('id', id).delete();
        response.status(200).send("User deleted with sucess");
    },

    async update(request, response) {
        const id = request.headers.authorization;
        const { cpf, first_name, surname, date_of_birth, sexo } = request.body;

        const user = await connection('user').where('id', id).select('*').first();

        if (!user) {
            return response.status(404).json({ error: 'No user with this ID' });
        }

        await connection('user')
            .where('id', id)
            .update({
                cpf,
                first_name,
                surname,
                date_of_birth,
                sexo
            });

        return response.status(200).send("user updated with sucess");
    },

    async updateHave_Company(request, response) {
        const id = request.headers.authorization;
        const { have_company } = request.body;

        const user = await connection('user').where('id', id).select('*').first();

        if (!user) {
            return response.status(404).json({ error: 'No user with this ID' });
        }
        await connection('user')
            .where('id', id)
            .update({
                have_company
            });
        return response.status(200).send('Update have_company with sucess');
    },

    async index(request, response) {
        const users = await connection('user').select('*');
        return response.json(users);
    }

}
