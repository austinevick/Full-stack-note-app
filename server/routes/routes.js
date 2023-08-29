const express = require('express');
const { getNotes, createNote, updateNote, deleteNote } = require('../controller/note');
const { register } = require('../controller/auth');
const verifyJWT = require('../middleware/verify_jwt');
const router = express.Router();


// User routes
router.route('/user').post(register);

// notes routes
// router.use(verifyJWT).get('/notes', getNotes);
// router.use(verifyJWT).post('/notes', createNote);
// router.use(verifyJWT).put('/notes/:id', updateNote);
// router.use(verifyJWT).delete('/notes/:id', deleteNote);
// notes routes
router.get('/notes', getNotes);
router.post('/notes', createNote);
router.put('/notes/:id', updateNote);
router.delete('/notes/:id', deleteNote);


module.exports = router;