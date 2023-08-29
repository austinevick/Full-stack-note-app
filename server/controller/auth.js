const { PrismaClient } = require("@prisma/client");
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
const prisma = new PrismaClient();

const register = async (req, res) => {
    try {
        const { email, password, noteId } = req.body;
        if (!email || !password) {
            return res.status(400).json({
                status: 400,
                message: 'All fields are required'
            });
        }
        // check if user exist
        const userExist = await prisma.user.findUnique({
            where: {
                email: email
            }
        });
        if (userExist) {
            return res.status(200).json({
                status: 200,
                message: "User already exist."
            });
        }
        const hashedPassword = await bcrypt.hash(password, 8);
        const newUser = await prisma.user.create({
            data: {
                email: email,
                password: hashedPassword,
                noteId: parseInt(noteId)
            },
            select: {
                email: true,
                password: false
            }
        });
        const accessToken = jwt.sign({ newUser }, process.env.JWT_SECRET, { expiresIn: '1d' });
        return res.status(201).json({
            status: 201,
            message: "User Created",
            data: newUser,
            token: accessToken
        });

    } catch (error) {
        return res.status(400).json({
            status: 400,
            message: error.message
        });
    }
};

const login = async (req, res) => {
    try {
        const { email, password } = req.body;
        if (!email || !password) {
            return res.status(400).json({
                status: 400,
                message: 'All fields are required'
            });
        }
        // check if user exist
        const userExist = await prisma.user.findUnique({
            where: {
                email: email
            },
            select: {
                email: true,
                password: false
            }
        });
        if (!userExist) {
            return res.status(404).json({
                status: 404,
                message: "User does not exist."
            });
        }
        const match = await bcrypt.compare(password, userExist.password);
        if (!match) {
            return res.status(401).json({
                status: 401,
                message: "Unauthorized"
            });
        }
        const accessToken = jwt.sign({ userExist }, process.env.JWT_SECRET, { expiresIn: '10s' });
        return res.status(201).json({
            status: 201,
            message: "Login successful",
            data: userExist,
            token: accessToken
        });
    } catch (error) {
        return res.status(400).json({
            status: 400,
            message: error.message
        });
    }
};


module.exports = {
    register, login
};