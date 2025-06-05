import express from 'express';
import bcrypt from 'bcrypt';
import { createUser, getUserByEmail } from './database.js';

const app = express();
app.use(express.json());
import {addUser} from './database.js'



app.use((err, req, res, next) => { 
console.error(err.stack) 
res.status(500).send('Something broke!') 
}) 
app.listen(3000, () => { 
console.log('Server is running on port 3000')
})