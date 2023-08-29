const { PrismaClient } = require("@prisma/client");

const prisma = new PrismaClient();

const createNote = async (req, res) => {
    try {
        console.log(req.body);

        const data = await prisma.note.create({
            data: req.body
        });
        return res.status(201).json({
            status: 201,
            message: 'success',
            data: data
        });
    } catch (error) {
        return res.status(400).json({
            status: 400,
            message: error.message
        });
    }
};

const getNotes = async (req, res) => {
    try {
        const data = await prisma.note.findMany({});
        return res.status(200).json({
            status: 200,
            message: 'success',
            data: data
        });
    } catch (error) {
        return res.status(400).json({
            status: 400,
            message: error.message
        });
    }
};


const updateNote = async (req, res) => {
    try {
        console.log(req.body);
        const data = await prisma.note.update({
            where: {
                id: parseInt(req.params.id)
            },
            data: req.body
        });
        return res.status(200).json({
            status: 200,
            message: 'success',
            data: data
        });
    } catch (error) {
        return res.status(400).json({
            status: 400,
            message: error.message
        });
    }
};

const deleteNote = async (req, res) => {
    try {
        await prisma.note.delete({
            where: {
                id: parseInt(req.params.id)
            },
        });
        return res.status(200).json({
            status: 200,
            message: 'success',
        });
    } catch (error) {
        return res.status(400).json({
            status: 400,
            message: error.message
        });
    }
};


module.exports = {
    createNote,
    getNotes,
    updateNote,
    deleteNote
};